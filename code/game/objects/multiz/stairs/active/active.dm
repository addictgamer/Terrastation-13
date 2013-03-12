
/obj/multiz/stairs/active
	density = 1

	Bumped(var/atom/movable/M)
		if(istype(src, /obj/multiz/stairs/active/bottom) && !locate(/obj/multiz/stairs/enter) in M.loc)
			return //If on bottom, only let them go up stairs if they've moved to the entry tile first.
		//If it's the top, they can fall down just fine.
		if(ismob(M) && M:client)
			M:client.moving = 1
		M.Move(locate(src.x, src.y, targetZ()))
		if (ismob(M) && M:client)
			M:client.moving = 0

	Click()
		if(!istype(usr,/mob/dead/observer))
			return ..()
		usr.client.moving = 1
		usr.Move(locate(src.x, src.y, targetZ()))
		usr.client.moving = 0
