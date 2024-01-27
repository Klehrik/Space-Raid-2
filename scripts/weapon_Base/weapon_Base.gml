/// Weapon : Base

function weapon_Base(_owner = noone) constructor
{
	owner = _owner;
	
	// Variables
	name = "WEAPON";
	description = "DESCRIPTION";
	sprite = 0;
	
	charge = 0;
	chargeMax = 1;	// in seconds
	
	
	// Methods
	static use = function() {}
	static step = function() {}
	static draw = function() {}
	static cooldown = function()
	{
		charge = min(charge + owner.fireRate/room_speed, chargeMax);
	}
	
	
	static setCharge = function(length)
	{
		charge = length;
		chargeMax = length;
	}
}