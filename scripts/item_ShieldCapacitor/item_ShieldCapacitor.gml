/// Item : Shield Capacitor

function item_ShieldCapacitor(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Shield Capacitor";
	index = 3;
	rarity = 0;
	
	amount = 1;
	cap = 35;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		amount = 2;
	}
	
	description = $"Increase maximum Shield by {amount}.";
	
	
	// Methods
	static onPickup = function()
	{
		if (owner.shieldMax < cap)
		{
			owner.shield = min(owner.shield + amount, cap);
			owner.shieldMax = min(owner.shieldMax + amount, cap);
		
			if (owner == HUD.statBarDisplay.ship) create_popup(HUD.statBarDisplay.shieldStart + 12 + (HUD.statBarDisplay.shieldMax * 3), HUD.statBarDisplay.yStart, $"+{amount} Max", COLORS.p8_blue, 1.5, 0.075);
		}
	}
}