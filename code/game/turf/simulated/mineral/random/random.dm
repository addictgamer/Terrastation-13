
/turf/simulated/mineral/random
	name = "Mineral deposit"
	var/mineralAmtList = list("Uranium" = 5, "Iron" = 5, "Diamond" = 5, "Gold" = 5, "Silver" = 5, "Plasma" = 5/*, "Adamantine" = 5*/)
	var/mineralSpawnChanceList = list("Uranium" = 5, "Iron" = 50, "Diamond" = 1, "Gold" = 5, "Silver" = 5, "Plasma" = 25/*, "Adamantine" =5*/)//Currently, Adamantine won't spawn as it has no uses. -Durandan
	var/mineralChance = 10  //means 10% chance of this plot changing to a mineral deposit

/turf/simulated/mineral/random/New()
	..()
	if (prob(mineralChance))
		var/mName = pickweight(mineralSpawnChanceList) //temp mineral name

		if (mName)
			var/turf/simulated/mineral/M
			switch(mName)
				if ("Uranium")
					M = new/turf/simulated/mineral/uranium(src)
				if ("Iron")
					M = new/turf/simulated/mineral/iron(src)
				if ("Diamond")
					M = new/turf/simulated/mineral/diamond(src)
				if ("Gold")
					M = new/turf/simulated/mineral/gold(src)
				if ("Silver")
					M = new/turf/simulated/mineral/silver(src)
				if ("Plasma")
					M = new/turf/simulated/mineral/plasma(src)
				/*if ("Adamantine")
					M = new/turf/simulated/mineral/adamantine(src)*/
			if (M)
				src = M
				M.levelupdate()
	return

/turf/simulated/mineral/random/Del()
	return
