/// obj_Player : Step

event_inherited();

// Skill step
if (skillInUse)
{
	if (!hasStatus("stun")) skill.step();
}

// Skill cooldown (only lower when there is no active skill)
else skill.cooldown();

// Find target
if (!hasTarget()) target = getNearestTarget();	// initial target

// Switch target
if (input_check_pressed("change"))
{
	// Get all enemy ships
	var ships = get_team_ships(2);
	
	// Get index of current targeted ship
	var _index = -1;
	for (var i = 0; i < array_length(ships); i++)
	{
		if (ships[i].id == target.id)
		{
			_index = i;
			break;
		}
	}
	
	// Get next ship in the list
	_index++;
	if (_index >= array_length(ships)) _index = 0;
	target = ships[_index];
}

// Aim ahead
if (hasTarget())
{
	var aim = calculate_aim_vector(getFront().x, getFront().y, lerp(weapons[0].spdMin, weapons[0].spdMax, 0.5), target);
	if (aim != -1) image_angle = aim.dir();
}

if (!hasStatus("stun"))
{
	// Movement
	var axis = input_xy("left", "right", "up", "down");
	if (canMove and (axis.x != 0 or axis.y != 0)) addMovement(new vec2(axis.x * acceleration, axis.y * acceleration));

	// Use weapon/skill
	if (input_check("shoot")) useWeapon(0);
	if (input_check_pressed("skill")) useSkill();
}