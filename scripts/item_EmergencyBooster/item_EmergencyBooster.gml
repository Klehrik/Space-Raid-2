/// Item : Emergency Booster

function item_EmergencyBooster(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Emergency Booster";
	index = 17;
	rarity = 0;
	
	amount = 0.12;
	duration = 2.5;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		amount = 0.25;
	}
	
	description = $"On taking damage, increase movement speed by {round(amount * 100)}% for {string_format(duration, 1, 1)} seconds.";
	
	
	// Methods
	static onGettingHit = function(proj)
	{
		owner.removeStatus($"emergencyBooster{ID}");
		
		var stat = owner.speedStat;
		stat.add += stat.base * amount;
		
		owner.addStatus($"emergencyBooster{ID}", duration, function(ship)
		{
			var stat = ship.speedStat;
			stat.add -= stat.base * amount;
		});
	}
}