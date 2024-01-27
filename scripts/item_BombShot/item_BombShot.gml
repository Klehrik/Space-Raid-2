/// Item : Bomb Shot

function item_BombShot(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Bomb Shot";
	index = 12;
	rarity = 2;
	procPriority = 2;
	
	chance = 0.07;
	scale = 1;
	radius = 20;
	
	description = $"On hit, {floor(chance * 100)}% chance to deal {scale}x damage to nearby enemies.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (roll(chance))
		{
			var chain = addToProcChain(proj.procChain, index);
			var ring = owner.fireRing(chain, hit.x, hit.y, radius, proj.damage * scale);
			ring.proc = false;
		}
		
		
		// Old version where this item could proc
		//if (!inProcChain(proj.procChain))
		//{
		//	if (roll(chance))
		//	{
		//		var chain = addToProcChain(proj.procChain, index);
		//		owner.fireRing(chain, hit.x, hit.y, radius, proj.damage * scale);
		//	}
		//}
	}
}