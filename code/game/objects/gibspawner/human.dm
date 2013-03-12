
/obj/gibspawner/human
	gibtypes = list(/obj/decal/cleanable/blood/gibs/up,/obj/decal/cleanable/blood/gibs/down,/obj/decal/cleanable/blood/gibs,/obj/decal/cleanable/blood/gibs,/obj/decal/cleanable/blood/gibs/body,/obj/decal/cleanable/blood/gibs/limb,/obj/decal/cleanable/blood/gibs/core)
	gibamounts = list(1,1,1,1,1,1,1)

	New()
		gibdirections = list(list(NORTH, NORTHEAST, NORTHWEST),list(SOUTH, SOUTHEAST, SOUTHWEST),list(WEST, NORTHWEST, SOUTHWEST),list(EAST, NORTHEAST, SOUTHEAST), alldirs, alldirs, list())
		gibamounts[6] = pick(0,1,2)
		..()
