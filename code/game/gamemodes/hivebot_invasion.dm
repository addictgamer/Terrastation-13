/proc/hivebot_invasion() // -- TLE
	command_alert("Unidentified electronic signals detected aboard [station_name()]. Proceed with caution.", "Unidentified Contact Alert")
	world << sound('hivebots_announcer.ogg')
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in world)
		//if(temp_vent.loc.z == 1)
		//	vents.Add(temp_vent)
		vents.Add(temp_vent)
	var/spawncount = rand(2, 30)
	while(spawncount > 0)
		var/obj/vent = pick(vents)
		if(prob(50))
			new /obj/critter/hivebot/strong (vent.loc)
		if(prob(50))
			new /obj/critter/hivebot/strong (vent.loc)
		if(prob(75))
			new /obj/critter/hivebot/tele/rapid (vent.loc)
		else
			new /obj/critter/hivebot/tele/massive (vent.loc)
		vents.Remove(vent)
		spawncount -= 1

	var/list/floors = list() //List of all the floors the hivebots can spawn at.
	for(var/turf/simulated/floor/temp_floor in world)
		//if(temp_floor.loc.z == 1)
		//	floors.Add(temp_floor)
		floors.Add(temp_floor)

	for(var/turf/unsimulated/floor/temp_floor in world)
		//if(temp_floor.loc.z == 1)
		//	floors.Add(temp_floor)
		floors.Add(temp_floor)
	spawncount = rand(100)
	while(spawncount > 0)
		var/obj/floor = pick(floors)
		new /obj/critter/hivebot/borg (floor.loc)
		floors.Remove(floor)
		spawncount -= 1


	world << sound('hivebots.ogg')
	//world << sound('siren.ogg')
	world << sound('alarm.wav')
	world << sound('hivebot_invasion.mid')