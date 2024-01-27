/// Item : Hull Shrapnel

function item_HullShrapnel(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Hull Shrapnel";
	index = 16;
	rarity = 0;
	
	count = 6;
	amount = 1;
	minSpeed = 1.2;
	maxSpeed = 1.6;
	spread = 30;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		count = 12;
	}
	
	description = $"On taking Hull damage, fire {count} projectiles outwards for {amount} damage each.";
	
	
	// Methods
	static onLosingHull = function(proj)
	{
		repeat (count)
		{
			var dir = proj.direction;
			if (proj.object_index == obj_Ring) dir = point_direction(proj.x, proj.y, owner.x, owner.y);
			
			var spd = random_range(minSpeed, maxSpeed);
			var _proj = owner.fireBullet([], dir - 180 + random_range(-spread/2, spread/2), spd, choose(0, 1), amount);
			_proj.spdDegradation = 0.015;
		}
	}
}