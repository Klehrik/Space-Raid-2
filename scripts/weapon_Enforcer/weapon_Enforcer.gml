/// Weapon : Enforcer

function weapon_Enforcer(_owner = noone) : weapon_Base(_owner) constructor
{
	// Variables
	spdMin = 1.2;
	spdMax = 1.2;
	spdDegradation = 0.01;
	count = 3 + DIFFICULTY;
	size = 0;
	damage = 1;
	
	chargeMax = 2.5;
	
	fireCharge = 0;
	fireChargeMax = 1 - (0.2 * DIFFICULTY);	// in seconds; charge before use
	delay = 0;
	delayMax = 0.05;	// in seconds; fire rate of the gun
	shotsFired = 0;
	offset = 18;		// offset of other lines from each other
	extraLines = 2 + DIFFICULTY;		// how many lines per side of the center
	
	
	// Methods
	static use = function()
	{
		if (!instance_exists(owner)) return;
		
		// Proc onShoot
		owner.procOnShoot();
		
		// Restrict movement
		owner.canMove = false;
	}
	
	
	static step = function()
	{
		if (owner.weaponInUse == self)
		{	
			fireCharge++;
			if (fireCharge >= fireChargeMax * room_speed)
			{
				// Shoot gun
				if (shotsFired < count)
				{
					delay += 1/room_speed;
					if (delay >= delayMax)
					{
						delay = 0;
						shotsFired++;
						
						var spd = spdMin;
						var proj = owner.fireBullet([], owner.image_angle, spd, size, damage);
						proj.spdDegradation = spdDegradation;
						for (var i = 1; i <= extraLines; i++)
						{
							var proj = owner.fireBullet([], owner.image_angle + (offset * i), spd, size, damage);
							proj.spdDegradation = spdDegradation;
							var proj = owner.fireBullet([], owner.image_angle - (offset * i), spd, size, damage);
							proj.spdDegradation = spdDegradation;
						}
						
						// Small recoil
						var vec = (new vec2(0.3)).setDir(owner.image_angle - 180);
						owner.kbVec = owner.kbVec.add(vec);
					}
				}
				
				// End shooting
				else
				{
					fireCharge = 0;
					shotsFired = 0;
					
					// Reset weaponInUse
					owner.weaponInUse = noone;
					owner.canMove = true;
				}
			}
			else
			{
				// Ship flash
				owner.flash = 1;
				
				// Create charging particles
				if (fireCharge mod 10 == 0) add_particle(owner.getFront().x, owner.getFront().y, random_range(0, 360), random_range(0.1, 0.15), 2, 1, random_range(0.4, 0.8), COLORS.p8_white);
			}
		}
	}
}