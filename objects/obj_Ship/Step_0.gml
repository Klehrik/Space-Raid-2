/// obj_Ship : Step

movedThisFrame = false;

if (!hasStatus("stun"))
{
	// Weapon step
	if (is_struct(weaponInUse))
	{
		weaponInUse.step();
	}

	// Weapon cooldowns (only lower when there is no active weapon)
	else
	{
		for (var i = 0; i < array_length(weapons); i++)
		{
			var wep = weapons[i];
			wep.cooldown();
		}
	}
}

// Item step
for (var i = 0; i < array_length(items); i++)
{
	var _item = items[i];
	_item.step();
}

// Shield regen
if (shieldRegen.charge < shieldRegen.chargeMax)
{
	shieldRegen.charge += 1/room_speed;
	if (shieldRegen.charge >= shieldRegen.chargeMax) shield = min(shield + 1, shieldMax);	// instantly recharge 1 point when timer finishes
}
else shield = min(shield + shieldRegen.amount/room_speed, shieldMax);

// Decrease status durations
for (var i = array_length(statuses) - 1; i >= 0; i--)
{
	var status = statuses[i];
	status[1] -= 1/room_speed;
	if (status[1] <= 0)
	{
		status[2](id);	// run remove function
		array_delete(statuses, i, 1);
	}
}

// Decrease collision immunity
collisionImmunity = max(collisionImmunity - 1/room_speed, 0);

// Decrease invincibility
invincibility = max(invincibility - 1/room_speed, 0);

// AI
if (AI != noone) AI();