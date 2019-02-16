/obj/machinery/disposal/small
	name = "wallmounted disposal unit"
	icon = 'icons/obj/pipes/disposal_small.dmi'
	density = 0

	north
		dir = NORTH
		pixel_y = 32
	east
		dir = EAST
	south
		dir = SOUTH
	west
		dir = WEST

	MouseDrop_T(mob/target, mob/user)
		if(target == user)
			to_chat(user, "You won't fit in the [src].")
		else
			to_chat(user, "[target.name] won't fit in the [src].")
		return