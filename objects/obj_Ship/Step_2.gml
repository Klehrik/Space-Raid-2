/// obj_Ship : End Step

collisionWithBullets();
collisionWithLasers();
collisionWithRings();
collisionWithShips();

// Decelerate
if (!movedThisFrame)
{
	moveVec = moveVec.setMag(moveVec.mag() - calculateAcceleration(), true);
}

// Apply movement
x += moveVec.x + kbVec.x;
y += moveVec.y + kbVec.y;

// Decrease knockback vector
kbVec = kbVec.setMag(kbVec.mag() * kbVecDiminish, true);
if (kbVec.mag < calculateAcceleration()) kbVec = new vec2();

// Keep ship within arena bounds
if (x < ARENA.xStart + size or x > ARENA.xEnd - size)
{
	moveVec = new vec2(0, moveVec.y);
	kbVec = new vec2(0, kbVec.y);
}
if (y < ARENA.yStart + size or y > ARENA.yEnd - size)
{
	moveVec = new vec2(moveVec.x, 0);
	kbVec = new vec2(kbVec.x, 0);
}
x = clamp(x, ARENA.xStart + size, ARENA.xEnd - size);
y = clamp(y, ARENA.yStart + size, ARENA.yEnd - size);