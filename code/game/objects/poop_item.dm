
//Item

/obj/item/weapon/poop
	name = "poop"
	desc = "It's brown, squishy, and reeks. You feel the urge to throw it at people."
	icon = 'poop.dmi'
	icon_state = "poop"
	w_class = 1.0
	throwforce = 1
	throw_speed = 4
	throw_range = 20
	var/material_ammount = 0 //The ammount of material it's made up of.

	proc
		place_in_world(var/turf/location)
		splatter_ground(var/ammount_lost = 1, var/turf/location = src.loc)

/obj/item/weapon/poop/place_in_world(var/turf/location)
	//world << "poop/place_in_world()"
	src.loc = location
	//TODO: If standing on toilet, no poop.
	if(/obj/machinery/disposal/toilet in loc.contents)
		var/found = 1
	else
		src.splatter_ground(0, src.loc)

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
/obj/item/weapon/poop/splatter_ground(var/ammount_lost, var/turf/location)
	//world << "Making poop splatter."
	src.material_ammount -= ammount_lost
	var/obj/decal/cleanable/poop/splatter/b = new /obj/decal/cleanable/poop/splatter(location)

	if(material_ammount < 1)
		del(src)
