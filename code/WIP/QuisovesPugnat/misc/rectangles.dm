/datum/rectangle
	var/x
	var/y
	var/offx
	var/offy
	var/extremity_x
	var/extremity_y
	var/area
/datum/rectangle/New(r_x, r_y, r_offx, r_offy)
	x = r_x
	y = r_y
	offx = r_offx
	offy = r_offy
	extremity_x = (offx + x - 1)
	extremity_y = (offy + y - 1)
	area = x * y
/datum/rectangle/proc/adjust()
	extremity_x = (offx + x - 1)
	extremity_y = (offy + y - 1)
	area = x * y
/datum/rectangle/proc/isequal(var/datum/rectangle/R)
	if(R.x == src.x && R.y == src.y && R.offx == src.offx && R.offy == src.offy)
		return 1
	else
		return 0
/datum/rectangle/proc/overlaps_with(var/datum/rectangle/R)
	var/n_x
	var/n_y
	var/n_offx
	var/n_offy
	if(offx >= R.offx && offx <= R.extremity_x)
		n_offx = offx
		if(extremity_x <= R.extremity_x)
			n_x = x
		else
			n_x = (R.extremity_x - offx + 1)
	else if(extremity_x >= R.offx && extremity_x <= R.extremity_x)
		n_x = (extremity_x - R.offx + 1)
		n_offx = R.offx
	else
		return null

	if(offy >= R.offy && offy <= R.extremity_y)
		n_offy = offy
		if(extremity_y <= R.extremity_y)
			n_y = y
		else
			n_y = (R.extremity_y - offy + 1)
	else if(extremity_y >= R.offy && extremity_y <= R.extremity_y)
		n_y = (extremity_y - R.offy + 1)
		n_offy = R.offy
	else
		return null
	return new /datum/rectangle(n_x, n_y, n_offx, n_offy)

/datum/rectangle/proc/is_in_rectangle(r_x, r_y)
	if(r_x >= offx && r_x <= extremity_x && r_y >= offy && r_y <= extremity_y)
		return 1
	return 0

/datum/rectangle/proc/get_rectangle_remainders(var/datum/rectangle/R)
	if(R.area >= src.area || R.offx < offx || R.offy < offy || src.isequal(R)) //The second rectangle must be the smaller of the two, and bounded by the first.
		return
	var/list/remainders = list()
	if(R.offx > offx)
		remainders += new /datum/rectangle((R.offx - offx), y, offx, offy)
	if(R.offy > offy)
		remainders += new /datum/rectangle(x, (R.offy - offy), offx, offy)
	if(R.x < x)
		remainders += new /datum/rectangle((extremity_x - R.extremity_x), y, (R.extremity_x + 1), offy)
	if(R.y < y)
		remainders += new /datum/rectangle(x, (extremity_y - R.extremity_y), offx, (R.extremity_y + 1))

	return remainders

/proc/GetAreaTurfsInOrder(var/area/A, zlevel = 1)
	var/list/turfs = list()

	for(var/i = 1; i <= world.maxy; i++)
		for(var/i2 = 1; i2 <= world.maxx; i2++)
			var/turf/T = locate(i2, i, zlevel)
			if(istype(get_area(T), A))
				turfs += T
	return turfs
/proc/GetRectangles(var/area/A, zlevel = 1)
	var/list/turfs = GetAreaTurfsInOrder(A, zlevel)
	if(!turfs.len)
		return
	var/list/rectangles = list()
	var/turf/offset = turfs[1]
	var/turf/LastTurf = turfs[1]
	var/turf/T
	var/list/length = list()
	var/list/points = list()
	var/list/overlaps = list()
	var/skip = 0
	var/ln = 0
	var/turf/oldendpoint
	var/turf/oldoffset
	for(var/i = 2; i <= turfs.len; i++)
		T = turfs[i]
		if(T.y != LastTurf.y || T.x != (LastTurf.x + 1) || i == turfs.len)
			ln = 1
			skip = 0
			for(var/i2 = points.len; i2 > 0; i2 -= 2)
				oldoffset = points[i2 - 1]
				oldendpoint = points[i2]
				if((LastTurf.y - oldendpoint.y) == length[i2/2])
					if(oldoffset.x == offset.x && oldendpoint.x == LastTurf.x)
						length[i2/2]++
						skip = 1
					else if(offset.x <= oldoffset.x && LastTurf.x >= oldendpoint.x)
						length[i2/2]++
					else if(offset.x >= oldoffset.x && LastTurf.x <= oldendpoint.x)
						ln = length[i2/2] + 1
					else if(offset.x > oldoffset.x && offset.x <= oldendpoint.x && LastTurf.x > oldendpoint.x)
						overlaps += locate(offset.x, offset.y, zlevel)
						overlaps += locate(oldendpoint.x, offset.y, zlevel)
					else if(offset.x < oldoffset.x && LastTurf.x >= oldoffset.x && LastTurf.x < oldendpoint.x)
						overlaps += locate(oldoffset.x, offset.y, zlevel)
						overlaps += locate(LastTurf.x, offset.y, zlevel)

			if(!skip)
				points += locate(offset.x, (offset.y - ln + 1), zlevel)
				points += locate(LastTurf.x, (LastTurf.y - ln + 1), zlevel)
				length += ln
			offset = T
		LastTurf = T

	for(var/i = 2; i <= overlaps.len; i += 2)
		var/skip_overlap = 0
		ln = 1
		for(var/i2 = points.len; i2 > 0; i2 -= 2)
			oldoffset = points[i2 - 1]
			oldendpoint = points[i2]

			if((oldendpoint.y - overlaps[i].y) < length[i2/2] && (oldendpoint.y - overlaps[i].y) >= 0)
				if(oldoffset.x == overlaps[i - 1].x && oldendpoint.x == overlaps[i].x)
					skip_overlap = 1
				else if(overlaps[i - 1].x >= oldoffset.x && overlaps[i].x <= oldendpoint.x)
					ln = length[i2/2]
		if(!skip_overlap)
			points += locate(overlaps[i - 1].x, (overlaps[i - 1].y - ln + 1), zlevel)
			points += locate(overlaps[i].x, (overlaps[i].y - ln + 1), zlevel)
			length += ln

	for(var/i = 2; i <= points.len; i += 2)
		var/turf/off = points[i - 1]
		var/turf/end = points[i]
		rectangles += new /datum/rectangle((end.x - off.x + 1), length[i/2], off.x, off.y)
	return rectangles