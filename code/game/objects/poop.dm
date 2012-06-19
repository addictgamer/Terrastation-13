/obj/decal/cleanable/poop/splatter/proc/streak(var/list/directions)
	spawn (0)
		var/direction = pick(directions)
		for (var/i = 0, i < pick(1, 200; 2, 150; 3, 50; 4), i++)
			sleep(3)
			if(i > 0)
				var/obj/decal/cleanable/poop/splatter/b = new /obj/decal/cleanable/poop/splatter(src.loc)
			if(step_to(src, get_step(src, direction), 0))
				break


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

/obj/item/weapon/poop/place_in_world(var/turf/location)
	//world << "poop/place_in_world()"
	src.loc = location
	//TODO: If standing on toilet, no poop.
	if(/obj/machinery/disposal/toilet in loc.contents)
		var/found = 1
	else
		src.splatter_ground(0, src.loc)

/obj/item/weapon/poop/splatter_ground(var/ammount_lost, var/turf/location)
	//world << "Making poop splatter."
	src.material_ammount -= ammount_lost
	var/obj/decal/cleanable/poop/splatter/b = new /obj/decal/cleanable/poop/splatter(location)

	if(material_ammount < 1)
		del(src)
///obj/item/weapon/poop/proc/throw()
//

/obj/item/weapon/poop/throw_impact(atom/hit_atom)
	if(istype(hit_atom,/mob/living))
		var/mob/living/M = hit_atom
		M.visible_message("\red [hit_atom] has been hit by [src].")
		if(src.vars.Find("throwforce"))
			M.take_organ_damage(src:throwforce)

	else if(isobj(hit_atom))
		var/obj/O = hit_atom
		if(!O.anchored)
			step(O, src.dir)
		O.hitby(src)

	else if(isturf(hit_atom))
		var/turf/T = hit_atom
		if(T.density)
			spawn(2)
				step(src, turn(src.dir, 180))
			if(istype(src,/mob/living))
				var/mob/living/M = src
				M.take_organ_damage(20)

	splatter_ground(1, src.loc)

/obj/item/weapon/poop/dropped(mob/user)
	..()

	splatter_ground(0, src.loc)