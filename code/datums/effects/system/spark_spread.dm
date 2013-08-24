
/datum/effects/system/spark_spread
	var
		number = 3
		cardinals = 0
		turf/location
		atom/holder
		total_sparks = 0 // To stop it being spammed and lagging!

	proc
		set_up(n = 3, c = 0, loca)
			if (n > 10)
				n = 10
			number = n
			cardinals = c
			if (istype(loca, /turf/))
				location = loca
			else
				location = get_turf(loca)

		attach(atom/atom)
			holder = atom

		start()
			var/i = 0
			for(i=0, i<src.number, i++)
				if (src.total_sparks > 20)
					return
				spawn(0)
					if (holder)
						src.location = get_turf(holder)
					var/obj/effects/sparks/sparks = new /obj/effects/sparks(src.location)
					src.total_sparks++
					var/direction
					if (src.cardinals)
						direction = pick(cardinal)
					else
						direction = pick(alldirs)
					for(i=0, i<pick(1,2,3), i++)
						sleep(5)
						step(sparks,direction)
					spawn(20)
						del(sparks)
						src.total_sparks--
