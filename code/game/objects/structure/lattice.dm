
/obj/lattice
	desc = "A lightweight support lattice."
	name = "lattice"
	icon = 'structures.dmi'
	icon_state = "latticefull"
	density = 0
	anchored = 1.0
	layer = 2.3 //under pipes
	//flags = 64.0

	New()
		..()
		if(!(istype(src.loc, /turf/space)))
			del(src)
		for(var/obj/lattice/LAT in src.loc)
			if(LAT != src)
				del(LAT)
		icon = 'smoothlattice.dmi'
		icon_state = "latticeblank"
		updateOverlays()
		for (var/dir in cardinal)
			var/obj/lattice/L
			if(locate(/obj/lattice, get_step(src, dir)))
				L = locate(/obj/lattice, get_step(src, dir))
				L.updateOverlays()

	Del()
		for (var/dir in cardinal)
			var/obj/lattice/L
			if(locate(/obj/lattice, get_step(src, dir)))
				L = locate(/obj/lattice, get_step(src, dir))
				L.updateOverlays(src.loc)
		..()

	blob_act()
		del(src)
		return

	ex_act(severity)
		switch(severity)
			if(1.0)
				del(src)
				return
			if(2.0)
				del(src)
				return
			if(3.0)
				return
			else
		return

	attackby(obj/item/C as obj, mob/user as mob)
		if (istype(C, /obj/item/stack/tile))
			C:build(get_turf(src))
			C:use(1)
			playsound(src.loc, 'Genhit.ogg', 50, 1)
			if (C)
				C.add_fingerprint(user)
			del(src)
			return
		if (istype(C, /obj/item/weapon/weldingtool) && C:welding)
			user << "\blue Slicing lattice joints ..."
			C:eyecheck(user)
			new /obj/item/stack/rods(src.loc)
			del(src)
		return

	proc
		updateOverlays()
			//if(!(istype(src.loc, /turf/space)))
			//	del(src)
			spawn(1)
				overlays = list()
				var/dir_sum = 0
				for (var/direction in cardinal)
					if(locate(/obj/lattice, get_step(src, direction)))
						dir_sum += direction
					else
						if(!(istype(get_step(src, direction), /turf/space)))
							dir_sum += direction
				icon_state = "lattice[dir_sum]"
				return
/*
				overlays += icon(icon,"lattice-middlebar") //the nw-se bar in the cneter
				for (var/dir in cardinal)
					if(locate(/obj/lattice, get_step(src, dir)))
						src.overlays += icon(icon,"lattice-[dir2text(dir)]")
					else
						src.overlays += icon(icon,"lattice-nc-[dir2text(dir)]") //t for turf
						if(!(istype(get_step(src, dir), /turf/space)))
							src.overlays += icon(icon,"lattice-t-[dir2text(dir)]") //t for turf
				//if ( !( (locate(/obj/lattice, get_step(src, SOUTH))) || (locate(/obj/lattice, get_step(src, EAST))) ))
				//	src.overlays += icon(icon,"lattice-c-se")
				if ( !( (locate(/obj/lattice, get_step(src, NORTH))) || (locate(/obj/lattice, get_step(src, WEST))) ))
					src.overlays += icon(icon,"lattice-c-nw")
				if ( !( (locate(/obj/lattice, get_step(src, NORTH))) || (locate(/obj/lattice, get_step(src, EAST))) ))
					src.overlays += icon(icon,"lattice-c-ne")
				if ( !( (locate(/obj/lattice, get_step(src, SOUTH))) || (locate(/obj/lattice, get_step(src, WEST))) ))
					src.overlays += icon(icon,"lattice-c-sw")
				if(!(overlays))
					icon_state = "latticefull"
*/
