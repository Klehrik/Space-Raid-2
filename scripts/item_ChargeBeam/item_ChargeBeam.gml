/// Item : Charge Beam

function item_ChargeBeam(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Charge Beam";
	index = 8;
	rarity = 2;
	
	charge = 0;
	chargeMax = 10;
	amount = 2;
	
	description = $"On hit, charge this item; at 10 charges, fire a piercing laser for {amount} damage.";
	
	
	// Methods
	static onHit = function(proj, hit)
	{
		if (!inProcChain(proj.procChain))
		{
			charge++;
			if (charge >= chargeMax)
			{
				charge = 0;
			
				var dir = owner.image_angle;
			
				// Aim at target if there is one
				if (instance_exists(owner.target))
				{
					var front = owner.getFront();
					dir = point_direction(front.x, front.y, owner.target.x, owner.target.y);
				}
				
				var chain = addToProcChain(proj.procChain, index);
				owner.fireLaser(chain, dir, amount);
			}
		}
	}
}