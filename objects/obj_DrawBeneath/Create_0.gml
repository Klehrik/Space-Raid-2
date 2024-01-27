/// obj_DrawBeneath : Init

arenaSurface = noone;

targetingLine = {
	owner:	noone,
	target:	noone,
}


// Methods
setTargetingLine = function(_owner, _target)
{
	targetingLine = {
		owner:	_owner,
		target:	_target,
	}
}