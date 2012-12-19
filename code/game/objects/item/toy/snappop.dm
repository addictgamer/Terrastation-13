
/obj/item/toy/snappop
	name = "snap pop"
	desc = "Wow!"
	icon = 'toy.dmi'
	icon_state = "snappop"

	throw_impact(atom/hit_atom)
		..()
		var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		new /obj/decal/ash(src.loc)
		src.visible_message("\red The [src.name] explodes!","\red You hear a snap!")
		playsound(src, 'snap.ogg', 50, 1)
		del(src)

/obj/item/toy/snappop/HasEntered(H as mob|obj)
	if((ishuman(H))) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(M.m_intent == "run")
			M << "\red You step on the snap pop!"

			var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
			s.set_up(2, 0, src)
			s.start()
			new /obj/decal/ash(src.loc)
			src.visible_message("\red The [src.name] explodes!","\red You hear a snap!")
			playsound(src, 'snap.ogg', 50, 1)
			del(src)

/obj/item/toy/snappopbox
	name = "snap pop box"
	desc = "Eight wrappers of fun! Ages 8 and up. Not suitable for children."
	icon = 'toy.dmi'
	icon_state = "spbox"
	var/amount = 8

/obj/item/toy/snappopbox/attack_hand(mob/user as mob, unused, flag)
	add_fingerprint(user)

	if(user.r_hand == src || user.l_hand == src)
		if(amount)
			var/obj/item/toy/snappop/M = new /obj/item/toy/snappop(src)
			if (user.hand)
				user.l_hand = M
			else
				user.r_hand = M
			M.loc = user
			M.layer = 20
			user.update_clothing()
			user << "You take a snap pop out of the box."
			amount--
		else
			user << "There are no snap pops left in the box."
	else
		..()

	return

/obj/item/toy/snappopbox/attack_paw(mob/user as mob)
	return attack_hand(user)
