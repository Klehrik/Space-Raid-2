/// Item : Accelerator

function item_Accelerator(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Accelerator";
	index = 11;
	rarity = 2;
	
	charge = 4;
	chargeMax = 4;
	
	description = $"Every {chargeMax} weapon uses, fire piercing lasers instead of bullets.";
	
	
	// Methods
	static onShoot = function()
	{
		charge++;
		if (charge >= chargeMax and !owner.hasStatus("fireLaser"))	// if another Accelerator already applied this status, conserve charges for next weapon use
		{
			charge = 0;
			owner.addStatus("fireLaser");
		}
	}
}