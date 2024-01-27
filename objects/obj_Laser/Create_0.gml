/// obj_Laser : Init

event_inherited();

endX = x;
endY = y;
hitList = [];


// Methods
findEndpoint = function()
{
	// i am too lazy to math
	endX = x;
	endY = y;
	
	while (point_in_rectangle(endX, endY, ARENA.xStart, ARENA.yStart, ARENA.xEnd, ARENA.yEnd))
	{
		endX += dcos(direction);
		endY -= dsin(direction);
	}
}

destroy = function()
{
	instance_destroy();
}



// debug : temp alarm
alarm[0] = 12;