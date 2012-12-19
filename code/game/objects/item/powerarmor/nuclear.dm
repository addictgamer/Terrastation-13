
/obj/item/powerarmor/power/nuclear
	name = "Miniaturized nuclear generator"
	desc = "For all your radioactive needs."
	slowdown = 1.5

/obj/item/powerarmor/power/nuclear/process()
	if(!crit_fail)
		if (prob(src.reliability)) return 1 //No failure
		if (prob(src.reliability))
			for (var/mob/M in range(0,src.parent)) //Only a minor failure, enjoy your radiation.
				if (src.parent in M.contents)
					M << "\red Your armor feels pleasantly warm for a moment."
				else
					M << "\red You feel a warm sensation."
				M.radiation += rand(1,40)
		else
			for (var/mob/M in range(rand(1,4),src.parent)) //Big failure, TIME FOR RADIATION BITCHES
				if (src.parent in M.contents)
					M << "\red Your armor's reactor overloads!"
				M << "\red You feel a wave of heat wash over you."
				M.radiation += 100
			crit_fail = 1 //broken~
			parent.powerdown(1)
		spawn(50)
			process()

/obj/item/powerarmor/power/nuclear/checkpower()
	return !crit_fail
