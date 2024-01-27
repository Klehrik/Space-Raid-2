/// obj_Ring : Step

setHitbox();

lerpTime = min(lerpTime + 1/room_speed, lerpTimeMax);
time += 1/room_speed;
if (time >= duration) destroy();