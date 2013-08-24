
/obj/item/weapon/storage/firstaid
	name = "First-Aid"
	desc = "In case of a boo-boo."
	icon_state = "firstaid"
	throw_speed = 2
	throw_range = 8
	var/empty = 0

/obj/item/weapon/storage/firstaid/fire
	name = "Fire First Aid"
	desc = "A kit for when you 'accidently' set toxins on fire and burn yourself."
	icon_state = "ointment"
	item_state = "firstaid-ointment"

/obj/item/weapon/storage/firstaid/fire/New()
	..()
	if (empty) return

	icon_state = pick("ointment","firefirstaid")

	new /obj/item/device/healthanalyzer( src )
	new /obj/item/weapon/reagent_containers/syringe/inaprovaline( src )
	new /obj/item/stack/medical/ointment( src )
	new /obj/item/stack/medical/ointment( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src ) //Replaced ointment with these since they actually work --Errorage
	return

/obj/item/weapon/storage/firstaid/regular
	icon_state = "firstaid"

/obj/item/weapon/storage/firstaid/regular/New()

	..()
	if (empty) return
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/device/healthanalyzer(src)
	new /obj/item/weapon/reagent_containers/syringe/inaprovaline( src )
	return

/obj/item/weapon/storage/firstaid/toxin
	name = "Toxin First Aid"
	desc = "Used to treat when you have a high amoutn of toxins in your body."
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"

/obj/item/weapon/storage/firstaid/toxin/New()

	..()
	if (empty) return

	icon_state = pick("antitoxin","antitoxfirstaid","antitoxfirstaid2","antitoxfirstaid3")

	new /obj/item/weapon/reagent_containers/syringe/antitoxin( src )
	new /obj/item/weapon/reagent_containers/syringe/antitoxin( src )
	new /obj/item/weapon/reagent_containers/syringe/antitoxin( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/device/healthanalyzer( src )
	return

/obj/item/weapon/storage/firstaid/o2
	name = "Oxygen Deprivation First Aid"
	desc = "A box full of oxygen goodies."
	icon_state = "o2"
	item_state = "firstaid-o2"

/obj/item/weapon/storage/firstaid/o2/New()

	..()
	if (empty) return
	new /obj/item/weapon/reagent_containers/pill/dexalin( src )
	new /obj/item/weapon/reagent_containers/pill/dexalin( src )
	new /obj/item/weapon/reagent_containers/pill/dexalin( src )
	new /obj/item/weapon/reagent_containers/pill/dexalin( src )
	new /obj/item/weapon/reagent_containers/syringe/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/syringe/inaprovaline( src )
	new /obj/item/device/healthanalyzer( src )
	return

/obj/item/weapon/storage/syringes
	name = "Syringes"
	desc = "A box full of syringes."
	desc = "A biohazard alert warning is printed on the box"
	icon_state = "syringe"

/obj/item/weapon/storage/syringes/New()
	..()
	new /obj/item/weapon/reagent_containers/syringe( src )
	new /obj/item/weapon/reagent_containers/syringe( src )
	new /obj/item/weapon/reagent_containers/syringe( src )
	new /obj/item/weapon/reagent_containers/syringe( src )
	new /obj/item/weapon/reagent_containers/syringe( src )
	new /obj/item/weapon/reagent_containers/syringe( src )
	new /obj/item/weapon/reagent_containers/syringe( src )
	return

/obj/item/weapon/storage/pill_bottle
	name = "pill bottle"
	desc = "This is told to hold untold horrors of pulls."
	icon_state = "pill_canister"
	icon = 'chemical.dmi'
	item_state = "contsolid"
	w_class = 2.0
	can_hold = list("/obj/item/weapon/reagent_containers/pill")

/obj/item/weapon/storage/pill_bottle/MouseDrop(obj/over_object as obj) //Quick pillbottle fix. -Agouri

	if (ishuman(usr) || ismonkey(usr)) //Can monkeys even place items in the pocket slots? Leaving this in just in case~
		var/mob/M = usr
		if (!( istype(over_object, /obj/screen) ))
			return ..()
		if ((!( M.restrained() ) && !( M.stat ) /*&& M.pocket == src*/))
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
		if (over_object == usr && in_range(src, usr) || usr.contents.Find(src))
			if (usr.s_active)
				usr.s_active.close(usr)
			src.show_to(usr)
			return
	return   ///////////////////////////////////////////////////////Alright, that should do it. *MARKER* for any possible runtimes

/obj/item/weapon/storage/pill_bottle/kelotane
	name = "Pill bottle (kelotane)"
	desc = "Contains pills used to treat burns."

/obj/item/weapon/storage/pill_bottle/kelotane/New()
	..()
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )
	new /obj/item/weapon/reagent_containers/pill/kelotane( src )

/obj/item/weapon/storage/pill_bottle/antitox
	name = "Pill bottle (Anti-toxin)"
	desc = "Contains pills used to counter toxins."

/obj/item/weapon/storage/pill_bottle/antitox/New()
	..()
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )
	new /obj/item/weapon/reagent_containers/pill/antitox( src )

/obj/item/weapon/storage/pill_bottle/inaprovaline
	name = "Pill bottle (inaprovaline)"
	desc = "Contains pills used to stabilize patients."

/obj/item/weapon/storage/pill_bottle/inaprovaline/New()
	..()
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/pill/inaprovaline( src )
