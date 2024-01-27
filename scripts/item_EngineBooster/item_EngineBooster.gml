/// Item : Engine Booster

function item_EngineBooster(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Engine Booster";
	index = 0;
	rarity = 0;
	
	amount = 0.07;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		amount = 0.15;
	}
	
	description = $"Increase movement speed by {round(amount * 100)}%.";
	
	
	// Methods
	static onPickup = function()
	{
		var stat = owner.speedStat;
		stat.add += stat.base * amount;
	}
}