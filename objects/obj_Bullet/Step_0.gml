/// obj_Bullet : Step

// Move
if (!homing)
{
	x += dcos(direction) * spd;
	y -= dsin(direction) * spd;
	spd *= (1 - spdDegradation);
}
else
{
	if (!instance_exists(homingTarget))
	{
		if (instance_exists(owner) and instance_exists(owner.target)) homingTarget = owner.target;
		else homing = !homing;
	}
	else
	{
		direction = point_direction(x, y, homingTarget.x, homingTarget.y);
		x += dcos(direction) * spd;
		y -= dsin(direction) * spd;
		spd *= (1 - spdDegradation);
	}
}

// Destroy
if (!point_in_rectangle(x, y, ARENA.xStart + size, ARENA.yStart + size, ARENA.xEnd - size, ARENA.yEnd - size)) destroy();
if (spd <= 0.3) destroy();