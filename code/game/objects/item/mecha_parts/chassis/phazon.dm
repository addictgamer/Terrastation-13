
/obj/item/mecha_parts/chassis/phazon
	name = "Phazon Chassis"
	origin_tech = "materials=7"

	New()
		..()
		construct = new /datum/construction/mecha/phazon_chassis(src)
