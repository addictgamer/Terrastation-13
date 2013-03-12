
/////////////////////////////////////////////
//SPARK SYSTEM (like steam system)
// The attach(atom/atom) proc is optional, and can be called to attach the effect
// to something, like the RCD, so then you can just call start() and the sparks
// will always spawn at the items location.
/////////////////////////////////////////////

/obj/effects/sparks
	name = "sparks"
	icon_state = "sparks"
	anchored = 1.0
	mouse_opacity = 0
	var
		amount = 6.0

	New()
		..()
		playsound(src.loc, "sparks", 100, 1)
		var/turf/T = src.loc
		if (istype(T, /turf))
			T.hotspot_expose(1000,100)
		spawn (100)
			del(src)
		return

	Del()
		var/turf/T = src.loc
		if (istype(T, /turf))
			T.hotspot_expose(1000,100)
		..()
		return

	Move()
		..()
		var/turf/T = src.loc
		if (istype(T, /turf))
			T.hotspot_expose(1000,100)
		return
