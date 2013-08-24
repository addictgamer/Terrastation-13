
/datum/construction/mecha/firefighter
	result = "/obj/mecha/working/firefighter"
	steps = list(list("key"="/obj/item/weapon/weldingtool"),//1
					 list("key"="/obj/item/weapon/wrench"),//2
					 list("key"="/obj/item/stack/sheet/r_metal"),//3
					 list("key"="/obj/item/weapon/weldingtool"),//4
					 list("key"="/obj/item/weapon/wrench"),//5
					 list("key"="/obj/item/stack/sheet/metal"),//6
					 list("key"="/obj/item/weapon/screwdriver"),//7
					 list("key"="/obj/item/mecha_parts/circuitboard/firefighter/peripherals"),//8
					 list("key"="/obj/item/weapon/screwdriver"),//9
					 list("key"="/obj/item/mecha_parts/circuitboard/ripley/main"),//10
					 list("key"="/obj/item/weapon/wirecutters"),//11
					 list("key"="/obj/item/weapon/cable_coil"),//12
					 list("key"="/obj/item/weapon/screwdriver"),//13
					 list("key"="/obj/item/weapon/wrench")//14
					)

	action(atom/used_atom,mob/user as mob)
		return check_step(used_atom,user)


	custom_action(step, atom/used_atom, mob/user)
		if (!..())
			return 0

		//TODO: better messages.
		switch(step)
			if (14)
				user.visible_message("[user] connects [holder] hydraulic systems", "You connect [holder] hydraulic systems.")
			if (13)
				user.visible_message("[user] adjusts [holder] hydraulic systems.", "You adjust [holder] hydraulic systems.")
			if (12)
				user.visible_message("[user] adds the wiring to [holder].", "You add the wiring to [holder].")
			if (11)
				user.visible_message("[user] adjusts the wiring of [holder].", "You adjust the wiring of [holder].")
			if (10)
				user.visible_message("[user] installs the central control module into [holder].", "You install the central computer mainboard into [holder].")
				del used_atom
			if (9)
				user.visible_message("[user] secures the mainboard.", "You secure the mainboard.")
			if (8)
				user.visible_message("[user] installs the peripherals control module into [holder].", "You install the peripherals control module into [holder].")
				del used_atom
			if (7)
				user.visible_message("[user] secures the peripherals control module.", "You secure the peripherals control module.")
			if (6)
				user.visible_message("[user] installs internal armor layer to [holder].", "You install internal armor layer to [holder].")
			if (5)
				user.visible_message("[user] secures internal armor layer.", "You secure internal armor layer.")
			if (4)
				user.visible_message("[user] welds internal armor layer to [holder].", "You weld the internal armor layer to [holder].")
			if (3)
				user.visible_message("[user] installs external reinforced armor layer to [holder].", "You install external reinforced armor layer to [holder].")
			if (2)
				user.visible_message("[user] secures external armor layer.", "You secure external reinforced armor layer.")
			if (1)
				user.visible_message("[user] welds external armor layer to [holder].", "You weld external armor layer to [holder].")
		return 1
