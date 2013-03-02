
/obj/decal/cleanable/vomit
	name = "Vomit"
	desc = "Gosh, how unpleasant."
	layer = 2
	icon = 'blood.dmi'
	icon_state = "vomit_1"
	random_icon_states = list("vomit_1", "vomit_2", "vomit_3", "vomit_4")
	var/list/viruses = list()

	Del()
		for(var/datum/disease/D in viruses)
			D.cure(0)
		..()
