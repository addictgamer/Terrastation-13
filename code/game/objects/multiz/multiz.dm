
/obj/multiz
	icon = 'multiz.dmi'
	density = 0
	opacity = 0
	anchored = 1
	var
		istop = 1

	CanPass(obj/mover, turf/source, height, airflow)
		return airflow || !density

	proc
		targetZ()
			return src.z + (istop ? -1 : 1)
