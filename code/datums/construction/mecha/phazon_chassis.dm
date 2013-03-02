
/datum/construction/mecha/phazon_chassis
	result = "/obj/mecha/combat/phazon"
	steps = list(list("key"="/obj/item/mecha_parts/part/phazon_torso"),//1
					 list("key"="/obj/item/mecha_parts/part/phazon_left_arm"),//2
					 list("key"="/obj/item/mecha_parts/part/phazon_right_arm"),//3
					 list("key"="/obj/item/mecha_parts/part/phazon_left_leg"),//4
					 list("key"="/obj/item/mecha_parts/part/phazon_right_leg"),//5
					 list("key"="/obj/item/mecha_parts/part/phazon_head")
					)

	custom_action(step, atom/used_atom, mob/user)
		user.visible_message("[user] has connected [used_atom] to [holder].", "You connect [used_atom] to [holder]")
		holder.overlays += used_atom.icon_state+"+o"
		del used_atom
		return 1

	action(atom/used_atom,mob/user as mob)
		return check_all_steps(used_atom,user)
