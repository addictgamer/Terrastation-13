
/obj/decal/mecha_wreckage/phazon
	name = "Phazon wreckage"
	icon_state = "phazon-broken"

	New()
		..()
		var/list/parts = list(
									/obj/item/mecha_parts/part/phazon_torso,
									/obj/item/mecha_parts/part/phazon_head,
									/obj/item/mecha_parts/part/phazon_left_arm,
									/obj/item/mecha_parts/part/phazon_right_arm,
									/obj/item/mecha_parts/part/phazon_left_leg,
									/obj/item/mecha_parts/part/phazon_right_leg)
		for(var/i=0;i<2;i++)
			if(!isemptylist(parts) && prob(40))
				var/part = pick(parts)
				welder_salvage += part
				parts -= part
		return
