/// Item : Explosive Weaponry

function item_ExplosiveWeaponry(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Explosive Weaponry";
	index = 13;
	rarity = 0;
	procPriority = 2;
	
	scale = 1;
	radius = 35;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		scale = 2;
	}
	
	description = $"On kill, the target explodes, dealing {scale}x damage to nearby enemies.";
	
	
	// Methods
	static onKill = function(proj, hit)
	{
		if (!inProcChain(proj.procChain))
		{
			var chain = addToProcChain(proj.procChain, index);
			owner.fireRing(chain, hit.x, hit.y, radius, proj.damage * scale);
		}
	}
}