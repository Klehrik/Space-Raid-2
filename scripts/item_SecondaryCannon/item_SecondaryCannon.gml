/// Item : Secondary Cannon

function item_SecondaryCannon(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Secondary Cannon";
	index = 1;
	rarity = 0;
	
	chance = 0.07;
	minSpeed = 1.6;
	maxSpeed = 2;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		chance = 0.15;
	}
	
	description = $"On weapon use, {round(chance * 100)}% chance to fire a bullet for 1 damage.";
	
	
	// Methods
	static onShoot = function()
	{
		if (roll(chance))
		{
			var dir = owner.image_angle;
			var spd = random_range(minSpeed, maxSpeed);
			
			// Aim ahead if there is a target
			if (instance_exists(owner.target))
			{
				var front = owner.getFront();
				var aim = calculate_aim_vector(front.x, front.y, spd, owner.target)
				if (aim != -1) dir = aim.dir();
			}
			
			owner.fireBullet([], dir, spd, 1);
		}
	}
}