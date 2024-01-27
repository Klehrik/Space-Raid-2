/// Item : Junior

function item_Junior(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Junior";
	index = 4;
	rarity = 2;
	
	description = $"Summon a drone at the start of every level that inherits all your items.";
	
	
	// Methods	
	static onLevelStart = function()
	{
		var dir = random_range(0, 360);
		var dist = owner.size + 4;
		var _x = owner.x + (dcos(dir) * dist);
		var _y = owner.y - (dsin(dir) * dist);
		
		var drone = create_ship(_x, _y, "itemDrone");
		
		// Set drone team
		drone.setTeam(owner.team);
		
		// Give drone half the stats of the owner
		drone.setMaxHealth(ceil(owner.hpMax / 2));
		drone.setMaxShield(ceil(owner.shieldMax / 2));
		
		// Inherit items
		for (var i = 0; i < array_length(owner.items); i++)
		{
			var _item = owner.items[i];
			
			// Prevent inheriting this item itself
			if (_item.index != index)
			{
				drone.pickupItem(create_item(_item.index));
			}
		}
		
		// Create particles
		repeat (12) add_particle(_x, _y, random_range(0, 360), random_range(0.15, 0.25), choose(1, 2), 0, random_range(0.6, 1), owner.color);
	}
}