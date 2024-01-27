/// Damage Number

function create_damage_number(_x, _y, _value, team_hit)
{
	var num = instance_create_layer(_x + random_range(-1, 1), _y, "Popups", obj_DamageNumber);
	num.value = _value;
	num.color = num.colors[team_hit];
}

function create_popup(_x, _y, _value, _color = COLORS.p8_white, _life = 1, _spd = 0.1)
{
	var num = instance_create_layer(_x + random_range(-1, 1), _y, "Popups", obj_DamageNumber);
	num.value = _value;
	num.color = _color;
	num.life = _life;
	num.spd = _spd;
}