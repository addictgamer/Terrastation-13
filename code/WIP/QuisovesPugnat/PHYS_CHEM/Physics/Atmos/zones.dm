/*Zone instructions
"x""y""z" - Change given dimension.
"go - Move along directional axis.
"offx" etc. - Change offset along a given axis.
"rot" - Rotate. Uses BYOND directions.
"loop" - Indicates a segment connected to an earlier one in its own branch. Followed by the earlier segment's ID.
"split"
"branch"
*/

/datum/zone/
	var/turf/first_turf
	var/id
	var/list/branches
/*	var/list/junctions
	var/list/outlets
	var/list/contents
	var/list/turf
	var/volume
*/

/datum/ambientzone

/obj/effect/physics/stream
	invisibility = 101
	unacidable = 1

/obj/effect/physics/stream/outlet

