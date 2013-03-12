
/obj/gibspawner/xeno
	gibtypes = list(/obj/decal/cleanable/xenoblood/xgibs/up,/obj/decal/cleanable/xenoblood/xgibs/down,/obj/decal/cleanable/xenoblood/xgibs,/obj/decal/cleanable/xenoblood/xgibs,/obj/decal/cleanable/xenoblood/xgibs/body,/obj/decal/cleanable/xenoblood/xgibs/limb,/obj/decal/cleanable/xenoblood/xgibs/core)
	gibamounts = list(1,1,1,1,1,1,1)

	New()
		gibdirections = list(list(NORTH, NORTHEAST, NORTHWEST),list(SOUTH, SOUTHEAST, SOUTHWEST),list(WEST, NORTHWEST, SOUTHWEST),list(EAST, NORTHEAST, SOUTHEAST), alldirs, alldirs, list())
		gibamounts[6] = pick(0,1,2)
		..()
