
// *************************************
// Hydroponics Tools
// *************************************

// Weed spray

/obj/item/weapon/weedspray // -- Skie
	desc = "Toxic mixture in spray form to kill small weeds."
	icon = 'hydroponics.dmi'
	name = "Weed Spray"
	icon_state = "weedspray"
	item_state = "spray"
	flags = ONBELT|TABLEPASS|OPENCONTAINER|FPRINT|USEDELAY
	throwforce = 4
	w_class = 2.0
	throw_speed = 2
	throw_range = 10
	var/toxicity = 4
	var/WeedKillStr = 2

// Pest spray

/obj/item/weapon/pestspray // -- Skie
	desc = "Pest eliminator spray! Do not inhale!"
	icon = 'hydroponics.dmi'
	name = "Pest Spray"
	icon_state = "pestspray"
	item_state = "spray"
	flags = ONBELT|TABLEPASS|OPENCONTAINER|FPRINT|USEDELAY
	throwforce = 4
	w_class = 2.0
	throw_speed = 2
	throw_range = 10
	var/toxicity = 4
	var/PestKillStr = 2

// Mini how

/obj/item/weapon/minihoe // -- Numbers
	name = "Mini hoe"
	desc = "Not that kind of hoe. Use for removing weeds or scratching your back. Might be convinced for other uses."
	icon = 'weapons.dmi'
	icon_state = "hoe"
	item_state = "hoe"
	flags = FPRINT | TABLEPASS | CONDUCT | USEDELAY
	force = 5.0
	throwforce = 7.0
	w_class = 2.0
	m_amt = 50

// Plant-B-Gone

/obj/item/weapon/plantbgone // -- Skie
	desc = "Plant-B-Gone! Kill those pesky weeds!"
	icon = 'hydroponics.dmi'
	name = "Plant-B-Gone"
	icon_state = "plantbgone"
	item_state = "plantbgone"
	flags = ONBELT|TABLEPASS|OPENCONTAINER|FPRINT|USEDELAY
	throwforce = 3
	w_class = 2.0
	throw_speed = 2
	throw_range = 10
	var/empty = 0

/obj/item/weapon/plantbgone/New()
	var/datum/reagents/R = new/datum/reagents(100) // 100 units of solution
	reagents = R
	R.my_atom = src
	R.add_reagent("plantbgone", 100)

/obj/item/weapon/plantbgone/attack(mob/living/carbon/human/M as mob, mob/user as mob)
	return

/obj/item/weapon/plantbgone/afterattack(atom/A as mob|obj, mob/user as mob)

	if (istype(A, /obj/item/weapon/storage/backpack ))
		return

	else if (locate (/obj/table, src.loc))
		return

	else if (src.reagents.total_volume < 1)
		src.empty = 1
		user << "\blue Add more Plant-B-Gone mixture!"
		return

	else
		src.empty = 0

		if (istype(A, /obj/machinery/hydroponics)) // We are targeting hydrotray
			return

		else if (istype(A, /obj/blob)) // blob damage in blob code
			return

		else
			var/obj/decal/D = new/obj/decal/(get_turf(src)) // Targeting elsewhere
			D.name = "chemicals"
			D.icon = 'chemical.dmi'
			D.icon_state = "weedpuff"
			D.create_reagents(5)
			src.reagents.trans_to(D, 5) // 5 units of solution used at a time => 20 uses
			playsound(src.loc, 'spray3.ogg', 50, 1, -6)

			spawn(0)
				for(var/i=0, i<3, i++) // Max range = 3 tiles
					step_towards(D,A) // Moves towards target as normally (not thru walls)
					D.reagents.reaction(get_turf(D))
					for(var/atom/T in get_turf(D))
						D.reagents.reaction(T)
					sleep(4)
				del(D)

			return

/obj/item/weapon/plantbgone/examine()
	set src in usr
	usr << text("\icon[] [] units of Plant-B-Gone left!", src, src.reagents.total_volume)
	..()
	return
