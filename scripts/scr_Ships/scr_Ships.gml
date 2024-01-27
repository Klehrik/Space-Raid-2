/// Ships

function create_ship(_x, _y, _name, _team = 0, level = 1)
{
	level--;
	
	switch (_name)
	{
		case "playerBlaster":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Player);
			ship.weapons = [new weapon_PlayerBlaster(ship)];
			ship.skill = new skill_Dash(ship);
			return ship;
			break;
			
		
		case "playerShotgun":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Player);
			ship.weapons = [new weapon_PlayerShotgun(ship)];
			ship.skill = new skill_Dash(ship);
			return ship;
			break;
			
		
		case "playerRailgun":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Player);
			ship.weapons = [new weapon_PlayerRailgun(ship)];
			ship.skill = new skill_Dash(ship);
			return ship;
			break;
			
			
		case "playerMelee":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Player);
			ship.weapons = [new weapon_PlayerMeleeDash(ship)];
			ship.skill = new skill_RemoveProjectiles(ship);
			// ship.setMaxShield(4);
			ship.shieldRegen.amount = 1;
			ship.speedStat.base = 0.6;
			ship.collisionDamage = 2;
			return ship;
			break;
		
		
		case "itemDrone":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Ship);
			ship.internalName = _name;
			ship.name = "Drone";
			ship.description = "An attack drone fitted with a simple but accurate cannon.";
			ship.setTeam(_team);
			ship.setSize(2);
			ship.speedStat.base = 0.5;
			ship.weapons = [new weapon_AutoScout(ship)];
			ship.AI_basic_init();
			ship.AI = ship.AI_drone_step;
			return ship;
			break;
			
		
		case "basic":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Ship);
			ship.internalName = _name;
			ship.name = "Auto-Scout";
			ship.description = "An automated drone scout. Lacks firepower, but can be dangerous in large groups.";
			ship.setTeam(_team);
			ship.setSize(3);
			ship.setMaxHealth(7 + (2 * DIFFICULTY) + floor(level * (1 + (DIFFICULTY * 0.5))));	// L1~10 : 7   8   9   10  11  12  13  14  15  16
			ship.setMaxShield(floor(level * (0.5 + (DIFFICULTY * 0.3))));						// L1~10 : 0   0   1   1   2   2   3   3   4   4
			ship.speedStat.base = 0.4;
			ship.weapons = [new weapon_AutoScout(ship)];
			ship.AI_basic_init();
			ship.AI = ship.AI_basic_step;
			return ship;
			break;
			
			
		case "gunner":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Ship);
			ship.internalName = _name;
			ship.name = "Gunner";
			ship.description = "A ship equipped with a rapid fire cannon. It will try to keep its distance from targets.";
			ship.setTeam(_team);
			ship.setSize(5);
			ship.setMaxHealth(10 + (3 * DIFFICULTY) + floor(level * (1.5 + (DIFFICULTY * 0.5))));	// L1~10 : 10  11  13  14  16  17  19  20  22  23
			ship.setMaxShield(floor(level * (2/3 + (DIFFICULTY * 1/3))));							// L1~10 : 0   0   1   2   2   3   4   4   5   6
			ship.speedStat.base = 0.35;
			ship.weapons = [new weapon_Gunner(ship)];
			ship.AI_gunner_init();
			ship.AI = ship.AI_basic_step;
			return ship;
			break;
			
			
		case "enforcer":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Ship);
			ship.internalName = _name;
			ship.name = "Enforcer";
			ship.description = "A ship equipped with a spread cannon. It will attempt to get close to targets.";
			ship.setTeam(_team);
			ship.image_index = 1;
			ship.setSize(5);
			ship.setMaxHealth(10 + (3 * DIFFICULTY) + floor(level * (1.5 + (DIFFICULTY * 0.5))));	// L1~10 : 10  11  13  14  16  17  19  20  22  23
			ship.setMaxShield(floor(level * (2/3 + (DIFFICULTY * 1/3))));							// L1~10 : 0   0   1   2   2   3   4   4   5   6
			ship.speedStat.base = 0.45;
			ship.weapons = [new weapon_Enforcer(ship)];
			ship.AI_basic_init();
			ship.AI = ship.AI_basic_step;
			return ship;
			break;
			
		
		case "meleeDrone":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Ship);
			ship.internalName = _name;
			ship.name = "Drone";
			ship.description = "An attack drone that will attempt to ram into targets.";
			ship.setTeam(_team);
			ship.image_index = 2;
			ship.setSize(2);
			// ship.setMaxHealth(5 + floor(level / 1.5));	// L1~10 : 5   5   6   7   7   8   9   9   10  11
			ship.speedStat.base = 0.4;
			ship.AI_melee_drone_init();
			ship.AI = ship.AI_basic_step;
			return ship;
			break;
			
		
		case "carrier":
			var ship = instance_create_layer(_x, _y, "Ships", obj_Ship);
			ship.internalName = _name;
			ship.name = "Factory";
			ship.description = "A stationary construct that produces simple attack drones at a rapid pace.";
			ship.setTeam(_team);
			ship.image_index = 2;
			ship.setSize(5);
			ship.setMaxHealth(12 + (3 * DIFFICULTY) + floor(level * (1.5 + (DIFFICULTY * 0.5))));	// L1~10 : 12  13  15  17  19  20  22  24  26  27
			ship.setMaxShield(floor(level * (4/5 + (DIFFICULTY * 2/5))));							// L1~10 : 0   0   1   2   3   4   4   5   6   7
			ship.speedStat.base = 0;
			ship.AI_carrier_init();
			ship.AI = ship.AI_carrier_step;
			return ship;
			break;
	}
}


// Functions
function get_team_ships(_team)
{
	var ships = [];
	with (obj_Ship) { if (team == _team) array_push(ships, id); }
	return ships;
}

function get_ships(_name)
{
	var ships = [];
	with (obj_Ship) { if (internalName == _name) array_push(ships, id); }
	return ships;
}

function destroy_ships(_name)
{
	with (obj_Ship) { if (internalName == _name) instance_destroy(); }
}