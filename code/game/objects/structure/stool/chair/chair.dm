
/obj/structure/stool/chair
	name = "chair"
	desc = "You sit in this. Either by will or force."
	icon_state = "chair"
	var/status = 0.0
	anchored = 1.0
	var/list/buckled_mobs = list(  )

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		..()
		if (istype(W, /obj/item/assembly/shock_kit))
			var/obj/structure/stool/chair/e_chair/E = new /obj/structure/stool/chair/e_chair( src.loc )
			playsound(src.loc, 'Deconstruct.ogg', 50, 1)
			E.dir = src.dir
			E.part1 = W
			W.loc = E
			W.master = E
			user.u_equip(W)
			W.layer = initial(W.layer)
			//SN src = null
			del(src)
			return
		return

	ex_act(severity)
		unbuckle_all()
		switch(severity)
			if (1.0)
				del(src)
				return
			if (2.0)
				if (prob(50))
					del(src)
					return
			if (3.0)
				if (prob(5))
					del(src)
					return
		return

	blob_act()
		if (prob(75))
			unbuckle_all()
			del(src)

	New()
		src.verbs -= /atom/movable/verb/pull
		if (src.dir == NORTH)
			src.layer = FLY_LAYER
		..()
		return

	Del()
		unbuckle_all()
		..()
		return

	MouseDrop_T(mob/M as mob, mob/user as mob)
		buckle_mob(M, user)
		return

	attack_paw(mob/user as mob)
		return src.attack_hand(user)

	attack_hand(mob/user as mob)
		if (manual_unbuckle_all(user))
			src.add_fingerprint(user)
		return

	verb
		rotate()
			set name = "Rotate Chair"
			set category = "Object"
			set src in oview(1)
			src.dir = turn(src.dir, 90)
			if (src.dir == NORTH)
				src.layer = FLY_LAYER
			else
				src.layer = OBJ_LAYER
			return
