
/obj/decal/cleanable/robot_debris
	name = "robot debris"
	desc = "Useless heap of junk...or is it..."
	density = 0
	anchored = 0
	layer = 2
	icon = 'robots.dmi'
	icon_state = "gib1"
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6", "gib7")

	proc
		streak(var/list/directions)
			spawn (0)
				var/direction = pick(directions)
				for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
					sleep(3)
					if (i > 0)
						if (prob(40))
							/*var/obj/decal/cleanable/oil/o =*/
							new /obj/decal/cleanable/oil/streak(src.loc)
						else if (prob(10))
							var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
							s.set_up(3, 1, src)
							s.start()
					if (step_to(src, get_step(src, direction), 0))
						break
