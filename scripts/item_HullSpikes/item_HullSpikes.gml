/// Item : Hull Spikes

function item_HullSpikes(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Hull Spikes";
	index = 19;
	rarity = 0;
	
	amount = 1;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		amount = 2;
	}
	
	description = $"Increase collision damage by {amount}.";
	
	
	// Methods
	static onPickup = function()
	{
		owner.collisionDamage += amount;
	}
}