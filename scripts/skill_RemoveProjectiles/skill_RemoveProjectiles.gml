/// Skill : Remove Projectiles

function skill_RemoveProjectiles(_owner = noone) : skill_Base(_owner) constructor
{
	// Variables
	setCharge(7);
	
	ring = noone;
	duration = 1.5;
	radius = 35;
	
	
	// Methods
	static use = function()
	{
		// Create ring
		ring = owner.fireRing([], owner.x, owner.y, radius, 1, duration);
		ring.proc = false;
		ring.dotted = true;
		// ring.displayDamageNumber = false;
	}
	
	
	static step = function()
	{
		if (instance_exists(ring))
		{
			// Get projectiles inside the field
			var collisions = ds_list_create();
			var count = 0;
			with (ring) { count = instance_place_list(x, y, obj_Bullet, collisions, false); }
				
			// Loop through enemy projectiles inside and destroy them
			for (var c = 0; c < count; c++)
			{
				var _proj = collisions[| c];
				if (_proj.team != owner.team)
				{
					_proj.destroy();
				}
			}
		}
		
		else
		{
			// Reset skillInUse
			owner.skillInUse = false;
		}
	}
}