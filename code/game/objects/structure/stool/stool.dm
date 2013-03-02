
/obj/structure/stool
	name = "stool"
	desc = "Apply butt."
	icon = 'objects.dmi'
	icon_state = "stool"
	flags = FPRINT
	pressure_resistance = 3*ONE_ATMOSPHERE

	ex_act(severity)
		switch(severity)
			if(1.0)
				//SN src = null
				del(src)
				return
			if(2.0)
				if (prob(50))
					//SN src = null
					del(src)
					return
			if(3.0)
				if (prob(5))
					//SN src = null
					del(src)
					return
			else
		return

	blob_act()
		if(prob(75))
			new /obj/item/stack/sheet/metal( src.loc )
			del(src)

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W, /obj/item/weapon/wrench))
			playsound(src.loc, 'Ratchet.ogg', 50, 1)
			new /obj/item/stack/sheet/metal( src.loc )
			//SN src = null
			del(src)
		return

	proc
		unbuckle_all()
			for(var/mob/M in src:buckled_mobs)
				if (M.buckled == src)
					M.buckled = null
					M.anchored = 0

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
					//world << "[M] is no longer buckled to [src]"
					M.anchored = 0
					M.buckled = null
					N++
			return N

		buckle_mob(mob/M as mob, mob/user as mob)
			if (!ticker)
				user << "You can't buckle anyone in before the game starts."
			if ((!( istype(M, /mob) ) || get_dist(src, user) > 1 || M.loc != src.loc || user.restrained() || usr.stat || M.buckled))
				return
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
			M.dir = src.dir
			src:buckled_mobs += M
			src.add_fingerprint(user)
			return
