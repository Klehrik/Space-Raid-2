/// obj_Player : Init

event_inherited();

team = 1;
color = COLORS.p8_blue;

name = "Player";
description = "One of the last remaining ships of the Federation Holdout.";

setMaxHealth(10);
setMaxShield(6);
speedStat.base = 0.5;

hasOSP = true;

//weapons = [new weapon_PlayerRailgun(id)];
//skill = new skill_Dash(id);
skill = noone;
skillInUse = false;


// Methods
useSkill = function()
{
	if (!skillInUse)
	{
		if (skill.charge >= skill.chargeMax)
		{
			skillInUse = true;
			skill.charge = 0;
			skill.use();
		}
	}
}


// debug
//repeat (20) pickupItem(create_item(6, true));
//repeat (5) pickupItem(create_item(19, true));
//repeat (5) pickupItem(create_item(3, true));
//repeat (5) pickupItem(create_item(10, true));