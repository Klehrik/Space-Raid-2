/// obj_Ring : Draw

var radius = getRadius();
if (!dotted) draw_better_circle(x, y, radius, color, true);
else
{
	dottedTime += 0.5;
	for (var a = dottedTime; a < 360 + dottedTime; a += 18)
	{
		draw_line_color(x + (dcos(a) * radius), y - (dsin(a) * radius),
						x + (dcos(a + 6) * radius), y - (dsin(a + 6) * radius),
						color, color);
	}
}