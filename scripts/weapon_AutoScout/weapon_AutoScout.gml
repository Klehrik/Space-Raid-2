/// Weapon : Auto Scout

function weapon_AutoScout(_owner = noone) : weapon_Basic(_owner) constructor
{
	// Variables
	chargeMax = 1 - (DIFFICULTY * 0.2);
	setSpeed(1);
	
	if (DIFFICULTY >= 1)
	{
		count = 2;
		spread = 12;
		setSpeed(0.8, 1);
	}
}