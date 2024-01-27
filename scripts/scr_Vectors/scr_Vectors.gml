/// Vec2 Library
/// Klehrik


function vec2(_x = 0, _y = 0) constructor
{
	x = _x;
	y = _y;
	
	
	static clone = function() { return new vec2(x, y); }
	static equal = function(v2) { return (x == v2.x and y == v2.y); }
	
	
	static dir = function() { return point_direction(0, 0, x, y); }
	static mag = function() { return point_distance(0, 0, x, y); }
	
	
	static setDir = function(d)
	{
		var m = mag();
		return new vec2(dcos(d) * m, -dsin(d) * m);
	}
	static setMag = function(m, min_zero = false)
	{
		if (min_zero) m = max(m, 0);
		var vn = norm();
		return new vec2(vn.x * m, vn.y * m);
	}
	
	
	static rot = function(d) { setDir(dir() + d); }
	static norm = function()
	{
		var m = mag();
		if (m == 0) return new vec2();
		return new vec2(x / m, y / m);
	}
	
	
	static add = function(v2) { return new vec2(x + v2.x, y + v2.y); }
	static sub = function(v2) { return new vec2(x - v2.x, y - v2.y); }
	static scale = function(n) { return new vec2(x * n, y * n); }
	static dot = function(v2) { return (x * v2.x) + (y * v2.y); }
	static angle = function(v2) { return angle_difference(dir(), v2.dir()); }
}