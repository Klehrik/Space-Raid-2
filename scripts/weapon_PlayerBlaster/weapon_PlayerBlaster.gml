/// Weapon : Player Blaster

function weapon_PlayerBlaster(_owner = noone) : weapon_Basic(_owner) constructor
{
	// Variables
	name = "Blaster";
	description = "Fire a bullet every 0.4 seconds for 1 damage.";
	
	setCharge(0.4);
	setSpeed(1.5);
}