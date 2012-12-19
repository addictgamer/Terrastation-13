
//Decal

/obj/decal/cleanable/poop //Do not spawn this, spawn poop/splatter
	name = "Poop"
	desc = "It's brown. It's sloshy. It smells bad. Somebody must have taken a dump here."
	density = 0
	anchored = 1
	layer = 2
	icon = 'poop.dmi'

/obj/decal/cleanable/poop/HasEntered(AM as mob|obj)
	..()

	if (istype(AM, /mob/living/carbon))
		var/mob/M =	AM
		if ((istype(M, /mob/living/carbon/human) && (istype(M:shoes, /obj/item/clothing/shoes) && M:shoes.flags&NOSLIP)) || M.m_intent == "walk")
			return

		M.pulling = null
		M << "\blue You slipped on the poop!"
		playsound(src.loc, 'slip.ogg', 50, 1, -3)
		M.stunned = 8
		M.weakened = 5

/obj/decal/cleanable/poop/splatter
	icon_state = "splatter1"
	//random_icon_states = list("floor1", "floor22", "floor3", "floor4", "floor5", "floor6", "floor7")
	random_icon_states = list("floor1")

/obj/decal/cleanable/poop/splatter/proc/streak(var/list/directions)
	spawn (0)
		var/direction = pick(directions)
		for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
			sleep(3)
			if(i > 0)
				var/obj/decal/cleanable/poop/splatter/b = new /obj/decal/cleanable/poop/splatter(src.loc)
			if(step_to(src, get_step(src, direction), 0))
				break

/obj/decal/cleanable/poop/tracks
	icon_state = "tracks"
	random_icon_states = null
