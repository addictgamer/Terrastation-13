
/datum/effects/system/mustard_gas_spread
	var
		number = 3
		cardinals = 0
		turf/location
		atom/holder
		total_smoke = 0 // To stop it being spammed and lagging!
		direction

	proc
		set_up(n = 5, c = 0, loca, direct)
			if (n > 20)
				n = 20
			number = n
			cardinals = c
			if (istype(loca, /turf/))
				location = loca
			else
				location = get_turf(loca)
			if (direct)
				direction = direct

		attach(atom/atom)
			holder = atom

		start()
			var/i = 0
			for(i=0, i<src.number, i++)
				if (src.total_smoke > 20)
					return
				spawn(0)
					if (holder)
						src.location = get_turf(holder)
					var/obj/effects/mustard_gas/smoke = new /obj/effects/mustard_gas(src.location)
					src.total_smoke++
					var/direction = src.direction
					if (!direction)
						if (src.cardinals)
							direction = pick(cardinal)
						else
							direction = pick(alldirs)
					for(i=0, i<pick(0,1,1,1,2,2,2,3), i++)
						sleep(10)
						step(smoke,direction)
					spawn(100)
						del(smoke)
						src.total_smoke--
