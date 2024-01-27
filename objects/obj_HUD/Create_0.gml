/// obj_HUD : Init

statBarDisplay = {
	ship:			noone,
	hp:				0,
	hpMax:			1,
	shield:			0,
	shieldMax:		1,
	charge:			0,
	chargeMax:		0,
	xStart:			ARENA.xStart + 4,
	yStart:			ARENA.yEnd + 8,
	shieldUp:		false,
}
statBarDisplay.shieldStart = statBarDisplay.xStart + 56;


targetStatDisplay = {
	name:			"NAME",
	hp:				0,
	hpMax:			1,
	shield:			0,
	shieldMax:		0,
	itemList:		[],
	itemListUpg:	[],
	xStart:			ARENA.xStart + 5,
	yStart:			ARENA.yStart + 5,
}
rainbowHue = 0;		// used for 4th target hull bar


itemDisplay = {
	itemList:		[],
	itemListUpg:	[],
	size:			16,		// "cell" size of each item
	spriteSize:		12,
	width:			5,		// # of cells
	height:			5,
	yStart:			36,
}
itemDisplay.xStart = ARENA.xStart/2 - (itemDisplay.width * itemDisplay.size)/2 + (itemDisplay.size - itemDisplay.spriteSize);
itemDisplay.xEnd = itemDisplay.xStart + (itemDisplay.width * itemDisplay.size);
itemDisplay.yEnd = itemDisplay.yStart + (itemDisplay.height * itemDisplay.size);


// Methods
passItemList = function(_items)
{
	itemDisplay.itemList = [];
	itemDisplay.itemListUpg = [];
	for (var i = 0; i < array_length(_items); i++)
	{
		array_push(itemDisplay.itemList, _items[i].index);
		array_push(itemDisplay.itemListUpg, _items[i].upgraded);
	}
}

passStats = function(ship)
{
	if (!instance_exists(ship)) return;
	
	statBarDisplay.ship = ship.id;
	statBarDisplay.hp = floor(ship.hp);
	statBarDisplay.hpMax = floor(ship.hpMax);
	statBarDisplay.shield = floor(ship.shield);
	statBarDisplay.shieldMax = floor(ship.shieldMax);
	statBarDisplay.charge = ship.shieldRegen.charge;
	statBarDisplay.chargeMax = ship.shieldRegen.chargeMax;
}

passTargetStats = function(ship)
{
	if (!instance_exists(ship)) return;
	
	targetStatDisplay.name = ship.name;
	targetStatDisplay.hp = floor(ship.hp);
	targetStatDisplay.hpMax = floor(ship.hpMax);
	targetStatDisplay.shield = floor(ship.shield);
	targetStatDisplay.shieldMax = floor(ship.shieldMax);
	targetStatDisplay.itemList = [];
	targetStatDisplay.itemListUpg = [];
	
	if (array_length(ship.items) > 0)
	{
		for (var i = 0; i < array_length(ship.items); i++)
		{
			array_push(targetStatDisplay.itemList, ship.items[i].index);
			array_push(targetStatDisplay.itemListUpg, ship.items[i].upgraded);
		}
	}
}