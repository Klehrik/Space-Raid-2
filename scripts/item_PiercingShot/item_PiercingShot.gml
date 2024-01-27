/// Item : Piercing Shot

function item_PiercingShot(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Piercing Shot";
	index = 6;
	rarity = 1;
	
	chance = 0.07;
	amount = 2;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 2;
		amount = 4;
	}
	
	description = $"On hit, {round(chance * 100)}% chance to deal an extra {amount} damage.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (roll(chance)) proj.damage += amount;
	}
}