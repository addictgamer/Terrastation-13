
/obj/decal/cleanable
	density = 0
	var
		list/random_icon_states = list()

	New()
		if (random_icon_states && length(src.random_icon_states) > 0)
			src.icon_state = pick(src.random_icon_states)
		..()
