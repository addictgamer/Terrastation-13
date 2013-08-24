
/obj/decal/cleanable/blood
	name = "Blood"
	desc = "It's red. Its Gooye. It is the chefs cooking perhaps."
	density = 0
	anchored = 1
	layer = 2
	icon = 'blood.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	var/list/viruses = list()
	blood_DNA = null
	blood_type = null
	var/datum/disease2/disease/virus2 = null

	Del()
		for(var/datum/disease/D in viruses)
			D.cure(0)
		..()

/*
/obj/decal/cleanable/blood/burn(fi_amount)
	if (fi_amount > 900000.0)
		src.virus = null
	sleep(11)
	del(src)
	return
*/
