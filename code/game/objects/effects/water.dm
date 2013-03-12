
/obj/effects/water
	name = "water"
	icon = 'effects.dmi'
	icon_state = "extinguish"
	flags = 2.0
	mouse_opacity = 0
	var
		life = 15.0

	New()
		..()
		//var/turf/T = src.loc
		//if (istype(T, /turf))
		//	T.firelevel = 0 //TODO: FIX
		spawn( 70 )
			del(src)
			return
		return

	Del()
		//var/turf/T = src.loc
		//if (istype(T, /turf))
		//	T.firelevel = 0 //TODO: FIX
		..()
		return

	Move(turf/newloc)
		//var/turf/T = src.loc
		//if (istype(T, /turf))
		//	T.firelevel = 0 //TODO: FIX
		if (--src.life < 1)
			//SN src = null
			del(src)
		if(newloc.density)
			return 0
		.=..()
