/* Chickenz! Size 9 singularity eats the station. */

/proc/unleash_chickenz()
	var/found = 0

	for(var/obj/machinery/singularity/s in world)
		spawned_chickenz = 1 //Event made the chickenz. It was not a grown up one.
		s.energy = 10000
		s.expand(9) //Make it big.
		found = 1

	if(found)
		chickenz = 1
		world << "http://www.youtube.com/watch?v=wYUhGRynyJw <- That's what's happening to the station right now."
		world << sound('chickenz.mid', 1)

	return