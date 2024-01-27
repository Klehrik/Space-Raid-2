/// obj_Ring : Init

event_inherited();

radiusMax = 0;
lerpTime = 0;
lerpTimeMax = 0.75;	// in seconds
time = 0;
duration = 0.75;
dotted = false;		// draw a dotted circle instead
dottedTime = 0;
displayDamageNumber = true;

hitList = [];


// Methods
getRadius = function()
{
	return ease(lerpTime / lerpTimeMax, 3) * radiusMax;
}

setHitbox = function()
{
	var radius = getRadius();
	sprite_index = spr_Circle256;
	image_alpha = 0;
	image_xscale = radius / 128;
	image_yscale = radius / 128;
}

destroy = function()
{
	instance_destroy();
}