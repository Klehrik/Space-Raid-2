/// Item : EM Field

function item_EMField(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "EM Field";
	index = 18;
	rarity = 2;
	
	amount = 0.4;
	duration = 4;
	radius = 35;
	rings = [];
	
	description = $"On kill, spawn a field that lasts for {duration} seconds, slowing enemies by {round(amount * 100)}%.";
	
	
	// Methods
	static onKill = function(proj, hit)
	{
		var ring = owner.fireRing([], hit.x, hit.y, radius, 0, duration);
		ring.proc = false;
		ring.dotted = true;
		ring.displayDamageNumber = false;
		array_push(rings, ring);
	}
	
	
	static step = function()
	{
		// Probably the longest written item so far
		
		for (var i = array_length(rings) - 1; i >= 0; i--)
		{
			var ring = rings[i];
			if (instance_exists(ring))
			{
				// Get ships inside the field
				var collisions = ds_list_create();
				var count = 0;
				with (ring) { count = instance_place_list(x, y, obj_Ship, collisions, false); }
				
				// Loop through enemy ships inside and apply debuff
				for (var c = 0; c < count; c++)
				{
					var _ship = collisions[| c];
					if (_ship.team != owner.team)
					{
						_ship.removeStatus("slowField");
						
						var stat = _ship.speedStat;
						stat.scale -= amount;
						
						_ship.addStatus("slowField", 0.05, function(ship)
						{
							var stat = ship.speedStat;
							stat.scale += amount;
						});
					}
				}
			}
			else array_delete(rings, i, 1);
		}
	}
}