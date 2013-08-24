
/datum/construction/mecha/durand
	result = "/obj/mecha/combat/durand"
	steps = list(list("key"="/obj/item/weapon/weldingtool"),//1
					 list("key"="/obj/item/weapon/wrench"),//2
					 list("key"="/obj/item/mecha_parts/part/durand_armour"),//3
					 list("key"="/obj/item/weapon/weldingtool"),//4
					 list("key"="/obj/item/weapon/wrench"),//5
					 list("key"="/obj/item/stack/sheet/metal"),//6
					 list("key"="/obj/item/weapon/screwdriver"),//7
					 list("key"="/obj/item/weapon/stock_parts/capacitor/adv"),//8
					 list("key"="/obj/item/weapon/screwdriver"),//9
					 list("key"="/obj/item/weapon/stock_parts/scanning_module/adv"),//10
					 list("key"="/obj/item/weapon/screwdriver"),//11
					 list("key"="/obj/item/mecha_parts/circuitboard/durand/targeting"),//12
					 list("key"="/obj/item/weapon/screwdriver"),//13
					 list("key"="/obj/item/mecha_parts/circuitboard/durand/peripherals"),//14
					 list("key"="/obj/item/weapon/screwdriver"),//15
					 list("key"="/obj/item/mecha_parts/circuitboard/durand/main"),//16
					 list("key"="/obj/item/weapon/wirecutters"),//17
					 list("key"="/obj/item/cable_coil"),//18
					 list("key"="/obj/item/weapon/screwdriver"),//19
					 list("key"="/obj/item/weapon/wrench")//20
					)

	action(atom/used_atom,mob/user as mob)
		return check_step(used_atom,user)

	custom_action(step, atom/used_atom, mob/user)
		if (!..())
			return 0

		//TODO: better messages.
		switch(step)
			if (20)
				user.visible_message("[user] connects [holder] hydraulic systems", "You connect [holder] hydraulic systems.")
			if (19)
				user.visible_message("[user] adjusts [holder] hydraulic systems.", "You adjust [holder] hydraulic systems.")
			if (18)
				user.visible_message("[user] adds the wiring to [holder].", "You add the wiring to [holder].")
			if (17)
				user.visible_message("[user] adjusts the wiring of [holder].", "You adjust the wiring of [holder].")
			if (16)
				user.visible_message("[user] installs the central control module into [holder].", "You install the central computer mainboard into [holder].")
				del used_atom
			if (15)
				user.visible_message("[user] secures the mainboard.", "You secure the mainboard.")
			if (14)
				user.visible_message("[user] installs the peripherals control module into [holder].", "You install the peripherals control module into [holder].")
				del used_atom
			if (13)
				user.visible_message("[user] secures the peripherals control module.", "You secure the peripherals control module.")
			if (12)
				user.visible_message("[user] installs the weapon control module into [holder].", "You install the weapon control module into [holder].")
				del used_atom
			if (11)
				user.visible_message("[user] secures the weapon control module.", "You secure the weapon control module.")
			if (10)
				user.visible_message("[user] installs advanced scanner module to [holder].", "You install advanced scanner module to [holder].")
				del used_atom
			if (9)
				user.visible_message("[user] secures the advanced scanner module.", "You secure the advanced scanner module.")
			if (8)
				user.visible_message("[user] installs advanced capacitor to [holder].", "You install advanced capacitor to [holder].")
				del used_atom
			if (7)
				user.visible_message("[user] secures the advanced capacitor.", "You secure the advanced capacitor.")
			if (6)
				user.visible_message("[user] installs internal armor layer to [holder].", "You install internal armor layer to [holder].")
			if (5)
				user.visible_message("[user] secures internal armor layer.", "You secure internal armor layer.")
			if (4)
				user.visible_message("[user] welds internal armor layer to [holder].", "You weld the internal armor layer to [holder].")
			if (3)
				user.visible_message("[user] installs Durand Armour Plates to [holder].", "You install Durand Armour Plates to [holder].")
				holder.overlays += used_atom.icon_state
				del used_atom
			if (2)
				user.visible_message("[user] secures Durand Armour Plates.", "You secure Durand Armour Plates.")
			if (1)
				user.visible_message("[user] welds Durand Armour Plates to [holder].", "You weld Durand Armour Plates to [holder].")
		return 1
