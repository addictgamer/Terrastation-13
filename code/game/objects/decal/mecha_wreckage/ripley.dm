
/obj/decal/mecha_wreckage/ripley
	name = "Ripley wreckage"
	icon_state = "ripley-broken"

	New()
		..()
		var/list/parts = list(/obj/item/mecha_parts/part/ripley_torso,
									/obj/item/mecha_parts/part/ripley_left_arm,
									/obj/item/mecha_parts/part/ripley_right_arm,
									/obj/item/mecha_parts/part/ripley_left_leg,
									/obj/item/mecha_parts/part/ripley_right_leg)
		for(var/i=0;i<2;i++)
			if(!isemptylist(parts) && prob(40))
				var/part = pick(parts)
				welder_salvage += part
				parts -= part
		return
