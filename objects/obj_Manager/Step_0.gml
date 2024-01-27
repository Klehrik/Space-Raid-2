/// obj_Manager : Step

var _items = array_length(ITEMS) - 1;




if (instance_exists(player))
{
	// Pass player for displaying bottom stat bars
	HUD.passStats(player.id);
	
	// Pass player target for displaying target stats
	if (player.hasTarget()) HUD.passTargetStats(player.target);
	
	// Pass player for displaying items
	HUD.passItemList(player.items);
	
	// Pass player for drawing targeting line
	if (player.hasTarget()) BENEATH.setTargetingLine(player.id, player.target);
}
else HUD.statBarDisplay.hp = 0;


// testing
// Summon new wave
if (array_length(get_team_ships(2)) <= 0)
{
	level++;
	
	for (var j = 0; j < 4; j++)
	{
		create_ship(choose(ARENA.xStart + 8, ARENA.xEnd - 8) + random_range(-4, 4), choose(ARENA.yStart + 8, ARENA.yEnd - 8) + random_range(-4, 4), choose("basic", "basic", "gunner", "enforcer", "carrier"), 2, level);
		//create_ship(choose(ARENA.xStart + 8, ARENA.xEnd - 8) + random_range(-4, 4), choose(ARENA.yStart + 8, ARENA.yEnd - 8) + random_range(-4, 4), "meleeDrone", 2, level);
	}
	
	if (level > 1)
	{
		if (instance_exists(obj_Player))
		{
			repeat (2) { obj_Player.pickupItem(create_item(irandom_range(0, _items), choose(false, true))); }
			obj_Player.hp = obj_Player.hpMax;
			obj_Player.shield = obj_Player.shieldMax;
		}
		
		destroy_ships("itemDrone");
		instance_destroy(obj_Projectile);
		
		var blacklist = [4, 11, 14, 16];
		
		var _ind = -1;
		while (true)
		{
			_ind = irandom_range(0, _items);
			if (!array_contains(blacklist, _ind)) break;
		}
		
		array_push(enemyItems, _ind);
		array_push(enemyItemsUpg, choose(true, false));
		
		var enemies = get_team_ships(2);
		for (var j = 0; j < array_length(enemies); j++)
		{
			var ship = enemies[j];
			for (var i = 0; i < array_length(other.enemyItems); i++)
			{
				ship.pickupItem(create_item(other.enemyItems[i], other.enemyItemsUpg[i]));
			}
		}
	}
	
	with (obj_Ship) { procOnLevelStart(); }
}


// debug
if (instance_exists(obj_Player) and keyboard_check_pressed(ord("G")))
{
	for (var i = 0; i < 4; i++)
	{
		do { var _item = irandom_range(0, _items); } until _item != 4;
		obj_Player.pickupItem(create_item(_item, choose(false, true)));
	}
	obj_Player.pickupItem(create_item(4));
}