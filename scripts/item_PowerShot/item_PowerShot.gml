/// Item : Power Shot

function item_PowerShot(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Power Shot";
	index = 5;
	rarity = 0;
	
	chance = 0.07;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		chance = 0.15;
	}
	
	description = $"On hit, {round(chance * 100)}% chance to deal knockback.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (roll(chance)) { proj.kbMultiplier = 2/3; }
	}
}