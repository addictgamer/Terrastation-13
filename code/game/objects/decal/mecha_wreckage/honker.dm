
/obj/decal/mecha_wreckage/honker
	name = "Honker wreckage"
	icon_state = "honker-broken"

	New()
		..()
		var/list/parts = list(
								/obj/item/mecha_parts/chassis/honker,
								/obj/item/mecha_parts/part/honker_torso,
								/obj/item/mecha_parts/part/honker_head,
								/obj/item/mecha_parts/part/honker_left_arm,
								/obj/item/mecha_parts/part/honker_right_arm,
								/obj/item/mecha_parts/part/honker_left_leg,
								/obj/item/mecha_parts/part/honker_right_leg)
		for(var/i=0;i<2;i++)
			if(!isemptylist(parts) && prob(40))
				var/part = pick(parts)
				welder_salvage += part
				parts -= part
		return
