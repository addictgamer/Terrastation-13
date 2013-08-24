
/obj/multiz/ladder
	icon_state = "ladderdown"
	name = "ladder"
	desc = "A Ladder.  You climb up and down it."

	New()
		..()
		if (!istop)
			icon_state = "ladderup"
		else
			icon_state = "ladderdown"

	attack_paw(var/mob/M)
		return attack_hand(M)

	attackby(var/W, var/mob/M)
		return attack_hand(M)

	attack_hand(var/mob/M)
		M.Move(locate(src.x, src.y, targetZ()))

	blob_act()
		var/newblob = 1
		for(var/obj/blob in locate(src.x, src.y, targetZ()))
			newblob = 0
		if (newblob)
			new /obj/blob(locate(src.x, src.y, targetZ()))

	MouseDrop_T(var/atom/movable/C, mob/user) //When the user drags an item onto it...
		if (user.stat)
			return
		if (!istype(C)|| C.anchored || get_dist(user, src) > 1 || get_dist(src,C) > 1 )
			return
		load(C)


// called to move the item up the ladder.
	proc
		load(var/atom/movable/C)
			if (get_dist(C, src) > 1)
				return
			// if a create, close before loading
			var/obj/crate/crate = C
			if (istype(crate))
				crate.close()
			C.Move(locate(src.x, src.y, targetZ()))
			//C.loc = src.loc
