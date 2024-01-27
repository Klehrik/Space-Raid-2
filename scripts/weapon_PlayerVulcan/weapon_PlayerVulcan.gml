/// Weapon : Player Rail Vulcan

function weapon_PlayerRailVulcan(_owner = noone) : weapon_Basic(_owner) constructor
{
	// Variables
	name = "Rail Vulcan";
	description = "This is a joke weapon.";		// make an actual version of this not using items and make it unlocked after unlocking everything else lmao
	
	setCharge(0.1);
	setSpeed(3.5);
	size = 1;
	damage = 3;
	spread = 12;
	
	repeat (4) owner.pickupItem(create_item(11));
}