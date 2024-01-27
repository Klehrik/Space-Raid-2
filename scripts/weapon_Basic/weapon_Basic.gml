/// Weapon : Basic

// Base weapon class for basic weapons that just shoot bullets on weapon use and nothing else

function weapon_Basic(_owner = noone) : weapon_Base(_owner) constructor
{
	// Variables
	spdMin = 0;
	spdMax = 0;
	spdDegradation = 0;
	count = 1;
	size = 0;
	damage = 1;
	spread = 0;		// total cone in degrees
	
	
	// Methods
	static use = function()
	{
		if (!instance_exists(owner)) return;
		
		// Proc onShoot
		owner.procOnShoot();
		
		// Fire bullet(s)
		// or laser(s) with Accelerator
		if (!owner.hasStatus("fireLaser"))
		{
			repeat (count)
			{
				var proj = owner.fireBullet([], owner.image_angle + random_range(-spread/2, spread/2), random_range(spdMin, spdMax), size, damage);
				proj.spdDegradation = spdDegradation;
			}
		}
		else
		{
			owner.removeStatus("fireLaser");
			
			var dir = owner.image_angle;
			
			// Aim at target if there is one
			if (instance_exists(owner.target))
			{
				var front = owner.getFront();
				dir = point_direction(front.x, front.y, owner.target.x, owner.target.y) + random_range(-spread/2, spread/2);
			}
			
			owner.fireLaser([], dir, damage);
		}
		
		// Reset weaponInUse
		owner.weaponInUse = noone;
	}
	
	
	static setSpeed = function(_min, _max = -1)
	{
		if (_max == -1) _max = _min;
		spdMin = _min;
		spdMax = _max;
	}
}