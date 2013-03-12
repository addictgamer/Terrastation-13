
/datum/effects/system/ion_trail_follow
	var
		atom/holder
		turf/oldposition
		processing = 1
		on = 1

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
					var/turf/T = get_turf(src.holder)
					if(T != src.oldposition)
						if(istype(T, /turf/space))
							var/obj/effects/ion_trails/I = new /obj/effects/ion_trails(src.oldposition)
							src.oldposition = T
							I.dir = src.holder.dir
							flick("ion_fade", I)
							I.icon_state = "blank"
							spawn( 20 )
								del(I)
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
