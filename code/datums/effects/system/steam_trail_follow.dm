
/datum/effects/system/steam_trail_follow
	var
		atom/holder
		turf/oldposition
		processing = 1
		on = 1
		number

	proc
		set_up(atom/atom)
			holder = atom
			oldposition = get_turf(atom)

		start()
			if(!src.on)
				src.on = 1
				src.processing = 1
			if(src.processing)
				src.processing = 0
				spawn(0)
					if(src.number < 3)
						var/obj/effects/steam/I = new /obj/effects/steam(src.oldposition)
						src.number++
						src.oldposition = get_turf(holder)
						I.dir = src.holder.dir
						spawn(10)
							del(I)
							src.number--
						spawn(2)
							if(src.on)
								src.processing = 1
								src.start()
					else
						spawn(2)
							if(src.on)
								src.processing = 1
								src.start()

		stop()
			src.processing = 0
			src.on = 0
