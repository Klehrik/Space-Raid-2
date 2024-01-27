/// obj_HUD : Draw

// Display bottom stat bars
draw_sprite(spr_HUDBars, 0, statBarDisplay.xStart, statBarDisplay.yStart);
draw_sprite(spr_HUDBars, 1, statBarDisplay.shieldStart, statBarDisplay.yStart);

// Hull
var _start = statBarDisplay.xStart + 13;
var _end = _start + (statBarDisplay.hpMax * 3);
draw_better_rectangle_outline(_start + 2, statBarDisplay.yStart + 8, _end, statBarDisplay.yStart + 8, COLORS.p8_dknight);
draw_better_rectangle_outline(_end, statBarDisplay.yStart + 2, _end, statBarDisplay.yStart + 8, COLORS.p8_dknight);
for (var i = 0; i < statBarDisplay.hpMax; i++)
{
	var spr = 2;
	if (i < statBarDisplay.hp) spr = 3;
	draw_sprite(spr_HUDBars, spr, _start + (i * 3), statBarDisplay.yStart);
}
var c = COLORS.p8_white;
draw_text_color(_start, statBarDisplay.yStart + 11, statBarDisplay.hp, c, c, c, c, 1);
var c = COLORS.p8_gray;
draw_text_color(_start + 11, statBarDisplay.yStart + 13, $"/ {statBarDisplay.hpMax}", c, c, c, c, 1);

// Shield
var _start = statBarDisplay.shieldStart + 13;
var _end = _start + (statBarDisplay.shieldMax * 3);
draw_better_rectangle_outline(_start + 2, statBarDisplay.yStart + 8, _end, statBarDisplay.yStart + 8, COLORS.p8_dknight);
draw_better_rectangle_outline(_end, statBarDisplay.yStart + 2, _end, statBarDisplay.yStart + 8, COLORS.p8_dknight);
for (var i = 0; i < statBarDisplay.shieldMax; i++)
{
	var spr = 2;
	if (i < statBarDisplay.shield) spr = 4;
	draw_sprite(spr_HUDBars, spr, statBarDisplay.shieldStart + 13 + (i * 3), statBarDisplay.yStart);
}
var c = COLORS.p8_white;
draw_text_color(_start, statBarDisplay.yStart + 11, statBarDisplay.shield, c, c, c, c, 1);
var c = COLORS.p8_gray;
draw_text_color(_start + 11, statBarDisplay.yStart + 13, $"/ {statBarDisplay.shieldMax}", c, c, c, c, 1);

if (statBarDisplay.shield > 0) statBarDisplay.shieldUp = true;
else if (statBarDisplay.shieldUp)
{
	statBarDisplay.shieldUp = false;
	create_popup(HUD.statBarDisplay.shieldStart + 12 + (HUD.statBarDisplay.shieldMax * 3), HUD.statBarDisplay.yStart, $"Broken!", COLORS.p8_blue, 1.5, 0.075);
}

// Shield regen bar
if (statBarDisplay.shield < statBarDisplay.shieldMax and statBarDisplay.charge < statBarDisplay.chargeMax)
{
	var _length = _end - _start - 2;
	draw_better_rectangle_filled(_start, statBarDisplay.yStart + 5, _start + (statBarDisplay.charge/statBarDisplay.chargeMax * _length), statBarDisplay.yStart + 6);
}



// Display target stats
var c = COLORS.p8_white;
draw_text_color(targetStatDisplay.xStart, targetStatDisplay.yStart - 1, targetStatDisplay.name, c, c, c, c, 1);

// Hull
var _end = targetStatDisplay.xStart + (min(targetStatDisplay.hpMax, 50) * 3);
draw_better_rectangle_outline(targetStatDisplay.xStart + 2, targetStatDisplay.yStart + 15, _end, targetStatDisplay.yStart + 15, COLORS.p8_dknight);
draw_better_rectangle_outline(_end, targetStatDisplay.yStart + 11, _end, targetStatDisplay.yStart + 15, COLORS.p8_dknight);
for (var i = 0; i < targetStatDisplay.hpMax; i++)
{
	var spr = 5;
	if (i < targetStatDisplay.hp)
	{
		var sprites = [6, 8, 9];	// image_index for additional bar colors
		spr = sprites[min(floor(i / 50), array_length(sprites) - 1)];
	}
	var j = i mod 50;
	var blend = c_white;
	if (i >= 150) blend = make_color_hsv(rainbowHue, 255, 255);
	if !(spr == 5 and i >= 50) draw_sprite_ext(spr_HUDBars, spr, targetStatDisplay.xStart + (j * 3), targetStatDisplay.yStart + 10, 1, 1, 0, blend, 1);
}
rainbowHue++;
if (rainbowHue > 255) rainbowHue = 0;

// Shield
if (targetStatDisplay.shieldMax > 0)
{
	var _end = targetStatDisplay.xStart + (targetStatDisplay.shieldMax * 3);
	draw_better_rectangle_outline(targetStatDisplay.xStart + 2, targetStatDisplay.yStart + 23, _end, targetStatDisplay.yStart + 23, COLORS.p8_dknight);
	draw_better_rectangle_outline(_end, targetStatDisplay.yStart + 19, _end, targetStatDisplay.yStart + 23, COLORS.p8_dknight);
	for (var i = 0; i < targetStatDisplay.shieldMax; i++)
	{
		var spr = 5;
		if (i < targetStatDisplay.shield) spr = 7;
		draw_sprite(spr_HUDBars, spr, targetStatDisplay.xStart + (i * 3), targetStatDisplay.yStart + 18);
	}
}

// Items
if (array_length(targetStatDisplay.itemList) > 0)
{
	for (var i = 0; i < array_length(targetStatDisplay.itemList); i++)
	{
		var _item = create_item(targetStatDisplay.itemList[i], targetStatDisplay.itemListUpg[i]);
		var _index = _item.index + 1;
		var _rarity = _item.rarity;
		var scale = 0.5;
		var width = 8;
	
		shader_set(shd_SolidColor);
		shader_set_uniform_f_array(shader_get_uniform(shd_SolidColor, "color"), hex_to_norm(COLORS.p8_night));
		draw_sprite_ext(spr_Items, _index, targetStatDisplay.xStart + 2 + (i * width), targetStatDisplay.yStart + 29, scale, scale, 0, c_white, 1);
		shader_reset();
	
		var col = get_rarity_colors(_rarity);
		shader_set(shd_ItemColorSwap);
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "source"), hex_to_norm(#c2c3c7));
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "source2"), hex_to_norm(#a28879));
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "dest"), hex_to_norm(col.light));
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "dest2"), hex_to_norm(col.dark));
		draw_sprite_ext(spr_Items, _index, targetStatDisplay.xStart + (i * width), targetStatDisplay.yStart + 27, scale, scale, 0, c_white, 1);
		shader_reset();
	}
}



// Display items
draw_set_halign(fa_center);
draw_text(lerp(itemDisplay.xStart, itemDisplay.xStart + itemDisplay.width * itemDisplay.size, 0.5) - 2, itemDisplay.yStart - 20, "Items");
draw_set_halign(fa_left);
	
var _x = 0;
var _y = itemDisplay.yStart;
for (var i = 0; i < itemDisplay.width * itemDisplay.height; i++)
{
	if (i < array_length(itemDisplay.itemList))
	{
		var _index = itemDisplay.itemList[i];
		var _item = create_item(_index, itemDisplay.itemListUpg[i]);
		var _rarity = _item.rarity;
			
		// Draw cast shadow
		shader_set(shd_SolidColor);
		shader_set_uniform_f_array(shader_get_uniform(shd_SolidColor, "color"), hex_to_norm(COLORS.p8_night));
		draw_sprite(spr_Items, _index + 1, itemDisplay.xStart + _x + 2, _y + 2);
		shader_reset();
			
		// Draw item sprite
		var col = get_rarity_colors(_rarity);
		shader_set(shd_ItemColorSwap);
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "source"), hex_to_norm(#c2c3c7));
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "source2"), hex_to_norm(#a28879));
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "dest"), hex_to_norm(col.light));
		shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "dest2"), hex_to_norm(col.dark));
		draw_sprite(spr_Items, _index + 1, itemDisplay.xStart + _x, _y);
		shader_reset();
			
		// Show description when moused over (temporary)
		if (point_in_rectangle(mouse_x, mouse_y, itemDisplay.xStart + _x, _y, itemDisplay.xStart + _x + itemDisplay.spriteSize, _y + itemDisplay.spriteSize))
		{
			draw_text(itemDisplay.xStart, itemDisplay.yEnd + 4, $"{_item.name}");
			draw_text(itemDisplay.xStart, itemDisplay.yEnd + 16, $"{_item.description}");
		}
	}
	else draw_sprite(spr_Items, 0, itemDisplay.xStart + _x, _y);
		
	_x += itemDisplay.size;
	if ((i + 1) mod itemDisplay.height == 0)
	{
		_x = 0;
		_y += itemDisplay.size;
	}
}