/// Item : Shieldbreaker

function item_Shieldbreaker(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Shieldbreaker";
	index = 9;
	rarity = 1;
	
	chance = 0.25;
	amount = 1;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 2;
		amount = 2;
	}
	
	description = $"On hit, {round(chance * 100)}% chance to deal an extra {amount} Shield damage.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (roll(chance))
		{
			if (hit.shield > 0) proj.damage += amount;
		}
	}
}