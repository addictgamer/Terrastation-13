
/obj/decal/mecha_wreckage/durand
	name = "Durand wreckage"
	icon_state = "durand-broken"

	New()
		..()
		var/list/parts = list(
									/obj/item/mecha_parts/part/durand_torso,
									/obj/item/mecha_parts/part/durand_head,
									/obj/item/mecha_parts/part/durand_left_arm,
									/obj/item/mecha_parts/part/durand_right_arm,
									/obj/item/mecha_parts/part/durand_left_leg,
									/obj/item/mecha_parts/part/durand_right_leg)
		for(var/i=0;i<2;i++)
			if(!isemptylist(parts) && prob(40))
				var/part = pick(parts)
				welder_salvage += part
				parts -= part
		return
