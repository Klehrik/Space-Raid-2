/// Misc

function draw_better_circle(x, y, r, color, outline = false, alpha = 1)
{
	draw_set_alpha(alpha);
	if (r <= 4)
	{
		var spr = spr_Circfill;
		if (outline) spr = spr_Circ;
		draw_sprite_ext(spr, r, x, y, 1, 1, 0, color, 1);
	}
	else draw_circle_color(x, y, r, color, color, outline);
	draw_set_alpha(1);
}

function draw_better_rectangle_outline(x1, y1, x2, y2, color = COLORS.p8_white, alpha = 1)
{
	// we love gamemaker studio 2
	draw_sprite_ext(spr_Pixel, 0, x1, y1, x2 - x1 + 1, 1, 0, color, alpha);
	draw_sprite_ext(spr_Pixel, 0, x1, y2, x2 - x1 + 1, 1, 0, color, alpha);
	draw_sprite_ext(spr_Pixel, 0, x1, y1, 1, y2 - y1 + 1, 0, color, alpha);
	draw_sprite_ext(spr_Pixel, 0, x2, y1, 1, y2 - y1 + 1, 0, color, alpha);
}

function draw_better_rectangle_filled(x1, y1, x2, y2, color = c_white, alpha = 1)
{
	draw_sprite_ext(spr_Pixel, 0, x1, y1, x2 - x1 + 1, y2 - y1 + 1, 0, color, alpha);
}

function roll(n)
{
	return random_range(0, 1) <= n;
}

function calculate_aim_vector(x, y, pspd, target)
{
	// works well enough
	// source: https://stackoverflow.com/questions/17204513/how-to-find-the-interception-coordinates-of-a-moving-target-in-3d-space
	
	var tnorm = target.getTotalMovement().norm();
	var tspd = target.getTotalMovement().mag();
	
	var a = (tspd * tspd) * ((tnorm.x * tnorm.x) + (tnorm.y * tnorm.y)) - (pspd * pspd);
	var b = 2 * tspd * ((target.x * tnorm.x) + (target.y * tnorm.y) - (x * tnorm.x) - (y * tnorm.y));
	var c = (target.x * target.x) + (target.y * target.y) + (x * x) + (y * y) - (2 * x * target.x) - (2 * y * target.y);
	
	var time = solve_quadratic(a, b, c);
	
	if (time >= 0) return new vec2((target.x - x + (time * tspd * tnorm.x)) / (time * pspd), (target.y - y + (time * tspd * tnorm.y)) / (time * pspd));
	return -1;
}

//function line_circle_collision(x1, y1, x2, y2, cx, cy, cr)
//{
//	// source: https://math.stackexchange.com/questions/275529/check-if-line-intersects-with-circles-perimeter
	
//	x1 -= cx;
//	y1 -= cy;
//	x2 -= cx;
//	y2 -= cy;
	
//	var a = power(x2 - x1, 2) + power(y2 - y1, 2);
//	var b = 2 * (x1 * (x2 - x1) + y1 * (y2 - y1));
//	var c = power(x1, 2) + power(y1, 2) - power(cr, 2);
	
//	var solve = solve_quadratic(a, b, c);
	
//	if (solve > 0 and solve < 1) return true;
//	return false;
//}

function solve_quadratic(a, b, c)
{
	var d = power(b, 2) - (4 * a * c);
	if (d >= 0 and a != 0)
	{
		var x1 = (-b + sqrt(d)) / (2 * a);
		var x2 = (-b - sqrt(d)) / (2 * a);
		if ((x2 >= 0 and x2 < x1) or x1 < 0) return x2;
		return x1;
	}
	return -1;
}

function hex_to_norm(col)
{
	return [colour_get_red(col) / 255, colour_get_green(col) / 255, colour_get_blue(col) / 255];
}

function ease(x, n)
{
	return 1 - power(1 - x, n);
}

//function instance_get_index(inst)
//{
//	// Opposite of instance_find()
//	// Returns the index number of an instance of a specified object
	
//	var obj = inst.object_index;
//	for (var i = 0; i < instance_number(obj); i++) { if (instance_find(obj, i).id == inst.id) return i; }
//	return -1;
//}