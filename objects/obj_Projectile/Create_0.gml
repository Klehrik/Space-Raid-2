/// obj_Projectile : Init

team = 0;
owner = noone;

direction = 0;
spd = 0;
spdOriginal = 0;		// before degradation
spdDegradation = 0;		// higher values = more speed loss, between 0 and 1

size = 0;
color = COLORS.p8_white;

damage = 1;
kbMultiplier = 0;		// knockback is based on speed
proc = true;			// whether or not to proc onHit
procChain = [];			// prevent items from chaining infinitely


// Methods
matchTeam = function(ship)
{
	team = ship.team;
	color = ship.color;
}

addToProcChain = function(_index)
{
	array_push(procChain, _index);
}