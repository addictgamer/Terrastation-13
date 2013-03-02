
/obj/decal/cleanable/xenoblood
	name = "xeno blood"
	desc = "It's green. Must be more of the chefs cooking."
	density = 0
	anchored = 1
	layer = 2
	icon = 'blood.dmi'
	icon_state = "xfloor1"
	random_icon_states = list("xfloor1", "xfloor2", "xfloor3", "xfloor4", "xfloor5", "xfloor6", "xfloor7")
	var/list/viruses = list()

	Del()
		for(var/datum/disease/D in viruses)
			D.cure(0)
		..()
