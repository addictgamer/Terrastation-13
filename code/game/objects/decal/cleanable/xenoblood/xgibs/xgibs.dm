
/obj/decal/cleanable/xenoblood/xgibs
	name = "xeno gibs"
	desc = "Gnarly..."
	icon = 'blood.dmi'
	icon_state = "xgib1"
	random_icon_states = list("xgib1", "xgib2", "xgib3", "xgib4", "xgib5", "xgib6")

	proc
		streak(var/list/directions)
			spawn (0)
				var/direction = pick(directions)
				for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
					sleep(3)
					if (i > 0)
						var/obj/decal/cleanable/xenoblood/b = new /obj/decal/cleanable/xenoblood/xsplatter(src.loc)
						for(var/datum/disease/D in src.viruses)
							b.viruses += D
					if (step_to(src, get_step(src, direction), 0))
						break
