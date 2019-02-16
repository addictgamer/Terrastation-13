/mob/Bump(atom/A)
	if(!
	..()
/mob/proc/Move_Towards(var/atom/A, distance = 1)
	turn_towards(A)
	while(distance)
		if(!Move(get_step(src, dir))
			return 0
		distance--
	return 1


/atom/proc/turn_towards(var/atom/A)
	if(A.x > x)
		if(A.y > y)
			dir = NORTHEAST
		else if(A.y < y)
			dir = SOUTHEAST
		else
			dir = EAST

	else if(A.x < x)
		if(A.y > y)
			dir = NORTHWEST
		else if(A.y < y)
			dir = SOUTHWEST
		else
			dir = WEST

	else if(A.y > y)
		dir = NORTH

	else if (A.y < y)
		dir = SOUTH