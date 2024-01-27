/// Item : EMP Weaponry

function item_EMPWeaponry(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "EMP Weaponry";
	index = 7;
	rarity = 0;
	
	chance = 0.06;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		chance = 0.12;
	}
	
	description = $"On hit, {round(chance * 100)}% chance to stun the target for 1 second.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (roll(chance)) hit.addStatus("stun", 1);
	}
}