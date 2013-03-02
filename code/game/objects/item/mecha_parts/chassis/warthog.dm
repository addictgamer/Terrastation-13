
/obj/item/mecha_parts/chassis/warthog
	name = "Warthog Chassis"
	origin_tech = "materials=7"

	New()
		..()
		construct = new /datum/construction/mecha/warthog_chassis(src)
