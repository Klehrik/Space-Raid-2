/// obj_DamageNumber : Draw

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var c = c_black;
draw_text_color(x + 1, y + 1, value, c, c, c, c, 1);
var c = color;
draw_text_color(x, y, value, c, c, c, c, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);


// Move up and decrease lifetime
y -= spd;

life -= 1/room_speed;
if (life <= 0) instance_destroy();