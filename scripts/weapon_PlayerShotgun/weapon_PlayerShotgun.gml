/// Weapon : Player Shotgun

function weapon_PlayerShotgun(_owner = noone) : weapon_Basic(_owner) constructor
{
	// Variables
	name = "Shotgun";
	description = "Fire a spread of 6 bullets every 1.6 seconds for 1 damage each.";
	
	setCharge(1.6);
	setSpeed(1.4, 1.6);
	spdDegradation = 0.015;
	count = 6;
	spread = 12;
}