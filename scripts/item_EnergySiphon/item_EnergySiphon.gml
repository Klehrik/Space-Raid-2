/// Item : Energy Siphon

function item_EnergySiphon(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Energy Siphon";
	index = 10;
	rarity = 1;
	
	chance = 0.05;
	amount = 1;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 2;
		chance = 0.1;
	}
	
	description = $"On hit, if you have Shield remaining, {round(chance * 100)}% chance to restore {amount} Shield.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (roll(chance))
		{
			if (owner.shield > 0 and owner.shield < owner.shieldMax)
			{
				owner.shield = min(owner.shield + amount, owner.shieldMax);
				
				if (owner == HUD.statBarDisplay.ship) create_popup(HUD.statBarDisplay.shieldStart + 12 + (HUD.statBarDisplay.shieldMax * 3), HUD.statBarDisplay.yStart, $"+{amount}", COLORS.p8_blue, 1.5, 0.075);
			}
		}
	}
}