
/obj/item/mecha_parts/chassis/durand
	name = "Durand Chassis"
	construction_cost = list("metal"=25000)

	New()
		..()
		construct = new /datum/construction/mecha/durand_chassis(src)
