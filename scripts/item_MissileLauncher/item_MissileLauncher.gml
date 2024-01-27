/// Item : Missile Launcher

function item_MissileLauncher(_upgraded = false) : item_Base(_upgraded) constructor
{
	// Variables
	name = "Missile Launcher";
	index = 14;
	rarity = 0;
	
	charge = 0;
	chargeMax = 6;
	amount = 1;
	spd = 1;
	
	
	// Upgraded
	if (upgraded)
	{
		rarity = 1;
		amount = 2;
	}
	
	description = $"Every {chargeMax} seconds, fire a homing missile for {amount} damage.";
	
	
	// Methods
	static step = function()
	{
		charge += 1/room_speed;
		if (charge >= chargeMax)
		{
			charge = 0;
			
			var proj = owner.fireBullet([], owner.image_angle, spd, 1, amount);
			proj.homing = true;
		}
	}
}