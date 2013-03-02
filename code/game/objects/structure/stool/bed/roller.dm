
/obj/structure/stool/bed/roller
	name = "roller bed"
	icon = 'rollerbed.dmi'
	icon_state = "down"
	anchored = 0

	Move()
		..()
		for(var/mob/M in src:buckled_mobs)
			if (M.buckled == src)
				M.loc = src.loc

	buckle_mob(mob/M as mob, mob/user as mob)
		if (!ticker)
			user << "You can't buckle anyone in before the game starts."
			return 0
		if ((!( istype(M, /mob) ) || get_dist(src, user) > 1 || M.loc != src.loc || user.restrained() || usr.stat || M.buckled))
			return 0
		if (M == usr)
			M.visible_message(\
				"\blue [M.name] buckles in!",\
				"You buckle yourself to [src].",\
				"You hear metal clanking")
		else
			M.visible_message(\
				"\blue [M.name] is buckled in to [src] by [user.name]!",\
				"You buckled in to [src] by [user.name].",\
				"You hear metal clanking")
		M.anchored = 1
		M.buckled = src
		M.loc = src.loc
		M.pixel_y = 6
		M.update_clothing()
		src:buckled_mobs += M
		src.add_fingerprint(user)
		density = 1
		icon_state = "up"
		return 1

	manual_unbuckle_all(mob/user as mob)
		var/N = 0;
		for(var/mob/M in src:buckled_mobs)
			if (M.buckled == src)
				if (M != user)
					M.visible_message(\
						"\blue [M.name] was unbuckled by [user.name]!",\
						"You unbuckled from [src] by [user.name].",\
						"You hear metal clanking")
				else
					M.visible_message(\
						"\blue [M.name] was unbuckled himself!",\
						"You unbuckle yourself from [src].",\
						"You hear metal clanking")
				M.pixel_y = 0
				M.anchored = 0
				M.buckled = null
				N++
		if(N)
			density = 0
			icon_state = "down"
		return N
