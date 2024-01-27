/// Weapon : Gunner

function weapon_Gunner(_owner = noone) : weapon_Base(_owner) constructor
{
	// Variables
	spdMin = 1 + (DIFFICULTY * 0.25);
	spdMax = 1 + (DIFFICULTY * 0.25);
	count = 9 + (3 * DIFFICULTY);
	size = 0;
	damage = 1;
	spread = 12;		// total cone in degrees
	
	chargeMax = 2.5 - (0.5 * DIFFICULTY);
	
	fireCharge = 0;
	fireChargeMax = 1 - (0.25 * DIFFICULTY);	// in seconds; charge before use
	delay = 0;
	delayMax = 0.1;		// in seconds; fire rate of the gun
	shotsFired = 0;
	
	
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
						
						owner.fireBullet([], owner.image_angle + random_range(-spread/2, spread/2), spdMin, size, damage);
						
						// Small recoil
						var vec = (new vec2(0.1)).setDir(owner.image_angle - 180);
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