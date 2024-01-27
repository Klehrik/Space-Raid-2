/// obj_Bullet : Init

event_inherited();

homing = false;
homingTarget = noone;


// Methods
setSize = function(n)
{
	size = n;
	sprite_index = spr_Circle256;
	image_alpha = 0;
	image_xscale = max(size, 1) / 128;
	image_yscale = max(size, 1) / 128;
}

setVelocity = function(_dir, _spd)
{
	direction = _dir;
	spd = _spd;
	spdOriginal = spd;
}

destroy = function()
{
	instance_destroy();
}