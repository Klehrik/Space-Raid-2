/// Item : Weapon Booster

function item_WeaponBooster(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Weapon Booster";
	index = 2;
	rarity = 0;
	
	amount = 0.06;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		amount = 0.12;
	}
	
	description = $"Increase weapon firing speed by {round(amount * 100)}%.";
	
	
	// Methods
	static onPickup = function()
	{
		owner.fireRate += amount;
	}
}