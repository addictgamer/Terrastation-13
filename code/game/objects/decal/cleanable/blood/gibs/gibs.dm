
/obj/decal/cleanable/blood/gibs
	name = "gibs"
	desc = "Grisly...and not the good kind neither."
	density = 0
	anchored = 0
	layer = 2
	icon = 'blood.dmi'
	icon_state = "gibbl5"
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6")

//Gibs.spread proc in gibs.dm
	proc
		streak(var/list/directions)
			spawn (0)
				var/direction = pick(directions)
				for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
					sleep(3)
					if (i > 0)
						var/obj/decal/cleanable/blood/b = new /obj/decal/cleanable/blood/splatter(src.loc)
						for(var/datum/disease/D in src.viruses)
							b.viruses += D
					if (step_to(src, get_step(src, direction), 0))
						break
