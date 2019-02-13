//This is no doubt monstrously illegible, and I apologize in advance to those foolhardy enough to plumb its depths.
/proc/atmos_init()
	var/ambient_z = TRUE

	for(var/turf/T in world)
		if(!ambient_z && !T.zone && !T.is_airtight())
			T.make_zone()
		if(ambient_z && T.zone != "ambient")
			if(T.is_airtight())
				ambient_z = FALSE
			else if(T.zone)
				for(var/turf/T2 in T.zone.turf)
					T2.zone = "ambient"
			else.
				T.zone = "ambient"
/turf/proc/make_zone()
	var/datum/zone/Z = datum/zone.New()
	var/dir = 4
	var/list/current_branch = list()
	var/branch_count = 0
	Z.first_turf = src
	var/list/init_dims = newlist(find_width(1),find_width(2),find_length(1),find_length(2),find_height(1),find_height(2))
/turf/proc/get_dimensions()
	var/


/*
/turf/proc/zone_init()
	var/turf/T = src.find_edge(FALSE, FALSE, FALSE, 1, 2, 3)
	var/turf/T2 = T
	var/dim = 0
	var/go = TRUE
	while(go)
		if(T2.find_width() == T2.find_width_on_axis(1))
			dim = T2.find_dimensions()
		if(l2 > 1)
			l2 = 0
			go = TRUE
*/
/turf/proc/find_edge(a, b, c, order1, order2, order3)
	var/turf/edge = src
	var/d
	for(d = 3, d > 0, d--)
		if(order1 == 1 && d == 3 || order2 == 1 && d == 2 || order3 == 1 and d == 1)
			if(!a)
				edge = locate((edge.x - (edge.find_width(1) - 1)), edge.y, edge.z)
			else
				edge = locate((edge.x + (edge.find_width(2) - 1)), edge.y, edge.z)
		if(order1 == 2 && d == 3 || order2 == 2 && d == 2 || order3 == 2 and d == 1)
			if(!b)
				edge = locate(edge.x, (edge.y - (edge.find_length(1) - 1)), edge.z)
			else
				edge = locate(edge.x, (edge.y + (edge.find_length(2) - 1)), edge.z)

		if(order1 == 3 && d == 3 || order2 == 3 && d == 2 || order3 == 3 and d == 1)
			if(!c)
				edge = locate(edge.x, edge.y, (edge.z - (edge.find_height(1) - 1)))
			else
				edge = locate(edge.x, edge.y, (edge.z + (edge.find_height(2) - 1)))
	return edge


/turf/proc/is_airtight(direction = 0)
	var/is_airtight = FALSE
	var/is_ladder = FALSE
	if(direction > 8 && !src.open)
		for(var/obj/structure/L in src)
			if(!L.climb == direction || !L.climb == 8)
				is_ladder = TRUE
				break
		if(!is_ladder)
			is_airtight = TRUE

	else if(src.density)
		is_airtight = TRUE
	else
		for(var/obj/structure/O in src)
			if(O.airtight == 1 || O.airtight == 2 && O.dir == direction)
				is_airtight = TRUE
				break
		if(!is_airtight)
			for(var/obj/machine/M in src)
				if(M.airtight == 1 || M.airtight == 2 && M.dir == direction)
					is_airtight = TRUE
					break


	return is_airtight

proc/find_direction(turf/T)


turf/proc/find_width(side = 0)
	var/w1
	var/w2
	var/w3
	var/turf/T
	if(!side || side == 2)
		for(w1 = 0, w1 <= (world.maxx - src.x), w1++)
			T = locate(src.x + w1,src.y,src.z).
			if(T.is_airtight(8))
				break
			else if(T.is_airtight(4))
				w1++
				break
	if(!side || side == 1)
		for(w2 = 0, w2 >= 1, w2--)
			T = locate(src.x + w2,src.y,src.z)
			if(T.is_airtight(4))
				break
			else if(T.is_airtight(8))
				w2--
				break
	if(!side)
		w3 = w1 - 1 + w2 * -1
	else if(side == 1)
		w3 = w2 * -1
	else if(side == 2)
		w3 = w1
	return w3

turf/proc/find_length(side = 0)
	var/l1
	var/l2
	var/l3
	var/turf/T
	if(!side || side == 2)
		for(l1 = 0, l1 <= (world.maxy - src.y), l1++)
			T = locate(src.x,src.y + l1,src.z)
			if(T.is_airtight(2))
				break
			else if(T.is_airtight(1))
				l1++
				break
	if(!side || side == 1)
		for(l2 = 0, l2 >= 1, l2--)
			T = locate(src.x,src.y + l2,src.z)
			if(T.is_airtight(1))
				break
			else if(T.is_airtight(2))
				l2--
				break
	if(!side)
		l3 = l1 - 1 + l2 * -1
	else if(side == 1)
		l3 = l2 * -1
	else if(side == 2)
		l3 = l1
	return l3

turf/proc/find_height(side = 0)
	var/h1
	var/h2
	var/h3
	var/turf/T
	if(!side || side == 2)
		for(h1 = -1, h1 <= (world.maxz - src.z), h1++)
			T = locate(src.x,src.y,src.z + h1)
			if(T.is_airtight())
				break
	if(!side || side == 1)
		for(h2 = 0, h2 >= 1, h2--)
			T = locate(src.x,src.y,src.z + h2)
			if(T.is_airtight())
				break
	if(!side)
		h3 = h1 -1 + h2 * -1
	else if(side == 1)
		h3 = h2 * -1
	else if(side == 2)
		h3 = h1
	return h3



/turf/proc/find_width_on_axis(dimension, side1 = 0, side2 = 0)
	var/width = 0
	var/w1 = 0
	var/w2 = 0
	var/w3 = 0
	var/meh = 0
	var/turf/T
	if(!side1 || side1 == 1)
		width = src.find_width(1)
		if(dimension == 1)
			meh = src.find_length(side2)

		if(dimension == 2)
			meh = src.find_height(side2)

		for(w1 = 0, w1 < width, w1++)
			T = locate((src.x - w1), src.y, src.z)
			if(dimension == 1)
				if(meh != T.find_length(side2))
					break
			if(dimension == 2)
				if(meh != T.find_height(side2))
					break

	if(!side1 || side1 == 2)
		width = src.find_width(2)
		if(dimension == 1)
			meh = src.find_length(side2)

		if(dimension == 2)
			meh = src.find_height(side2)

		for(w2 = 0, w2 < width, w2++)
			T = locate((src.x + w2), src.y, src.z)
			if(dimension == 1)
				if(meh != T.find_length(side2))
					break
			if(dimension == 2)
				if(meh != T.find_height(side2))
					break

	if(!side1)
		w3 = w1 + w2 - 1
	else if(side1 == 1)
		w3 = w1
	else if(side1 == 2)
		w3 = w2
	return w3

/turf/proc/find_length_on_axis(dimension, side1 = 0, side2 = 0)
	var/length = 0
	var/l1 = 0
	var/l2 = 0
	var/l3 = 0
	var/meh = 0
	var/turf/T
	if(!side1 || side1 == 1)
		length = src.find_length(1)
		if(dimension == 1)
			meh = src.find_width(side2)

		if(dimension == 2)
			meh = src.find_height(side2)

		for(l1 = 0, l1 < width, l1++)
			T = locate(src.x, (src.y - l1), src.z)
			if(dimension == 1)
				if(meh != T.find_width(side2))
					break
			if(dimension == 2)
				if(meh != T.find_height(side2))
					break

	if(!side1 || side1 == 2)
		length = src.find_length(2)
		if(dimension == 1)
			meh = src.find_width(side2)

		if(dimension == 2)
			meh = src.find_height(side2)

		for(l2 = 0, l2 < length, l2++)
			T = locate(src.x, (src.y + l1), src.z)
			if(dimension == 1)
				if(meh != T.find_width(side2))
					break
			if(dimension == 2)
				if(meh != T.find_height(side2))
					break

	if(!side1)
		l3 = l1 + l2 - 1
	else if(side1 == 1)
		l3 = l1
	else if(side1 == 2)
		l3 = l2
	return l3

/turf/proc/find_height_on_axis(dimension, side1 = 0, side2 = 0)
	var/height = 0
	var/h1 = 0
	var/h2 = 0
	var/h3 = 0
	var/meh = 0
	var/turf/T
	if(!side1 || side1 == 1)
		height = src.find_height(1)
		if(dimension == 1)
			meh = src.find_width(side2)

		if(dimension == 2)
			meh = src.find_length(side2)

		for(h1 = 0, h1 < height, h1++)
			T = locate(src.x, src.y, (src.z - h1))
			if(dimension == 1)
				if(meh != T.find_width(side2))
					break
			if(dimension == 2)
				if(meh != T.find_length(side2))
					break

	if(!side1 || side1 == 2)
		height = src.find_height(2)
		if(dimension == 1)
			meh = src.find_width(side2)

		if(dimension == 2)
			meh = src.find_length(side2)

		for(h2 = 0, h2 < height, h2++)
			T = locate(src.x, src.y, (src.z + h2))
			if(dimension == 1)
				if(meh != T.find_width(side2))
					break
			if(dimension == 2)
				if(meh != T.find_length(side2))
					break

	if(!side1)
		h3 = h1 + h2 - 1
	else if(side1 == 1)
		h3 = h1
	else if(side1 == 2)
		h3 = h2
	return h3



/turf/proc/find_dimensions(a, b, c, order1, order2, order3)
	var/width = src.find_width_on_axis(1)
	var/length = src.find_length()
	var/height = src.find_height()
	var/turf/T = src.find_edge(a, b, c, order1, order2, order3)
	var/turf/T2
	for(var/w = 0, w < width, w++)
		for(var/l = 0, l < length, l++)
			T2 = locate((T.x + w), (T.y + l), T.z)
			if(T2.find_height() != height)
				break
