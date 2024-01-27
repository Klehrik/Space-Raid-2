/// Items

#macro ITEMS global.items
ITEMS = [
	item_EngineBooster,		// 0	W G
	item_SecondaryCannon,	// 1	W G
	item_WeaponBooster,		// 2	W G
	item_ShieldCapacitor,	// 3	W G
	item_Junior,			// 4	    B	AI Blacklisted
	item_PowerShot,			// 5	W G
	item_PiercingShot,		// 6	  G B
	item_EMPWeaponry,		// 7	W G
	item_ChargeBeam,		// 8	    B
	item_Shieldbreaker,		// 9	  G B
	item_EnergySiphon,		// 10	  G B
	item_Accelerator,		// 11	    B	AI Blacklisted
	item_BombShot,			// 12	    B
	item_ExplosiveWeaponry,	// 13	W G
	item_MissileLauncher,	// 14	W G		AI Blacklisted
	item_PulseWeapon,		// 15	    B
	item_HullShrapnel,		// 16	W G		AI Blacklisted
	item_EmergencyBooster,	// 17	W G
	item_EMField,			// 18	    B
	item_HullSpikes,		// 19	W G
	
	// Whites:	11
	// Greens:	14
	// Blues:	9
	// TOTAL:	34
];


global.nextItemID = 0;

function create_item(index, upgraded = false)
{
	var _item = new ITEMS[index](upgraded);
	_item.ID = global.nextItemID;
	global.nextItemID++;
	return _item;
}

function get_rarity_colors(rarity)
{
	switch (rarity)
	{
		case 0:	// white
			return {
				name:	COLORS.p8_white,
				light:	COLORS.p8_white,
				dark:	COLORS.p8_gray,
			}
			break;
		
		case 1:	// green
			return {
				name:	COLORS.p8_green,
				light:	COLORS.p8_green,
				dark:	COLORS.p8_dkgreen,
			}
			break;
		
		case 2:	// blue
			return {
				name:	COLORS.p8_blue,
				light:	COLORS.p8_blue,
				dark:	COLORS.p8_dkblue,
			}
			break;
	}
}