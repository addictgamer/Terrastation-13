
/obj/decal/mecha_wreckage/gygax
	name = "Gygax wreckage"
	icon_state = "gygax-broken"

	New()
		..()
		var/list/parts = list(
									/obj/item/mecha_parts/part/gygax/gygax_torso,
									/obj/item/mecha_parts/part/gygax_head,
									/obj/item/mecha_parts/part/gygax_left_arm,
									/obj/item/mecha_parts/part/gygax_right_arm,
									/obj/item/mecha_parts/part/gygax_left_leg,
									/obj/item/mecha_parts/part/gygax_right_leg)
		for(var/i=0;i<2;i++)
			if(!isemptylist(parts) && prob(40))
				var/part = pick(parts)
				welder_salvage += part
				parts -= part
		return
