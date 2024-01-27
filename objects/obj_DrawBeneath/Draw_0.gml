/// obj_DrawArena : Draw

// Draw arena
if (!surface_exists(arenaSurface)) arenaSurface = surface_create(ARENA.pixelWidth, ARENA.pixelHeight);

surface_set_target(arenaSurface);
draw_clear_alpha(c_white, 0);

var c = COLORS.p8_night;
for (var _x = 0; _x < ARENA.width; _x++) draw_line_color(_x * ARENA.tileSize, 0, _x * ARENA.tileSize, ARENA.pixelHeight - 1, c, c);
for (var _y = 0; _y < ARENA.height; _y++) draw_line_color(0, _y * ARENA.tileSize, ARENA.pixelWidth - 1, _y * ARENA.tileSize, c, c);

surface_reset_target();
draw_surface_ext(arenaSurface, ARENA.xStart, ARENA.yStart, 1, 1, 0, c_white, 0.3);
draw_better_rectangle_outline(ARENA.xStart, ARENA.yStart, ARENA.xEnd, ARENA.yEnd, COLORS.p8_night);


// Draw targeting line
if (instance_exists(targetingLine.owner) and instance_exists(targetingLine.target))
{
	draw_set_alpha(0.75);
	var front = targetingLine.owner.getFront();
	var c = COLORS.p8_night;
	draw_line_color(front.x, front.y, targetingLine.target.x, targetingLine.target.y, c, c);
	draw_better_circle(targetingLine.target.x, targetingLine.target.y, targetingLine.target.size + 6, c, true);
	draw_set_alpha(1);
}