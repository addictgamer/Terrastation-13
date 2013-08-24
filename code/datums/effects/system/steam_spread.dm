
/datum/effects/system/steam_spread
	var
		number = 3
		cardinals = 0
		turf/location
		atom/holder

	proc
		set_up(n = 3, c = 0, turf/loc)
			if (n > 10)
				n = 10
			number = n
			cardinals = c
			location = loc

		attach(atom/atom)
			holder = atom

		start()
			var/i = 0
			for(i=0, i<src.number, i++)
				spawn(0)
					if (holder)
						src.location = get_turf(holder)
					var/obj/effects/steam/steam = new /obj/effects/steam(src.location)
					var/direction
					if (src.cardinals)
						direction = pick(cardinal)
					else
						direction = pick(alldirs)
					for(i=0, i<pick(1,2,3), i++)
						sleep(5)
						step(steam,direction)
					spawn(20)
						del(steam)
