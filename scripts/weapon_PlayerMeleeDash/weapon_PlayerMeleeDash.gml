/// Weapon : Player Melee Dash

function weapon_PlayerMeleeDash(_owner = noone) : weapon_Base(_owner) constructor
{
	// Variables
	setCharge(1.6);
	
	spdMin = 10000;
	spdMax = 10000;
	
	distance = 60;
	hitList = [];
	hitTime = 0;	// checks if any of the hit targets are still alive after a few frames; if not, count as on kill and restore Shield
	shieldRestore = 2;
	
	
	// Methods
	static use = function()
	{
		// Get inputted direction
		var axis = input_xy("left", "right", "up", "down");
		var dir = point_direction(0, 0, axis.x, axis.y);
		
		// Proc onShoot
		owner.procOnShoot();
		
		owner.removeStatus("fireLaser");
		
		// Set collision damage equal to remaining Shield (min. 3)
		owner.collisionDamage = max(floor(owner.shield), 3);
			
		// Regain shield on collision
		owner.addStatus("meleeDash");
			
		// Dash in inputted direction
		var move = 3;	// cut down required iterations by x
		for (var i = 0; i < distance / move; i++)
		{
			owner.x += dcos(dir) * move;
			owner.y -= dsin(dir) * move;
			
			// Force collision checks
			owner.collisionWithShips();
			owner.collisionWithBullets();
			owner.collisionWithLasers();
			owner.collisionWithRings();
			
			// Create particles
			if (i mod 3 == 0) add_particle(owner.x, owner.y, random_range(0, 360), random_range(0.1, 0.15), 2, 0, random_range(0.4, 0.8), owner.color);
		}
		hitTime = 2;
		
		// Reset collision damage to 2
		owner.collisionDamage = 2;
		
		// Reset weaponInUse
		owner.removeStatus("meleeDash");
		owner.weaponInUse = noone;
	}
	
	
	static draw = function()
	{
		// Draw aim line
		if (owner.weaponInUse != self and charge >= chargeMax)
		{
			var axis = input_xy("left", "right", "up", "down");
			var dir = point_direction(0, 0, axis.x, axis.y);
			var len = distance;
			var c = COLORS.p8_white;
			draw_set_alpha(0.4);
			draw_line_color(owner.x, owner.y, owner.x + dcos(dir) * len, owner.y - dsin(dir) * len, c, c);
			draw_set_alpha(1);
		}
		
		
		// Shield restoration on kills
		if (hitTime > 0)
		{
			hitTime--;
			
			// Check for kills
			for (var i = array_length(hitList) - 1; i >= 0; i--)
			{
				if (!instance_exists(hitList[i]))
				{
					// Restore shield
					if (owner.shield < owner.shieldMax)
					{
						owner.shield = min(owner.shield + shieldRestore, owner.shieldMax);
						if (owner.id == HUD.statBarDisplay.ship) create_popup(HUD.statBarDisplay.shieldStart + 12 + (HUD.statBarDisplay.shieldMax * 3), HUD.statBarDisplay.yStart, $"+{shieldRestore}", COLORS.p8_blue, 1.5, 0.075);
					}
					
					array_delete(hitList, i, 1);
				}
			}
		}
		else hitList = [];
	}
}