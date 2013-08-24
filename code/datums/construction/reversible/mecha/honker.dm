
/datum/construction/mecha/honker
	result = "/obj/mecha/combat/honker"
	steps = list(list("key"="/obj/item/weapon/bikehorn"),//1
					 list("key"="/obj/item/clothing/shoes/clown_shoes"),//2
					 list("key"="/obj/item/weapon/bikehorn"),//3
					 list("key"="/obj/item/clothing/mask/gas/clown_hat"),//4
					 list("key"="/obj/item/weapon/bikehorn"),//5
					 list("key"="/obj/item/mecha_parts/circuitboard/honker/targeting"),//6
					 list("key"="/obj/item/weapon/bikehorn"),//7
					 list("key"="/obj/item/mecha_parts/circuitboard/honker/peripherals"),//8
					 list("key"="/obj/item/weapon/bikehorn"),//9
					 list("key"="/obj/item/mecha_parts/circuitboard/honker/main"),//10
					 list("key"="/obj/item/weapon/bikehorn"),//11
					 )

	action(atom/used_atom,mob/user as mob)
		return check_step(used_atom,user)

	custom_action(step, atom/used_atom, mob/user)
		if (!..())
			return 0

		if (istype(used_atom, /obj/item/weapon/bikehorn))
			playsound(holder, 'bikehorn.ogg', 50, 1)
			user.visible_message("HONK!")

		//TODO: better messages.
		switch(step)
			if (10)
				user.visible_message("[user] installs the central control module into [holder].", "You install the central control module into [holder].")
				del used_atom
			if (8)
				user.visible_message("[user] installs the peripherals control module into [holder].", "You install the peripherals control module into [holder].")
				del used_atom
			if (6)
				user.visible_message("[user] installs the weapon control module into [holder].", "You install the weapon control module into [holder].")
				del used_atom
			if (4)
				user.visible_message("[user] puts clown wig and mask on [holder].", "You put clown wig and mask on [holder].")
				del used_atom
			if (2)
				user.visible_message("[user] puts clown boots on [holder].", "You put clown boots on [holder].")
				del used_atom
		return 1
