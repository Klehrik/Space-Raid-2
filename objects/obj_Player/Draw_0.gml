/// obj_Player : Draw

event_inherited();



// debug: draw items
//for (var i = 0; i < array_length(items); i++)
//{
//	var _index = items[i].index;
//	var _rarity = items[i].rarity;
	
//	shader_set(shd_SolidColor);
//	shader_set_uniform_f_array(shader_get_uniform(shd_SolidColor, "color"), hex_to_norm(COLORS.p8_night));
//	draw_sprite(spr_Items, _index, 10 + (i * 16), 10);
//	shader_reset();
	
//	var col = get_rarity_colors(_rarity);
//	shader_set(shd_ItemColorSwap);
//	shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "source"), hex_to_norm(#c2c3c7));
//	shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "source2"), hex_to_norm(#a28879));
//	shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "dest"), hex_to_norm(col.light));
//	shader_set_uniform_f_array(shader_get_uniform(shd_ItemColorSwap, "dest2"), hex_to_norm(col.dark));
//	draw_sprite(spr_Items, _index, 8 + (i * 16), 8);
//	shader_reset();
	
//	// show desc
//	if (point_in_rectangle(mouse_x, mouse_y, 8 + (i * 16), 8, 20 + (i * 16), 20))
//	{
//		draw_text(8, 40, $"{items[i].name}");
//		draw_text(8, 52, $"{items[i].description}");
//	}
//}