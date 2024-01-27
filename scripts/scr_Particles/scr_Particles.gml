/// Particles

function add_particle(_x, _y, _dir, _spd, _sizebegin, _sizeend, _life, _color = COLORS.p8_white)
{
	array_push(PARTICLES, [_x, _y, _dir, _spd, _sizebegin, _sizeend, 0, _life, _color]);
}


function update_and_render_particles()
{
	for (var i = array_length(PARTICLES) - 1; i >= 0; i--)
	{
		var p = PARTICLES[i];
		
		p[0] += dcos(p[2]) * p[3];
		p[1] -= dsin(p[2]) * p[3];
		
		var _size = round(lerp(p[4], p[5], p[6] / p[7]));
		draw_better_circle(p[0], p[1], _size, p[8], false);
		
		p[6] += 1/room_speed;
		if (p[6] >= p[7]) array_delete(PARTICLES, i, 1);
	}
}