
// Foam
// Similar to smoke, but spreads out more
// metal foams leave behind a foamed metal wall

/obj/effects/foam
	name = "foam"
	icon_state = "foam"
	opacity = 0
	anchored = 1
	density = 0
	layer = OBJ_LAYER + 0.9
	mouse_opacity = 0
	animate_movement = 0
	var
		metal = 0
		amount = 3
		expand = 1


	New(loc, var/ismetal=0)
		..(loc)
		icon_state = "[ismetal ? "m":""]foam"
		metal = ismetal
		playsound(src, 'bubbles2.ogg', 80, 1, -3)
		spawn(3 + metal*3)
			process()
		spawn(120)
			expand = 0 // stop expanding
			sleep(30)
			if(metal)
				var/obj/foamedmetal/M = new(src.loc)
				M.metal = metal
				M.updateicon()
			flick("[icon_state]-disolve", src)
			sleep(5)
			del(src)
		return

// on delete, transfer any reagents to the floor
	Del()
		if(!metal && reagents)
			for(var/atom/A in oview(0,src))
				if(A == src)
					continue
				reagents.reaction(A, 1, 1)
		..()

	process()
		if(--amount < 0)
			return
		while(expand)	// keep trying to expand while true
			for(var/direction in cardinal)
				var/turf/T = get_step(src,direction)
				if(!T)
					continue
				if(!T.Enter(src))
					continue
				var/obj/effects/foam/F = locate() in T
				if(F)
					continue
				F = new(T, metal)
				F.amount = amount
				if(!metal)
					F.create_reagents(10)
					if (reagents)
						for(var/datum/reagent/R in reagents.reagent_list)
							F.reagents.add_reagent(R.id,1)
			sleep(15)

// foam disolves when heated
// except metal foams
	temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
		if(!metal && prob(max(0, exposed_temperature - 475)))
			flick("[icon_state]-disolve", src)
			spawn(5)
				del(src)


	HasEntered(var/atom/movable/AM)
		if(metal)
			return
		if (istype(AM, /mob/living/carbon))
			var/mob/M =	AM
			if (istype(M, /mob/living/carbon/human) && (istype(M:shoes, /obj/item/clothing/shoes) && M:shoes.flags&NOSLIP))
				return
			M.pulling = null
			M << "\blue You slipped on the foam!"
			playsound(src.loc, 'slip.ogg', 50, 1, -3)
			M.stunned = 5
			M.weakened = 2
