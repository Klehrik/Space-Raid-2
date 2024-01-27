/// obj_Ship : Collision : obj_Ring

//if (!isInvincible() and team != other.team and !array_contains(other.hitList, id))
//{
//	// Proc onHit items
//	// This comes first because some affect the projectile itself
//	if (other.proc and instance_exists(other.owner)) other.owner.procOnHit(other, id);
	
//	// Proc onGettingHit items
//	if (other.damage > 0) procOnGettingHit(other);
			
//	// Round partially regenerated Shield points down
//	shield = floor(shield);
			
//	// Deal damage
//	// If there is at least 1 point of Shield, it absorbs all the damage
//	if (other.damage > 0)
//	{
//		if (shield > 0)
//		{
//			procOnLosingShield(other);
//			shield = max(shield - other.damage, 0);
//		}
//		else
//		{
//			procOnLosingHull(other);
//			if (!hasOSP or hp <= 1) hp = max(hp - other.damage, 0);
//			else hp = max(hp - other.damage, 1);
//		}
		
//		// Reset Shield regen charge
//		shieldRegen.charge = 0;
//	}
			
//	// Knockback
//	//var vec = (new vec2(other.spdOriginal * other.kbMultiplier)).setDir(other.direction);
//	//kbVec = kbVec.add(vec);
	
//	// Display damage number
//	if (other.displayDamageNumber) create_damage_number(x, y - size - 6, other.damage, team);
	
//	// Check death
//	if (hp <= 0) destroy(other);
	
//	// Add to hitList
//	array_push(other.hitList, id);
//}