
/obj/gibspawner/robot
	sparks = 1
	gibtypes = list(/obj/decal/cleanable/robot_debris/up,/obj/decal/cleanable/robot_debris/down,/obj/decal/cleanable/robot_debris,/obj/decal/cleanable/robot_debris,/obj/decal/cleanable/robot_debris,/obj/decal/cleanable/robot_debris/limb)
	gibamounts = list(1,1,1,1,1,1)

	New()
		gibdirections = list(list(NORTH, NORTHEAST, NORTHWEST),list(SOUTH, SOUTHEAST, SOUTHWEST),list(WEST, NORTHWEST, SOUTHWEST),list(EAST, NORTHEAST, SOUTHEAST), alldirs, alldirs)
		gibamounts[6] = pick(0,1,2)
		..()
