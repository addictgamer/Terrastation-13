
/obj/decal/cleanable/poop/splatter
	icon_state = "splatter1"
	//random_icon_states = list("floor1", "floor22", "floor3", "floor4", "floor5", "floor6", "floor7")
	random_icon_states = list("floor1")

	proc
		streak(var/list/directions)
			spawn (0)
				var/direction = pick(directions)
				for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
					sleep(3)
					if(i > 0)
						var/obj/decal/cleanable/poop/splatter/b = new /obj/decal/cleanable/poop/splatter(src.loc)
					if(step_to(src, get_step(src, direction), 0))
						break
