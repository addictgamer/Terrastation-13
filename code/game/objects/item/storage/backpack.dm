
/obj/item/weapon/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	w_class = 4.0
	flags = 259.0
	max_w_class = 3
	max_combined_w_class = 20

/obj/item/weapon/storage/backpack/MouseDrop(obj/over_object as obj)

//	if (src.loc != usr)
//		return
//	if ((istype(usr, /mob/living/carbon/human) || (ticker && ticker.mode.name == "monkey")))
	if (ishuman(usr) || ismonkey(usr)) //so monkies can take off their backpacks -- Urist
		var/mob/M = usr
		if (!( istype(over_object, /obj/screen) ))
			return ..()
		playsound(src.loc, "rustle", 50, 1, -5)
		if ((!( M.restrained() ) && !( M.stat ) && M.back == src))
			if (over_object.name == "r_hand")
				if (!( M.r_hand ))
					M.u_equip(src)
					M.r_hand = src
			else
				if (over_object.name == "l_hand")
					if (!( M.l_hand ))
						M.u_equip(src)
						M.l_hand = src
			M.update_clothing()
			src.add_fingerprint(usr)
			return
		if(over_object == usr && in_range(src, usr) || usr.contents.Find(src))
			if (usr.s_active)
				usr.s_active.close(usr)
			src.show_to(usr)
			return
	return

/obj/item/weapon/storage/backpack/attackby(obj/item/weapon/W as obj, mob/user as mob)
	playsound(src.loc, "rustle", 50, 1, -5)
	..()


/obj/item/weapon/storage/backpack/holding
	name = "Bag of Holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = "bluespace=4"
	icon_state = "holdingpack"

/obj/item/weapon/storage/backpack/holding/New()
	..()
	return

/obj/item/weapon/storage/backpack/holding/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(crit_fail)
		user << "\red The Bluespace generator isn't working."
		return
	if(istype(W, /obj/item/weapon/storage/backpack/holding) && !W.crit_fail)
		user << "\red The Bluespace interfaces of the two devices catastrophically malfunction!"
		del(W)
		new /obj/machinery/singularity (get_turf(src))
		message_admins("[key_name_admin(user)] detonated a bag of holding")
		log_game("[key_name(user)] detonated a bag of holding")
		del(src)
		return
	..()

/obj/item/weapon/storage/backpack/holding/proc/failcheck(mob/user as mob)
	if (prob(src.reliability)) return 1 //No failure
	if (prob(src.reliability))
		user << "\red The Bluespace portal resists your attempt to add another item." //light failure
	else
		user << "\red The Bluespace generator malfunctions!"
		for (var/obj/O in src.contents) //it broke, delete what was in it
			del(O)
		crit_fail = 1
		icon_state = "brokenpack"

/obj/item/weapon/storage/backpack/clown
	name = "Giggles Von Honkerton"
	desc = "The backpack made by Honk. Co."
	icon_state = "clownpack"

/obj/item/weapon/storage/backpack/medic
	name = "medic's backpack"
	desc = "The backpack used to keep with the sterile environment."
	icon_state = "medicalpack"

/obj/item/weapon/storage/backpack/security
	name = "security backpack"
	desc = "A very robust backpack."
	icon_state = "securitypack"

/obj/item/weapon/storage/backpack/satchel
	name = "Satchel"
	desc = "A very robust satchel to wear on your back."
	icon_state = "satchel"

/obj/item/weapon/storage/backpack/bandolier
	name = "Bandolier"
	desc = "A very old bandolier to wear on your back."
	icon_state = "bandolier"

/obj/item/weapon/storage/backpack/industrial
	name = "industrial backpack"
	desc = "A tough backpack for the daily grind"
	icon_state = "engiepack"
