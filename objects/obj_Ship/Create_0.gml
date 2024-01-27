/// obj_Ship : Init

image_speed = 0;

moveVec = new vec2();
kbVec = new vec2();
kbVecDiminish = 0.95;

team = 0;
color = COLORS.p8_white;
size = 0;	// radius from center

internalName = "name";
name = "NAME";
description = "DESCRIPTION";


// Stats
hp = 1;
hpMax = 1;
shield = 0;
shieldMax = 0;

shieldRegen = {
	amount:		0.5,	// per second
	charge:		0,
	chargeMax:	7,		// in seconds
}

speedStat = {
	base:	0,
	add:	0,			// additive modifiers
	scale:	1,			// multiplicative modifiers (applied after add)
}
acceleration = 1/10;	// scaled with speed

weapons = [];
weaponInUse = noone;
fireRate = 1;

collisionDamage = 1;
collisionImmunity = 0;
collisionImmunityMax = 0.5;

items = [];
statuses = [];


// Flags and Other
movedThisFrame = false;	// if not triggered, decelerate on this frame
target = noone;
targetable = true;
hasOSP = false;
//destroyNextFrame = false;
AI = noone;
statBarWidth = 10;
statBarSurface = noone;
canMove = true;
flash = 0;	// draw ship as white for x frames
invincibility = 0;	// in seconds; cannot take damage


// Methods
setMaxHealth = function(n)
{
	n = min(n, 200);
	hpMax = n;
	hp = hpMax;
}

setMaxShield = function(n)
{
	n = min(n, 50);
	shieldMax = n;
	shield = shieldMax;
}

calculateSpeed = function()
{
	return (speedStat.base + speedStat.add) * speedStat.scale;
}

calculateAcceleration = function()
{
	return calculateSpeed() * acceleration;
}

getFront = function()	// front coords of ship; used by weapons
{
	return {x: x + dcos(image_angle) * size, y: y - dsin(image_angle) * size};
}

addMovement = function(vec)
{
	moveVec = moveVec.add(vec);
	var max_speed = calculateSpeed();
	if (moveVec.mag() > max_speed) moveVec = moveVec.setMag(max_speed);
	movedThisFrame = true;
}

getTotalMovement = function()
{
	return moveVec.add(kbVec);
}

useWeapon = function(index)
{
	if (weaponInUse == noone and index < array_length(weapons))
	{
		var wep = weapons[index];
		if (wep.charge >= wep.chargeMax)
		{
			weaponInUse = wep;
			weaponInUse.charge = 0;
			weaponInUse.use();
		}
	}
}

hasTarget = function()
{
	return instance_exists(target);
}

getNearestTarget = function()
{
	var ship = noone;
	var dist = infinity;
	with (obj_Ship)
	{
		if (id != other.id and team != other.team and targetable)
		{
			var d = point_distance(x, y, other.x, other.y);
			if (d < dist)
			{
				dist = d;
				ship = id;
			}
		}
	}
	return ship;
}

setSize = function(n)
{
	size = n;
	//sprite_index = spr_Circle256;
	//image_alpha = 0;
	image_xscale = size / 32;
	image_yscale = size / 32;
}
setSize(3);

setTeam = function(_team)
{
	team = _team;
	colors = [COLORS.p8_white, COLORS.p8_blue, COLORS.p8_red];
	color = colors[team];
}

isInvincible = function()
{
	return invincibility > 0;
}

destroy = function(proj = noone)
{
	// Create particles
	repeat (12) add_particle(x, y, random_range(0, 360), random_range(0.15, 0.25), irandom_range(1, 2), 0, random_range(0.8, 1.2), color);
	
	if (instance_exists(proj) and instance_exists(proj.owner)) proj.owner.procOnKill(proj, id);
	//destroyNextFrame = true;
	instance_destroy();
}


// Projectile Methods
fireBullet = function(proc_chain, _dir, _speed, _size = 0, _damage = 1)
{
	var front = getFront();
	var proj = instance_create_layer(front.x, front.y, "Projectiles", obj_Bullet);
	proj.matchTeam(id);
	proj.setVelocity(_dir, _speed);
	proj.setSize(_size);
	proj.damage = _damage;
	proj.owner = id;
	proj.procChain = proc_chain;
	return proj;
}

fireLaser = function(proc_chain, _dir, _damage = 1)
{
	var front = getFront();
	var proj = instance_create_layer(front.x, front.y, "Projectiles", obj_Laser);
	proj.matchTeam(id);
	proj.direction = _dir;
	proj.damage = _damage;
	proj.owner = id;
	proj.procChain = proc_chain;
	proj.findEndpoint();
	return proj;
}

fireRing = function(proc_chain, _x, _y, _radius, _damage = 1, _duration = 0.75)
{
	var proj = instance_create_layer(_x, _y, "Projectiles", obj_Ring);
	proj.matchTeam(id);
	proj.radiusMax = _radius;
	proj.duration = _duration;
	proj.damage = _damage;
	proj.owner = id;
	proj.procChain = proc_chain;
	return proj;
}


// Item Methods
pickupItem = function(_item)
{
	array_push(items, _item);
	_item.owner = id;
	_item.onPickup();
}

procOnShoot = function()
{
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onShoot();
		}
	}
}

procOnHit = function(proj, hit)
{
	if (!instance_exists(proj) or !instance_exists(hit)) return;
	
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onHit(proj, hit);
		}
	}
}

procOnKill = function(proj, hit)
{
	if (!instance_exists(proj) or !instance_exists(hit)) return;
	
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onKill(proj, hit);
		}
	}
}

procOnGettingHit = function(proj)
{
	if (!instance_exists(proj)) return;
	
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onGettingHit(proj);
		}
	}
}

procOnLosingHull = function(proj)
{
	if (!instance_exists(proj)) return;
	
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onLosingHull(proj);
		}
	}
}

procOnLosingShield = function(proj)
{
	if (!instance_exists(proj)) return;
	
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onLosingShield(proj);
		}
	}
}

procOnLevelStart = function()
{
	for (var p = 1; p <= 2; p++)
	{
		for (var i = 0; i < array_length(items); i++)
		{
			var _item = items[i];
			if (_item.procPriority == p) _item.onLevelStart();
		}
	}
}


// Status Methods
addStatus = function(_name, _duration = 1, _remove = function() {})
{
	array_push(statuses, [_name, _duration, _remove]);
}

removeStatus = function(_name)
{
	for (var i = 0; i < array_length(statuses); i++)
	{
		if (statuses[i][0] == _name)
		{
			statuses[i][2](id);	// run remove function
			array_delete(statuses, i, 1);
			return;
		}
	}
}

hasStatus = function(_name)
{
	for (var i = 0; i < array_length(statuses); i++)
	{
		if (statuses[i][0] == _name) return true;
	}
	return false;
}

getStatusDuration = function(_name)
{
	if (!hasStatus(_name)) return -1;
	
	for (var i = 0; i < array_length(statuses); i++)
	{
		if (statuses[i][0] == _name) return statuses[i][1];
	}
}


// AI Behavior Methods
AI_basic_init = function()
{
	randomMove = 0;
	randomMoveRange = [45, 90];
	randomMoveTimer = 0;
	randomMoveTimerMax = [1, 1.5];	// random bounds, in seconds
	moveAway = 30;					// min dist to move away
	moveTowards = 60;				// max dist to come closer
}

AI_gunner_init = function()
{
	randomMove = 0;
	randomMoveRange = [45, 90];
	randomMoveTimer = 0;
	randomMoveTimerMax = [1, 1.5];	// random bounds, in seconds
	moveAway = 40;					// min dist to move away
	moveTowards = 70;				// max dist to come closer
}

AI_enforcer_init = function()
{
	randomMove = 0;
	randomMoveRange = [45, 90];
	randomMoveTimer = 0;
	randomMoveTimerMax = [1, 1.5];	// random bounds, in seconds
	moveAway = 25;					// min dist to move away
	moveTowards = 50;				// max dist to come closer
}

AI_melee_drone_init = function()
{
	randomMove = 0;
	randomMoveRange = [45, 90];
	randomMoveTimer = 0;
	randomMoveTimerMax = [1, 1.5];	// random bounds, in seconds
	moveAway = 0;					// min dist to move away
	moveTowards = 0;				// max dist to come closer
}

AI_carrier_init = function()
{
	charge = 0;
	chargeMax = 6 - DIFFICULTY;		// in seconds; time to produce a drone
	
	drones = [];
	maxDrones = 3;
}

	
AI_basic_step = function(aim_ahead = false)
{
	if (!hasStatus("stun"))
	{
		// Find target
		target = getNearestTarget();
	
		if (instance_exists(target))
		{
			// Face target
			image_angle = point_direction(x, y, target.x, target.y);
		
			// Aim ahead
			if (aim_ahead)
			{
				var aim = calculate_aim_vector(getFront().x, getFront().y, lerp(weapons[0].spdMin, weapons[0].spdMax, 0.5), target);
				if (aim != -1) image_angle = aim.dir();
			}
			
			if (canMove)
			{
				// Movement
				// Keep between a distance range and move randomly
				var dist = point_distance(x, y, target.x, target.y);
				var dir = point_direction(x, y, target.x, target.y);

				if (dist < moveAway) randomMove = dir - 180;
				else if (dist > moveTowards) randomMove = dir;
				else
				{
					if (randomMoveTimer > 0) randomMoveTimer--;
					else
					{
						randomMoveTimer = irandom_range(randomMoveTimerMax[0] * room_speed, randomMoveTimerMax[1] * room_speed);
						randomMove += choose(random_range(-randomMoveRange[0], -randomMoveRange[1]), random_range(randomMoveRange[0], randomMoveRange[1]));
					}
				}

				var vec = (new vec2(calculateAcceleration())).setDir(randomMove);
				addMovement(vec);
			}
		}
	
		// Use weapons
		for (var i = 0; i < array_length(weapons); i++)
		{
			useWeapon(i);
		}
	}
}

AI_drone_step = function()
{
	AI_basic_step(true);
}

AI_carrier_step = function()
{
	if (!hasStatus("stun"))
	{
		// Spin
		image_angle += 2;
		
		// Remove dead drones
		for (var i = array_length(drones) - 1; i >= 0; i--)
		{
			if (!instance_exists(drones[i])) array_delete(drones, i, 1);
		}
	
		// Produce drones
		if (array_length(drones) < maxDrones) charge += 1/room_speed;
		
		if (charge >= chargeMax - 1) flash = 1;
		if (charge >= chargeMax)
		{
			charge = 0;
			
			var dir = random_range(0, 360);
			var dist = size + 4;
			var _x = x + (dcos(dir) * dist);
			var _y = y - (dsin(dir) * dist);
			
			var drone = create_ship(_x, _y, "meleeDrone", team, obj_Manager.level);		// debug
			
			// Set drone Hull (equal to 40% of self)
			drone.setMaxHealth(round(hpMax * 0.4));
			
			// Inherit items (funny)
			for (var i = 0; i < array_length(items); i++)
			{
				var _item = items[i];
				drone.pickupItem(create_item(_item.index));
			}
			
			// Create particles
			repeat (12) add_particle(_x, _y, random_range(0, 360), random_range(0.15, 0.25), choose(1, 2), 0, random_range(0.6, 1), color);
			
			array_push(drones, drone.id);
		}
	}
}


// Collision Methods
collisionWithBullets = function()
{
	if (isInvincible()) return;
	
	var collision_list = ds_list_create();
	instance_place_list(x, y, obj_Bullet, collision_list, false);
	for (var i = 0; i < ds_list_size(collision_list); i++)
	{
		var proj = collision_list[| i];
		
		if (team != proj.team)
		{
			// Proc onHit items
			// This comes first because some affect the projectile itself
			if (proj.proc and instance_exists(proj.owner)) proj.owner.procOnHit(proj, id);
	
			// Proc onGettingHit items
			procOnGettingHit(proj);
			
			// Round partially regenerated Shield points down
			shield = floor(shield);
			
			// Deal damage
			// If there is at least 1 point of Shield, it absorbs all the damage
			if (shield > 0)
			{
				procOnLosingShield(proj);
				shield = max(shield - proj.damage, 0);
			}
			else
			{
				procOnLosingHull(proj);
				if (!hasOSP or hp <= 1) hp = max(hp - proj.damage, 0);
				else hp = max(hp - proj.damage, 1);
			}
			
			// Reset Shield regen charge
			shieldRegen.charge = 0;
			
			// Knockback
			var vec = (new vec2(proj.spdOriginal * proj.kbMultiplier)).setDir(proj.direction);
			kbVec = kbVec.add(vec);
	
			// Display damage number
			create_damage_number(x, y - size - 6, proj.damage, team);
	
			// Check death
			if (hp <= 0) destroy(proj);
	
			// Destroy projectile
			proj.destroy();
		}
	}
	ds_list_destroy(collision_list);
}

collisionWithLasers = function()
{
	if (isInvincible()) return;
	
	with (obj_Laser)
	{
		if (team != other.team and !array_contains(hitList, other.id))
		{
			// Check collision
			//if (line_circle_collision(x, y, endX, endY, other.x, other.y, other.size))
			if (collision_line(x, y, endX, endY, other, false, false))
			{
				// Proc onHit items
				// This comes first because some affect the projectile itself
				if (proc and instance_exists(owner)) owner.procOnHit(id, other);
			
				// Proc onGettingHit items
				other.procOnGettingHit(id);
			
				// Round partially regenerated Shield points down
				other.shield = floor(other.shield);
			
				// Deal damage
				// If there is at least 1 point of Shield, it absorbs all the damage
				if (other.shield > 0)
				{
					other.procOnLosingShield(id);
					other.shield = max(other.shield - damage, 0);
				}
				else
				{
					other.procOnLosingHull(id);
					if (!other.hasOSP or other.hp <= 1) other.hp = max(other.hp - damage, 0);
					else other.hp = max(other.hp - damage, 0);
				}
			
				// Reset Shield regen charge
				other.shieldRegen.charge = 0;
			
				// Knockback
				//var vec = (new vec2(spdOriginal * kbMultiplier)).setDir(direction);
				//other.kbVec = other.kbVec.add(vec);
			
				// Display damage number
				create_damage_number(other.x, other.y - other.size - 6, damage, other.team);
			
				// Add to hitList
				array_push(hitList, other.id);
			
				// Check death
				if (other.hp <= 0) other.destroy(id);
			}
		}
	}
}

collisionWithRings = function()
{
	if (isInvincible()) return;
	
	var collision_list = ds_list_create();
	instance_place_list(x, y, obj_Ring, collision_list, false);
	for (var i = 0; i < ds_list_size(collision_list); i++)
	{
		var proj = collision_list[| i];
		
		if (team != proj.team and !array_contains(proj.hitList, id))
		{
			// Proc onHit items
			// This comes first because some affect the projectile itself
			if (proj.proc and instance_exists(proj.owner)) proj.owner.procOnHit(proj, id);
	
			// Proc onGettingHit items
			if (proj.damage > 0) procOnGettingHit(proj);
			
			// Round partially regenerated Shield points down
			shield = floor(shield);
			
			// Deal damage
			// If there is at least 1 point of Shield, it absorbs all the damage
			if (proj.damage > 0)
			{
				if (shield > 0)
				{
					procOnLosingShield(proj);
					shield = max(shield - proj.damage, 0);
				}
				else
				{
					procOnLosingHull(proj);
					if (!hasOSP or hp <= 1) hp = max(hp - proj.damage, 0);
					else hp = max(hp - proj.damage, 1);
				}
			}
			
			// Reset Shield regen charge
			shieldRegen.charge = 0;
			
			// Knockback
			//var vec = (new vec2(proj.spdOriginal * proj.kbMultiplier)).setDir(proj.direction);
			//kbVec = kbVec.add(vec);
	
			// Display damage number
			if (proj.displayDamageNumber) create_damage_number(x, y - size - 6, proj.damage, team);
	
			// Check death
			if (hp <= 0) destroy(proj);
			
			// Add to hitList
			array_push(proj.hitList, id);
		}
	}
	ds_list_destroy(collision_list);
}

collisionWithShips = function()
{
	var collision_list = ds_list_create();
	instance_place_list(x, y, obj_Ship, collision_list, false);
	for (var i = 0; i < ds_list_size(collision_list); i++)
	{
		var ship = collision_list[| i];
		
		if (ship.id != id)
		{
			var otherVec = (new vec2(ship.moveVec.mag() / 4)).setDir(point_direction(ship.x, ship.y, x, y));
			kbVec = kbVec.add(otherVec);

			var selfVec = (new vec2(moveVec.mag() / 4)).setDir(point_direction(x, y, ship.x, ship.y));
			ship.kbVec = ship.kbVec.add(selfVec);
			
			
			// Collision damage if not on same team
			if (team != ship.team and invincibility <= 0 and ship.invincibility <= 0)
			{
				// Self
				if (collisionImmunity <= 0)
				{
					collisionImmunity = collisionImmunityMax;
		
					// Take damage
					if (!hasStatus("meleeDash"))
					{
						if (ship.collisionDamage > 0)
						{
							var proj = ship.fireBullet([], ship.getTotalMovement().dir(), 1, 0, ship.collisionDamage);
							proj.x = x;
							proj.y = y;
							proj.visible = false;
						}
					}
				}
	
	
				// Other
				if (ship.collisionImmunity <= 0)
				{
					ship.collisionImmunity = ship.collisionImmunityMax;
		
					// Deal damage	
					if (collisionDamage > 0)
					{
						var proj = fireBullet([], ship.getTotalMovement().dir(), 1, 0, collisionDamage);
						proj.x = ship.x;
						proj.y = ship.y;
						proj.visible = false;
					}
						
					// Inflict stun (melee attack)
					// and add hit ID to list for Shield restoration
					if (hasStatus("meleeDash"))
					{
						ship.addStatus("stun", 1/fireRate);	// lower Stun duration with fire rate to avoid infinite stun locks
						array_push(weapons[0].hitList, ship);
					}
				}
			}
		}
	}
	ds_list_destroy(collision_list);
}