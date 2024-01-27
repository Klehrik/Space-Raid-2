/// obj_Manager : Init

#macro CAM_WIDTH camera_get_view_width(view_camera[0])
#macro CAM_HEIGHT camera_get_view_height(view_camera[0])

surface_resize(application_surface, CAM_WIDTH, CAM_HEIGHT);
draw_set_circle_precision(64);
draw_set_font(fnt_Theoretical);
randomize();

#macro COLORS global.colors
COLORS = {
	p8_white:	#fff1e8,
	p8_gray:	#a28879,
	p8_dkgray:	#5f574f,
	p8_green:	#00b543,
	p8_dkgreen:	#125359,
	p8_blue:	#29adff,
	p8_dkblue:	#065ab5,
	p8_night:	#1d2b53,
	p8_dknight:	#111d35,
	p8_red:		#ff004d,
	p8_blurple:	#83769c,
	p8_yellow:	#ffec27,
}

#macro ARENA global.arena
ARENA = {
	tileSize:	10,
	width:		18,
	height:		16,
	yStart:		12,
}
ARENA.pixelWidth = ARENA.width * ARENA.tileSize;
ARENA.pixelHeight = ARENA.height * ARENA.tileSize;
ARENA.xStart = room_width/2 - ARENA.pixelWidth/2;
ARENA.xEnd = ARENA.xStart + ARENA.pixelWidth;
ARENA.yEnd = ARENA.yStart + ARENA.pixelHeight;

#macro HUD global.hud	// pretty messy; should find another solution sometime
#macro BENEATH global.drawBeneath
HUD = instance_create_layer(0, 0, "HUD", obj_HUD);
BENEATH = instance_create_layer(0, 0, "DrawBeneath", obj_DrawBeneath);

#macro PARTICLES global.articles
PARTICLES = [];

#macro DIFFICULTY global.difficulty
DIFFICULTY = 0;		// 0 (standard), 1 (hard)



// testing
player = create_ship(ARENA.xStart + ARENA.pixelWidth/2, ARENA.yStart + ARENA.pixelHeight/2, "playerBlaster");

level = 0;
enemyItems = [];
enemyItemsUpg = [];

fpsAvg = [];
addFpsAvg = function(n)
{
	array_push(fpsAvg, n);
	if (array_length(fpsAvg) > 30) array_delete(fpsAvg, 0, 1);
}
calculateFpsAvg = function()
{
	var total = 0;
	for (var i = 0; i < array_length(fpsAvg); i++) total += fpsAvg[i];
	return total / array_length(fpsAvg);
}