/// Skill : Dash

function skill_Dash(_owner = noone) : skill_Base(_owner) constructor
{
	// Variables
	setCharge(4);
	
	velocity = 2;
	direction = 0;
	time = 0;
	timeMax = 15;
	
	
	// Methods
	static use = function()
	{
		// Get inputted direction
		var axis = input_xy("left", "right", "up", "down");
		direction = point_direction(0, 0, axis.x, axis.y);
	}
	
	
	static step = function()
	{
		if (time < timeMax)
		{
			time++;
			
			// Give invincibility
			owner.invincibility = 2;
			owner.flash = 2;
			
			// Dash in inputted direction
			var vec = (new vec2(owner.calculateSpeed() * velocity)).setDir(direction);
			owner.kbVec = vec;
			
			// Create particles
			if (time mod 3 == 0) add_particle(owner.x, owner.y, random_range(0, 360), random_range(0.1, 0.15), 2, 0, random_range(0.4, 0.8), owner.color);
		}
		
		else
		{
			// Reset skillInUse
			owner.skillInUse = false;
			time = 0;
		}
	}
}