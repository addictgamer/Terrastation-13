
/obj/item/mecha_parts/chassis/gygax
	name = "Gygax Chassis"
	construction_cost = list("metal"=25000)

	New()
		..()
		construct = new /datum/construction/mecha/gygax_chassis(src)
