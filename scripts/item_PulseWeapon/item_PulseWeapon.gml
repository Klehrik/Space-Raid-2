/// Item : Pulse Weapon

function item_PulseWeapon(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Pulse Weapon";
	index = 15;
	rarity = 2;
	
	charge = 0;
	chargeMax = 3;
	amount = 1;
	radius = 45;
	
	description = $"Every {chargeMax} seconds, fire a pulse that deals {amount} damage to nearby enemies.";
	
	
	// Methods
	static step = function()
	{
		charge += 1/room_speed;
		if (charge >= chargeMax)
		{
			charge = 0;
			
			owner.fireRing([], owner.x, owner.y, radius, amount);
		}
	}
}