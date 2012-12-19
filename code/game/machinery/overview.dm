//#define AMAP

proc/getr(col)
	return hex2num( copytext(col, 2,4))

proc/getg(col)
	return hex2num( copytext(col, 4,6))

proc/getb(col)
	return hex2num( copytext(col, 6))


/mob/proc/clearmap()
	src.client.screen -= src.mapobjs
	for(var/obj/screen/O in mapobjs)
		del(O)

	mapobjs = null
	src.machine = null
