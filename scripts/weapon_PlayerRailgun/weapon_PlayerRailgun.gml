/// Weapon : Player Railgun

function weapon_PlayerRailgun(_owner = noone) : weapon_Base(_owner) constructor
{
	// Variables
	setCharge(0.8);
	
	spdMin = 1.5;
	spdMax = 1.5;
	size = 0;
	damage = 1;
	
	level = 0;
	levelCharge = 0;
	levelChargeThresholds = [0.6, 1.8];
	
	barSurface = noone;
	barWidth = 12;
	
	
	// Methods
	static use = function()
	{
		if (!instance_exists(owner)) return;
		
		setSpeed(1.5);
		size = 0;
		damage = 1;
	
		level = 0;
		levelCharge = 0;
	}
	
	
	static step = function()
	{
		if (input_check("shoot") and levelCharge < levelChargeThresholds[1])
		{
			if (levelCharge < levelChargeThresholds[1]) levelCharge += owner.fireRate/room_speed;
			
			// Level 2 charge
			if (levelCharge >= levelChargeThresholds[0])
			{
				setSpeed(3);
				size = 1;
				damage = 3;
			}
			
			// Level 3 charge
			if (levelCharge >= levelChargeThresholds[1])
			{
				setSpeed(4);
				size = 2;
				damage = 4;
			}
		}
		
		else
		{
			// Fire laser at max charge
			if (levelCharge >= levelChargeThresholds[1]) owner.addStatus("fireLaser");
			
			// Proc onShoot
			owner.procOnShoot();
			
			// Fire bullet
			// or laser with Accelerator
			if (!owner.hasStatus("fireLaser"))
			{
				owner.fireBullet([], owner.image_angle, spdMin, size, damage);
			}
			else
			{
				owner.removeStatus("fireLaser");
			
				var dir = owner.image_angle;
			
				// Aim at target if there is one
				if (instance_exists(owner.target))
				{
					var front = owner.getFront();
					dir = point_direction(front.x, front.y, owner.target.x, owner.target.y);
				}
			
				owner.fireLaser([], dir, damage);
			}
			
			// Reset weaponInUse
			owner.weaponInUse = noone;
			charge = 0;
		}
	}
	
	
	static draw = function()
	{
		if (owner.weaponInUse == self)
		{
			// Draw Charge Meter
			if (!surface_exists(barSurface)) barSurface = surface_create(barWidth, 5);
		
			surface_set_target(barSurface);
			draw_clear_alpha(c_white, 0);
		
			// Calculate bar lineups
			var th1 = 3;	// just gonna manually adjust this one lol
			var _charge = (levelCharge / levelChargeThresholds[1]) * 11;
		
			// Draw bar
			draw_better_rectangle_filled(0, 1, th1, 3, COLORS.p8_gray);
			draw_better_rectangle_filled(th1 + 1, 1, barWidth - 2, 3, COLORS.p8_white);
			draw_better_rectangle_filled(barWidth - 1, 1, barWidth - 1, 3, COLORS.p8_blue);
		
			// Draw current charge progress
			draw_better_rectangle_filled(_charge, 0, _charge, 4, COLORS.p8_white)
		
			surface_reset_target();
			draw_surface_ext(barSurface, owner.x - barWidth/2 + 1, owner.y + owner.size + 9, 1, 1, 0, c_white, 0.75);
		}
	}
	
	
	static setSpeed = function(_min, _max = -1)
	{
		if (_max == -1) _max = _min;
		spdMin = _min;
		spdMax = _max;
	}
}