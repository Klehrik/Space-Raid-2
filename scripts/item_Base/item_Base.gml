/// Item : Base

function item_Base(_upgraded = false) constructor
{
	owner = noone;
	ID = -1;
	
	// Variables
	name = "ITEM";
	description = "DESCRIPTION";
	index = 0;			// also used for image_index
	rarity = 0;
	upgraded = _upgraded;
	procPriority = 1;	// higher numbers proc after all the lower number items
	
	
	// Methods
	static onPickup = function() {}
	static onShoot = function() {}
	static onHit = function(proj, hit) {}		// pass in the projectile that hit and the ship hit
	static onKill = function(proj, hit) {}
	static onGettingHit = function(proj) {}		// pass in the projectile that hit
	static onLosingHull = function(proj) {}
	static onLosingShield = function(proj) {}
	static onLevelStart = function() {}
	static step = function() {}
	static remove = function() {}
	
	static inProcChain = function(chain)		// mainly only applies to items that create more projectiles
	{
		if (array_contains(chain, index)) return true;
		return false;
	}
	
	static addToProcChain = function(chain, index)
	{
		var _chain = [];
		array_copy(_chain, 0, chain, 0, array_length(chain));
		array_push(_chain, index);
		return _chain;
	}
}