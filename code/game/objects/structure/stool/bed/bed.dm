
/obj/structure/stool/bed
	name = "bed"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "bed"
	anchored = 1.0
	var/list/buckled_mobs = list(  )

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		..()
		if (istype(W, /obj/item/weapon/wrench))
			playsound(src.loc, 'Ratchet.ogg', 50, 1)
			new /obj/item/stack/sheet/metal( src.loc )
			del(src)
		return

	Del()
		for(var/mob/M in src.buckled_mobs)
			if (M.buckled == src)
				M.lying = 0
		unbuckle_all()
		..()
		return

	MouseDrop_T(mob/M as mob, mob/user as mob)
		if (!istype(M)) return
		buckle_mob(M, user)
		M.lying = 1
		return

	attack_hand(mob/user as mob)
		for(var/mob/M in src.buckled_mobs)
			if (M.buckled == src)
				M.lying = 0
		if (manual_unbuckle_all(user))
			src.add_fingerprint(user)
		return
