/// obj_Ship : Draw

// Draw self
var c = color;
if (flash > 0)
{
	flash--;
	c = COLORS.p8_white;
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c, image_alpha);

// Draw small stat bars
if (!surface_exists(statBarSurface)) statBarSurface = surface_create(statBarWidth, 3);

surface_set_target(statBarSurface);
draw_clear_alpha(c_white, 0);

draw_better_rectangle_outline(0, 0, statBarWidth, 0, COLORS.p8_night);
if (shieldMax > 0) draw_better_rectangle_outline(0, 2, statBarWidth, 2, COLORS.p8_night);

if (hp > 0) draw_better_rectangle_outline(0, 0, (hp / hpMax) * statBarWidth, 0, COLORS.p8_green);
if (shield > 0) draw_better_rectangle_outline(0, 2, (shield / shieldMax) * statBarWidth, 2, COLORS.p8_blue);

surface_reset_target();
draw_surface_ext(statBarSurface, x - statBarWidth/2 + 1, y + size + 4, 1, 1, 0, c_white, 0.5);

// Draw Stun debuff icon
if (hasStatus("stun")) draw_sprite(spr_Stun, 0, x, y - size - 6);

// Weapon draws
for (var i = 0; i < array_length(weapons); i++)
{
	var wep = weapons[i];
	wep.draw();
}