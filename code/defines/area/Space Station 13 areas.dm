/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = "ICON FILENAME" 			(defaults to areas.dmi)
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = 0 				(defaults to 1)
	music = "music/music.ogg"		(defaults to "music/music.ogg")

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


/area
	var/fire = null
	var/atmos = 1
	var/atmosalm = 0
	var/poweralm = 1
	var/party = null
	level = null
	name = "Space"
	icon = 'areas.dmi'
	icon_state = "unknown"
	layer = 10
	mouse_opacity = 0
	var/lightswitch = 1

	var/eject = null

	var/requires_power = 1
	var/power_equip = 1
	var/power_light = 1
	var/power_environ = 1
	var/music = null
	var/used_equip = 0
	var/used_light = 0
	var/used_environ = 0


	var/no_air = null
	var/area/master				// master area used for power calcluations
								// (original area before splitting due to sd_DAL)
	var/list/related			// the other areas of the same type as this
	var/list/lights				// list of all lights on this area

	var/sec_status

	music = "music/areas/space.ogg"

/*Adding a wizard area teleport list because motherfucking lag -- Urist*/
/*I am far too lazy to make it a proper list of areas so I'll just make it run the usual telepot routine at the start of the game*/
var/list/teleportlocs = list()

proc/process_teleport_locs()
	for(var/area/AR in world)
		if(istype(AR, /area/shuttle) || istype(AR, /area/syndicate_station) || istype(AR, /area/wizard_station)) continue
		if(teleportlocs.Find(AR.name)) continue
		var/turf/picked = pick(get_area_turfs(AR.type))
		if (picked.z == 1)
			teleportlocs += AR.name
			teleportlocs[AR.name] = AR

	var/not_in_order = 0
	do
		not_in_order = 0
		if(teleportlocs.len <= 1)
			break
		for(var/i = 1, i <= (teleportlocs.len - 1), i++)
			if(sorttext(teleportlocs[i], teleportlocs[i+1]) == -1)
				teleportlocs.Swap(i, i+1)
				not_in_order = 1
	while(not_in_order)

var/list/ghostteleportlocs = list()

proc/process_ghost_teleport_locs()
	for(var/area/AR in world)
		if(ghostteleportlocs.Find(AR.name)) continue
		if(istype(AR, /area/turret_protected/aisat) || istype(AR, /area/derelict) || istype(AR, /area/tdome))
			ghostteleportlocs += AR.name
			ghostteleportlocs[AR.name] = AR
		var/turf/picked = pick(get_area_turfs(AR.type))
		if (picked.z == 1 || picked.z == 5)
			ghostteleportlocs += AR.name
			ghostteleportlocs[AR.name] = AR

	var/not_in_order = 0
	do
		not_in_order = 0
		if(ghostteleportlocs.len <= 1)
			break
		for(var/i = 1, i <= (ghostteleportlocs.len - 1), i++)
			if(sorttext(ghostteleportlocs[i], ghostteleportlocs[i+1]) == -1)
				ghostteleportlocs.Swap(i, i+1)
				not_in_order = 1
	while(not_in_order)


/*-----------------------------------------------------------------------------*/

/area/engine/
	music = "music/areas/engine.wav"

/area/turret_protected/
	music = "music/areas/turret_protected.wav"

/area/arrival
	music = "music/areas/arrival.wav"
	requires_power = 0

/area/arrival/start
	music = "music/areas/arrival-start.wav"
	name = "Arrival Area"
	icon_state = "start"

/area/arrival/arrivals
	music = "music/areas/arrivals.wav"
	name = "Arrivals"
	icon_state = "start"

/area/admin
	music = "music/areas/admin.wav"
	name = "Admin room"
	icon_state = "start"


//These are shuttle areas, they must contain two areas in a subgroup if you want to move a shuttle from one
//place to another. Look at escape shuttle for example.
//All shuttles show now be under shuttle since we have smooth-wall code.

/area/shuttle //DO NOT TURN THE SD_LIGHTING STUFF ON FOR SHUTTLES. IT BREAKS THINGS.
	music = "music/areas/shuttle.wav"
	requires_power = 0
	luminosity = 1
	sd_lighting = 0

/area/shuttle/arrival
	music = "music/areas/shuttle-arrival.wav"
	name = "Arrival Shuttle"

/area/shuttle/arrival/pre_game
	music = "music/areas/shuttle-arrival-pregame.wav"
	icon_state = "shuttle2"

/area/shuttle/arrival/station
	music = "music/areas/shuttle-arrival-station.wav"
	icon_state = "shuttle"

/area/shuttle/escape
	music = "music/areas/shuttle-escape.wav"
	name = "Emergency Shuttle"
	music = "music/escape.ogg"

/area/shuttle/escape/station
	music = "music/areas/shuttle-escape-station.wav"
	icon_state = "shuttle2"

/area/shuttle/escape/centcom
	music = "music/areas/shuttle-escape-centcom.wav"
	icon_state = "shuttle"

/area/shuttle/mining
	music = "music/areas/shuttle-mining.wav"
	name = "Mining Shuttle"
	music = "music/escape.ogg"

/area/shuttle/mining/station
	music = "music/areas/shuttle-mining-station.wav"
	icon_state = "shuttle2"

/area/shuttle/mining/outpost
	music = "music/areas/shuttle-mining-outpost.wav"
	icon_state = "shuttle"

/area/shuttle/transport1/centcom
	music = "music/areas/shuttle-transport1-centcom.wav"
	icon_state = "shuttle"
	name = "Transport Shuttle Centcom"

/area/shuttle/transport1/station
	music = "music/areas/shuttle-transport1-station.wav"
	icon_state = "shuttle"
	name = "Transport Shuttle"

/area/shuttle/transport2/centcom
	music = "music/areas/shuttle-transport2-centcom.wav"
	icon_state = "shuttle"

/area/shuttle/prison/
	music = "music/areas/shuttle-prison.wav"
	name = "Prison Shuttle"

/area/shuttle/prison/station
	music = "music/areas/shuttle-prison-station.wav"
	icon_state = "shuttle"

/area/shuttle/prison/prison
	music = "music/areas/shuttle-prison-prison.wav"
	icon_state = "shuttle2"

/area/shuttle/specops/centcom
	music = "music/areas/shuttle-specops-centcom.wav"
	name = "Special Ops Shuttle"
	icon_state = "shuttlered"

/area/shuttle/specops/station
	music = "music/areas/shuttle-specops-station.wav"
	name = "Special Ops Shuttle"
	icon_state = "shuttlered2"

/area/shuttle/administration/centcom
	music = "music/areas/shuttle-administration-centcom.wav"
	name = "Administration Shuttle Centcom"
	icon_state = "shuttlered"

/area/shuttle/administration/station
	music = "music/areas/shuttle-administration-station.wav"
	name = "Administration Shuttle"
	icon_state = "shuttlered2"

/area/shuttle/thunderdome
	music = "music/areas/shuttle-thunderdome.wav"
	name = "honk"

/area/shuttle/thunderdome/grnshuttle
	music = "music/areas/shuttle-thunder-grnshuttle.wav"
	name = "Thunderdome GRN Shuttle"
	icon_state = "green"

/area/shuttle/thunderdome/grnshuttle/dome
	music = "music/areas/shuttle-thunderdome-grnshuttle-dome.wav"
	name = "GRN Shuttle"
	icon_state = "shuttlegrn"

/area/shuttle/thunderdome/grnshuttle/station
	music = "music/areas/shuttle-thunderdome-grnshuttle-station.wav"
	name = "GRN Station"
	icon_state = "shuttlegrn2"

/area/shuttle/thunderdome/redshuttle
	music = "music/areas/shuttle-thunderdome-redshuttle.wav"
	name = "Thunderdome RED Shuttle"
	icon_state = "red"

/area/shuttle/thunderdome/redshuttle/dome
	music = "music/areas/shuttle-thunderdome-redshuttle-dome.wav"
	name = "RED Shuttle"
	icon_state = "shuttlered"

/area/shuttle/thunderdome/redshuttle/station
	music = "music/areas/shuttle-thunderdome-redshuttle-station.wav"
	name = "RED Station"
	icon_state = "shuttlered2"

/area/shuttle/pirateboardingshuttle
	music = "music/areas/shuttle-pirateboardingshuttle.wav"
	name = "Pirate boarding shuttle."
	icon_state = "pirateboarding"

/area/shuttle/pirateboardingshuttle/station //When it's docked at the space station.
	music = "music/areas/shuttle-pirateboardingshuttle-station.wav"
	name = "Pirate boarding shuttle - at the station"

/area/shuttle/pirateboardingshuttle/dock //When it's back in its dock at the pirate station.
	music = "music/areas/shuttle-pirateboardingshuttle-dock.wav"
	name = "Pirate boarding shuttle - at the dock"
	icon_state = "pirateboardingdock"

/area/shuttle/ruskie
	name = "ruskie transport"

/area/shuttle/ruskie/ruskie //the area at the ruskie station
	name = "Ruskie Transport Shuttle - Satellite"
	icon_state = "shuttle"

/area/shuttle/ruskie/centcom //the area at centcom
	name = "Ruskie Transport Shuttle - Centcom"
	icon_state = "shuttle2"

// === Trying to remove these areas:

/area/airtunnel1/      // referenced in airtunnel.dm:759

/area/dummy/           // Referenced in engine.dm:261

/area/start            // will be unused once kurper gets his login interface patch done
	music = "music/areas/start.wav"
	name = "start area"
	icon_state = "start"

// === end remove

// CENTCOM

/area/centcom
	music = "music/areas/centcom.wav"
	name = "Centcom"
	icon_state = "centcom"
	requires_power = 0

/area/centcom/control
	music = "music/areas/centcom-control.wav"
	name = "Centcom Control"

/area/centcom/evac
	music = "music/areas/centcom-evac.wav"
	name = "Centcom Emergency Shuttle"

/area/centcom/suppy
	music = "music/areas/centcom-supply.wav"
	name = "Centcom Supply Shuttle"

/area/centcom/ferry
	music = "music/areas/centcom-ferry.wav"
	name = "Centcom Transport Shuttle"

/area/centcom/shuttle
	music = "music/areas/centcom-shuttle.wav"
	name = "Centcom Administration Shuttle"

/area/centcom/test
	music = "music/areas/centcom-test.wav"
	name = "Centcom Testing Facility"

/area/centcom/living
	music = "music/areas/centcom-living.wav"
	name = "Centcom Living Quarters"

/area/centcom/specops
	music = "music/areas/centcom-specops.wav"
	name = "Centcom Special Ops"

/area/centcom/creed
	music = "music/areas/centcom-creed.wav"
	name = "Creed's Office"

/area/centcom/holding
	music = "music/areas/centcom-holding.wav"
	name = "Holding Facility"

//EXTRA

/area/asteroid					// -- TLE
	music = "music/areas/asteroid.wav"
	name = "Asteroid"
	icon_state = "asteroid"
	requires_power = 0

/area/asteroid/cave				// -- TLE
	music = "music/areas/asteroid-cave.wav"
	name = "Asteroid - Underground"
	icon_state = "cave"
	requires_power = 0

/area/planet/clown
	music = "music/areas/planet-clown.wav"
	name = "Clown Planet"
	icon_state = "honk"
	requires_power = 0

/area/tdome
	music = "music/areas/tdome.wav"
	name = "Thunderdome"
	icon_state = "thunder"
	requires_power = 0

/area/tdome/tdome1
	music = "music/areas/tdome-tdome1.wav"
	name = "Thunderdome (Team 1)"
	icon_state = "green"

/area/tdome/tdome2
	music = "music/areas/tdome-tdome2.wav"
	name = "Thunderdome (Team 2)"
	icon_state = "yellow"

/area/tdome/tdomeadmin
	music = "music/areas/tdome-tdomeadmin.wav"
	name = "Thunderdome (Admin.)"
	icon_state = "purple"

/area/tdome/tdomeobserve
	music = "music/areas/tdome-tdomeobserve.wav"
	name = "Thunderdome (Observer.)"
	icon_state = "purple"

//ENEMY

/area/syndicate_station
	music = "music/areas/syndicate_station.wav"
	name = "Syndicate Station"
	icon_state = "yellow"
	requires_power = 0

/area/syndicate_station/start
	music = "music/areas/syndicate_station-start.wav"
	name = "Syndicate Station Start"
	icon_state = "yellow"

/area/syndicate_station/one
	music = "music/areas/syndicate_station-one.wav"
	name = "Syndicate Station Location 1"
	icon_state = "green"

/area/syndicate_station/two
	music = "music/areas/syndicate_station-two.wav"
	name = "Syndicate Station Location 2"
	icon_state = "green"

/area/syndicate_station/three
	music = "music/areas/syndicate_station-three.wav"
	name = "Syndicate Station Location 3"
	icon_state = "green"

/area/syndicate_station/four
	music = "music/areas/syndicate_station-four.wav"
	name = "Syndicate Station Location 4"
	icon_state = "green"

/area/wizard_station
	music = "music/areas/wizard_station.wav"
	name = "Wizard's Den"
	icon_state = "yellow"
	requires_power = 0

//PRISON

/area/prison/arrival_airlock
	music = "music/areas/prison-arrival_airlock.wav"
	name = "Prison Station Airlock"
	icon_state = "green"
	requires_power = 0

/area/prison/control
	music = "music/areas/prison-control.wav"
	name = "Prison Security Checkpoint"
	icon_state = "security"

/area/prison/crew_quarters
	music = "music/areas/prison-crew_quarters.wav"
	name = "Prison Security Quarters"
	icon_state = "security"

/area/prison/rec_room
	music = "music/areas/prison-rec_room.wav"
	name = "Prison Rec Room"
	icon_state = "green"

/area/prison/closet
	music = "music/areas/prison-closet.wav"
	name = "Prison Supply Closet"
	icon_state = "dk_yellow"

/area/prison/hallway/fore
	music = "music/areas/prison-hallway-fore.wav"
	name = "Prison Fore Hallway"
	icon_state = "yellow"

/area/prison/hallway/aft
	music = "music/areas/prison-hallway-aft.wav"
	name = "Prison Aft Hallway"
	icon_state = "yellow"

/area/prison/hallway/port
	music = "music/areas/prison-hallway-port.wav"
	name = "Prison Port Hallway"
	icon_state = "yellow"

/area/prison/hallway/starboard
	music = "music/areas/prison-hallway-starboard.wav"
	name = "Prison Starboard Hallway"
	icon_state = "yellow"

/area/prison/morgue
	music = "music/areas/prison-morgue.wav"
	name = "Prison Morgue"
	icon_state = "morgue"

/area/prison/medical_research
	music = "music/areas/prison-medical_research.wav"
	name = "Prison Genetic Research"
	icon_state = "medresearch"

/area/prison/medical
	music = "music/areas/prison-medical.wav"
	name = "Prison Medbay"
	icon_state = "medbay"

/area/prison/solar
	music = "music/areas/prison-solar.wav"
	name = "Prison Solar Array"
	icon_state = "storage"
	requires_power = 0

/area/prison/podbay
	music = "music/areas/prison-podbay.wav"
	name = "Prison Podbay"
	icon_state = "dk_yellow"

/area/prison/solar_control
	music = "music/areas/prison-solar_control.wav"
	name = "Prison Solar Array Control"
	icon_state = "dk_yellow"

/area/prison/solitary
	music = "music/areas/prison-solitary.wav"
	name = "Solitary Confinement"
	icon_state = "brig"

/area/prison/cell_block/A
	music = "music/areas/prison-cell_block-a.wav"
	name = "Prison Cell Block A"
	icon_state = "brig"

/area/prison/cell_block/B
	music = "music/areas/prison-cell_block-b.wav"
	name = "Prison Cell Block B"
	icon_state = "brig"

/area/prison/cell_block/C
	music = "music/areas/prison-cell_block-c.wav"
	name = "Prison Cell Block C"
	icon_state = "brig"

//STATION13

/area/atmos
	music = "music/areas/atmos.wav"
	name = "Atmospherics"
	icon_state = "atmos"
	sec_status = access_atmospherics

/area/firestation
	music = "music/areas/firestation.wav"
	name = "Firestation"
	icon_state = "atmos"
	sec_status = access_maint_tunnels

/area/researchanddev
	music = "music/areas/researchanddev.wav"
	name = "Research center"
	icon_state = "atmos"
	sec_status = access_research

/area/crew_quarters/clown
	music = null
	name = "HONK!"
	icon_state = "honk"

/area/crew_quarters/mime
	music = null
	name = "Silent"
	icon_state = "purple"

//Maintenance

/area/maintenance/
	music = "music/areas/maintenance.wav"
	sec_status = access_maint_tunnels

/area/maintenance/fpmaint
	music = "music/areas/maintenance-fpmaint.wav"
	name = "Fore Port Maintenance"
	icon_state = "fpmaint"

/area/maintenance/fpmaint2
	music = "music/areas/maintenance-fpmaint2.wav"
	name = "Secondary Fore Port Maintenance"
	icon_state = "fpmaint"

/area/maintenance/fsmaint
	music = "music/areas/maintenance-fsmaint.wav"
	name = "Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/maintenance/asmaint
	music = "music/areas/maintenance-asmaint.wav"
	name = "Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/maintenance/asmaint2
	music = "music/areas/maintenance-asmaint2.wav"
	name = "Secondary Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/maintenance/apmaint
	music = "music/areas/maintenance-apmaint.wav"
	name = "Aft Port Maintenance"
	icon_state = "apmaint"

/area/maintenance/maintcentral
	music = "music/areas/maintenance-maintcentral.wav"
	name = "Central Maintenance"
	icon_state = "maintcentral"

/area/maintenance/fore
	music = "music/areas/maintenance-fore.wav"
	name = "Fore Maintenance"
	icon_state = "fmaint"

/area/maintenance/starboard
	music = "music/areas/maintenance-starboard.wav"
	name = "Starboard Maintenance"
	icon_state = "smaint"

/area/maintenance/port
	music = "music/areas/maintenance-port.wav"
	name = "Port Maintenance"
	icon_state = "pmaint"

/area/maintenance/aft
	music = "music/areas/maintenance-aft.wav"
	name = "Aft Maintenance"
	icon_state = "amaint"

/area/maintenance/storage
	music = "music/areas/maintenance-storage.wav"
	name = "Atmospherics"
	icon_state = "green"

/area/maintenance/incinerator
	music = "music/areas/maintenance-incinerator.wav"
	name = "Incinerator"
	icon_state = "disposal"

/area/maintenance/disposal
	music = "music/areas/maintenance-disposal.wav"
	name = "Waste Disposal"
	icon_state = "disposal"

//Hallway

/area/hallway/primary/fore
	music = "music/areas/hallway-primary-fore.wav"
	name = "Fore Primary Hallway"
	icon_state = "hallF"

/area/hallway/primary/starboard
	music = "music/areas/hallway-primary-starboard.wav"
	name = "Starboard Primary Hallway"
	icon_state = "hallS"

/area/hallway/primary/aft
	music = "music/areas/hallway-primary-aft.wav"
	name = "Aft Primary Hallway"
	icon_state = "hallA"

/area/hallway/primary/port
	music = "music/areas/hallway-primary-port.wav"
	name = "Port Primary Hallway"
	icon_state = "hallP"

/area/hallway/primary/central
	music = "music/areas/hallway-primary-central.wav"
	name = "Central Primary Hallway"
	icon_state = "hallC"

/area/hallway/secondary/exit
	music = "music/areas/hallway-secondary-exit.wav"
	name = "Escape Shuttle Hallway"
	icon_state = "escape"

/area/hallway/secondary/construction
	music = "music/areas/hallway-secondary-construction.wav"
	name = "Construction Area"
	icon_state = "construction"

/area/hallway/secondary/entry
	music = "music/areas/hallway-secondary-entry.wav"
	name = "Arrival Shuttle Hallway"
	icon_state = "entry"

/area/hallway/secondary/lounge
	music = "music/areas/hallway-primary-port.wav"
	name = "Lounge"
	icon_state = "hallP"

//Command

/area/bridge
	music = "music/areas/bridge.wav"
	name = "Bridge"
	icon_state = "bridge"
	music = "signal"
	sec_status = access_heads

/area/bridge/power
	music = "music/areas/bridge-power.wav"
	name = "Bridge - Power"
	icon_state = "bridge"
	music = "signal"
	sec_status = access_heads

/area/bridge/atmos
	music = "music/areas/bridge-atmos.wav"
	name = "Bridge - Atmos"
	icon_state = "bridge"
	music = "signal"
	sec_status = access_heads

/area/bridge/protected
	music = "music/areas/bridge-protected.wav"
	name = "Bridge - Protected Area"
	icon_state = "bridge"
	music = "signal"
	sec_status = access_heads

/area/crew_quarters/captain
	music = "music/areas/crew_quarters-captain.wav"
	name = "Captain's Quarters"
	icon_state = "captain"
	sec_status = access_captain

/area/crew_quarters/meetingroom
	music = "music/areas/crew_quarters-meetingroom.wav"
	name = "Meeting room"
	icon_state = "courtroom"

/area/crew_quarters/courtroom
	music = "music/areas/crew_quarters-courtroom.wav"
	name = "Courtroom"
	icon_state = "courtroom"

/area/crew_quarters/heads
	music = "music/areas/crew_quarters-heads.wav"
	name = "Head of Personnel's Quarters"
	icon_state = "head_quarters"
	sec_status = access_hop

/area/crew_quarters/heads/entrance
	music = "music/areas/crew_quarters-heads-entrance.wav"
	name = "Head of Personnel's - Entrance"
	icon_state = "head_quarters"
	sec_status = access_hop

/area/crew_quarters/heads/id_change
	music = "music/areas/crew_quarters-heads-id_change.wav"
	name = "Head of Personnel's - ID Change"
	icon_state = "head_quarters"
	sec_status = access_hop

/area/crew_quarters/hor
	music = "music/areas/crew_quarters-hor.wav"
	name = "Research Director's Office"
	icon_state = "head_quarters"
	sec_status = access_rd

/area/crew_quarters/chief
	music = "music/areas/crew_quarters-chief.wav"
	name = "Chief Engineer's Office"
	icon_state = "head_quarters"
	sec_status = access_ce

/area/mint
	music = "music/areas/mint.wav"
	name = "Mint"
	icon_state = "green"

//Crew

/area/crew_quarters
	music = "music/areas/crew_quarters.wav"
	name = "Dormitory"
	icon_state = "Sleep"

/area/crew_quarters/toilet
	music = "music/areas/crew_quarters-toilet.wav"
	name = "Dormitory Toilets"
	icon_state = "toilet"

/area/crew_quarters/sleep_male
	music = "music/areas/crew_quarters-sleep_male.wav"
	name = "Male Dorm"
	icon_state = "Sleep"

/area/crew_quarters/sleep_male/toilet_male
	music = "music/areas/crew_quarters-toilet_male.wav"
	name = "Male Toilets"
	icon_state = "toilet"

/area/crew_quarters/sleep_female
	music = "music/areas/crew_quarters-sleep_female.wav"
	name = "Female Dorm"
	icon_state = "Sleep"

/area/crew_quarters/sleep_female/toilet_female
	music = "music/areas/crew_quarters-toilet_female.wav"
	name = "Female Toilets"
	icon_state = "toilet"

/area/crew_quarters/locker
	music = "music/areas/crew_quarters-locker.wav"
	name = "Locker Room"
	icon_state = "locker"

/area/crew_quarters/locker/locker_toilet
	music = "music/areas/crew_quarters-locker-locker_toilet.wav"
	name = "Locker Toilets"
	icon_state = "toilet"

/area/crew_quarters/fitness
	music = "music/areas/crew_quarters-fitness.wav"
	name = "Fitness Room"
	icon_state = "fitness"

/area/crew_quarters/cafeteria
	music = "music/areas/crew_quarters-cafeteria.wav"
	name = "Cafeteria"
	icon_state = "cafeteria"

/area/crew_quarters/kitchen
	music = "music/areas/crew_quarters-kitchen.wav"
	name = "Kitchen"
	icon_state = "kitchen"

/area/crew_quarters/bar
	music = "music/areas/crew_quarters-bar.wav"
	name = "Bar"
	icon_state = "bar"

/area/crew_quarters/theatre
	music = "music/areas/crew_quarters-theatre.wav"
	name = "Theatre"
	icon_state = "Theatre"

/area/library
	music = "music/areas/crew_quarters-library.wav"
	name = "Library"
	icon_state = "library"

/area/chapel/main
	music = "music/areas/chapel-main.wav"
	name = "Chapel"
	icon_state = "chapel"

/area/chapel/office
	music = "music/areas/chapel-office.wav"
	name = "Chapel Office"
	icon_state = "chapeloffice"
	sec_status = access_chapel_office

/area/lawoffice
	music = "music/areas/lawoffice.wav"
	name = "Law Office"
	icon_state = "law"

//Engineering

/area/engine
	engine_smes
		music = "music/areas/engine-engine_smes.wav"
		name = "Engineering SMES"
		icon_state = "engine_smes"
		requires_power = 0//This area only covers the batteries and they deal with their own power

	engineering
		music = "music/areas/engine-engineering.wav"
		name = "Engineering"
		icon_state = "engine"

	chiefs_office
		music = "music/areas/engine-chiefs_office.wav"
		name = "Chief Engineers office"
		icon_state = "engine_control"


//Solars

/area/solar
	music = "music/areas/solar.wav"
	requires_power = 0
	luminosity = 1
	sd_lighting = 0

	auxport
		music = "music/areas/solar-auxport.wav"
		name = "Port Auxiliary Solar Array"
		icon_state = "panelsA"

	auxstarboard
		music = "music/areas/solar-auxstarboard.wav"
		name = "Starboard Auxiliary Solar Array"
		icon_state = "panelsA"

	fore
		music = "music/areas/solar-fore.wav"
		name = "Fore Solar Array"
		icon_state = "yellow"

	aft
		music = "music/areas/solar-aft.wav"
		name = "Aft Solar Array"
		icon_state = "aft"

	starboard
		music = "music/areas/solar-starboard.wav"
		name = "Starboard Solar Array"
		icon_state = "panelsS"

	port
		music = "music/areas/solar-port.wav"
		name = "Port Solar Array"
		icon_state = "panelsP"

/area/maintenance/auxsolarport
	music = "music/areas/maintenance-auxsolarport.wav"
	name = "Port Auxiliary Solar Maintenance"
	icon_state = "SolarcontrolA"

/area/maintenance/starboardsolar
	music = "music/areas/maintenance-starboardsolar.wav"
	name = "Starboard Solar Maintenance"
	icon_state = "SolarcontrolS"

/area/maintenance/portsolar
	music = "music/areas/maintenance-portsolar.wav"
	name = "Port Solar Maintenance"
	icon_state = "SolarcontrolP"

/area/maintenance/auxsolarstarboard
	music = "music/areas/maintenance-auxsolarstarboard.wav"
	name = "Starboard Auxiliary Solar Maintenance"
	icon_state = "SolarcontrolA"


/area/assembly/chargebay
	music = "music/areas/assembly-chargebay.wav"
	name = "Recharging Bay"
	icon_state = "mechbay"

/area/assembly/showroom
	music = "music/areas/assembly-showroom.wav"
	name = "Robotics Showroom"
	icon_state = "showroom"

/area/assembly/assembly_line
	music = "music/areas/assembly-assembly_line.wav"
	name = "Assembly Line"
	icon_state = "ass_line"

//Teleporter

/area/teleporter
	music = "music/areas/teleporter.wav"
	name = "Teleporter"
	icon_state = "teleporter"
	music = "signal"

/area/AIsattele
	music = "music/areas/AIsattele.wav"
	name = "AI Satellite Teleporter Room"
	icon_state = "teleporter"
	music = "signal"

//MedBay

/area/medical/medbay
	music = "music/areas/medical-medbay.wav"
	name = "Medbay"
	icon_state = "medbay"
	music = 'signal.ogg'
	sec_status = access_medical

/area/medical/patients_rooms
	music = "music/areas/medica-lpatients_roomms.wav"
	name = "Patients Rooms"
	icon_state = "patients"
	sec_status = access_medical

/area/medical/cmo
	music = "music/areas/medical-cmo.wav"
	name = "Chief Medical Officer's office"
	icon_state = "CMO"
	sec_status = access_cmo

/area/medical/robotics
	music = "music/areas/medical-robotics.wav"
	name = "Robotics"
	icon_state = "medresearch"
	sec_status = access_robotics
/area/medical/research
	music = "music/areas/medical-research.wav"
	name = "Medical Research"
	icon_state = "medresearch"
/area/medical/virology
	music = "music/areas/medical-virology.wav"
	name = "Virology"
	icon_state = "virology"

/area/medical/morgue
	music = "music/areas/medical-morgue.wav"
	name = "Morgue"
	icon_state = "morgue"
	sec_status = access_morgue

/area/medical/chemistry
	music = "music/areas/medical-chemistry.wav"
	name = "Chemistry"
	icon_state = "chem"

/area/medical/surgery
	music = "music/areas/medical-surgery.wav"
	name = "Surgery"
	icon_state = "surgery"

/area/medical/surgery/loyalty
	music = "music/areas/medical-loyalty.wav"
	name = "Implant Surgery"
	icon_state = "surgery"

/area/medical/cryo
	music = "music/areas/medical-cyro.wav"
	name = "Cryo"
	icon_state = "cryo"

/area/medical/exam_room
	music = "music/areas/medical-exam_room.wav"
	name = "Exam Room"
	icon_state = "exam_room"
	sec_status = access_medical

/area/medical/genetics
	music = "music/areas/medical-genetics.wav"
	name = "Genetics"
	icon_state = "genetics"

/area/medical/storage
	music = "music/areas/medical-storage.wav"
	name = "Medical storage"
	icon_state = "chem"
	sec_status = access_medical

/area/medical/waiting
	music = "music/areas/medical-waiting.wav"
	name = "Waiting area"
	icon_state = "exam_room"

/area/medical/office
	music = "music/areas/medical-office.wav"
	name = "Medical office"
	icon_state = "CMO"
	sec_status = access_medical

//Security

/area/security
	music = "music/areas/security.wav"
	sec_status = access_security

/area/security/main
	music = "music/areas/security-main.wav"
	name = "Security"
	icon_state = "security"

/area/security/brig
	music = "music/areas/security-brig.wav"
	name = "Brig"
	icon_state = "brig"


/area/security/secstorage
	music = "music/areas/security-secstorage.wav"
	name = "Security storage"
	icon_state = "Warden"

/area/security/warden
	music = "music/areas/security-warden.wav"
	name = "Warden"
	icon_state = "Warden"

/area/security/hos
	music = "music/areas/securty-hos.wav"
	name = "Head of Security"
	icon_state = "security"

/area/security/detectives_office
	music = "music/areas/security-detectives_office.wav"
	name = "Detectives Office"
	icon_state = "detective"
	sec_status = access_forensics_lockers

/area/security/brig2
	music = "music/areas/security-brig2.wav"
	name = "Secondary brig"
	icon_state = "brig"

/*
	New()
		..()

		spawn(10) //let objects set up first
			for(var/turf/turfToGrayscale in src)
				if(turfToGrayscale.icon)
					var/icon/newIcon = icon(turfToGrayscale.icon)
					newIcon.GrayScale()
					turfToGrayscale.icon = newIcon
				for(var/obj/objectToGrayscale in turfToGrayscale) //1 level deep, means tables, apcs, locker, etc, but not locker contents
					if(objectToGrayscale.icon)
						var/icon/newIcon = icon(objectToGrayscale.icon)
						newIcon.GrayScale()
						objectToGrayscale.icon = newIcon
*/

/area/security/nuke_storage
	music = "music/areas/security-nuke_storage.wav"
	name = "Vault"
	icon_state = "nuke_storage"

/area/security/checkpoint
	music = "music/areas/security-checkpoint.wav"
	name = "Security Checkpoint"
	icon_state = "checkpoint1"

/area/security/checkpoint2
	music = "music/areas/security-checkpoint2.wav"
	name = "Security Checkpoint"
	icon_state = "security"

/area/security/vacantoffice
	music = "music/areas/security-vacantoffice.wav"
	name = "Vacant Office"
	icon_state = "security"

/area/quartermaster
	music = "music/areas/quartermaster.wav"
	name = "Quartermasters"
	icon_state = "quart"
	sec_status = access_cargo

///////////WORK IN PROGRESS//////////

/area/quartermaster/sorting
	music = "music/areas/quartermaster-sorting.wav"
	name = "Delivery Office"
	icon_state = "quartstorage"

////////////WORK IN PROGRESS//////////

/area/quartermaster/office
	music = "music/areas/quartermaster-office.wav"
	name = "Cargo Office"
	icon_state = "quartoffice"

/area/quartermaster/storage
	music = "music/areas/quartermaster-storage.wav"
	name = "Cargo Bay"
	icon_state = "quartstorage"

/area/quartermaster/qm
	music = "music/areas/quartermaster-qm.wav"
	name = "Quartermaster's Office"
	icon_state = "quart"

/area/quartermaster/miningdock
	music = "music/areas/quartermaster-miningdock.wav"
	name = "Mining Dock"
	icon_state = "mining"

/area/quartermaster/miningstorage
	music = "music/areas/quartermaster-miningstorage.wav"
	name = "Mining Storage"
	icon_state = "green"

/area/quartermaster/mechbay
	music = "music/areas/quartermaster-mechbay.wav"
	name = "Mech Bay"
	icon_state = "yellow"

/area/janitor/
	music = "music/areas/janitor.wav"
	name = "Janitors Closet"
	icon_state = "janitor"
	sec_status = access_janitor
/area/hydroponics
	music = "music/areas/hydroponics.wav"
	name = "Hydroponics"
	icon_state = "hydro"
/area/hydroponics/storage
	music = "music/areas/hydroponics-storage.wav"
	name = "Hydroponics - Storage"
	icon_state = "hydro"

//Toxins

/area/toxins/lab
	music = "music/areas/toxins-lab.wav"
	name = "Toxin Lab"
	icon_state = "toxlab"
	sec_status = access_tox

/area/toxins/xenobiology
	music = "music/areas/toxins-xenobiology.wav"
	name = "Xenobiology Lab"
	icon_state = "toxlab"

/area/toxins/storage
	music = "music/areas/toxins-storage.wav"
	name = "Toxin Storage"
	icon_state = "toxstorage"
	sec_status = access_tox_storage
/area/toxins/test_area
	music = "music/areas/toxins-test_area.wav"
	name = "Toxin Test Area"
	icon_state = "toxtest"

/area/toxins/mixing
	music = "music/areas/toxins-mixing.wav"
	name = "Toxin Mixing Room"
	icon_state = "toxmix"

/area/toxins/server
	music = "music/areas/toxins-server.wav"
	name = "Server Room"
	icon_state = "server"
	sec_status = access_rd

//Storage

/area/storage/tools
	music = "music/areas/storage-tools.wav"
	name = "Tool Storage"
	icon_state = "storage"
	sec_status = access_maint_tunnels
/area/storage/primary
	music = "music/areas/storage-primary.wav"
	name = "Primary Tool Storage"
	icon_state = "primarystorage"
	sec_status = access_maint_tunnels
/area/storage/autolathe
	music = "music/areas/storage-autolathe.wav"
	name = "Autolathe Storage"
	icon_state = "storage"

/area/storage/auxillary
	music = "music/areas/storage-auxillary.wav"
	name = "Auxillary Storage"
	icon_state = "auxstorage"

/area/storage/eva
	music = "music/areas/storage-eva.wav"
	name = "EVA Storage"
	icon_state = "eva"
	sec_status = access_eva

/area/storage/secure
	music = "music/areas/storage-secure.wav"
	name = "Secure Storage"
	icon_state = "storage"

/area/storage/emergency
	music = "music/areas/storage-emergency.wav"
	name = "Emergency Storage A"
	icon_state = "emergencystorage"

/area/storage/emergency2
	music = "music/areas/storage-emergency2.wav"
	name = "Emergency Storage B"
	icon_state = "emergencystorage"

/area/storage/tech
	music = "music/areas/storage-tech.wav"
	name = "Technical Storage"
	icon_state = "auxstorage"
	sec_status = access_tech_storage

/area/storage/testroom
	music = "music/areas/storage-testroom.wav"
	requires_power = 0
	name = "Test Room"
	icon_state = "storage"

//DJSTATION

/area/djstation
	music = "music/areas/djstation.wav"
	name = "Ruskie DJ Station"
	icon_state = "DJ"

/area/djstation/solars
	music = "music/areas/djstation-solars.wav"
	name = "DJ Station Solars"
	icon_state = "DJ"

//DERELICT

/area/derelict
	music = "music/areas/derelict.wav"
	name = "Derelict Station"
	icon_state = "storage"

/area/derelict/terralabs
	music = "music/areas/derelict-terralabs.wav"
	name = "Terralabs"
	icon_state = "yellow"

/area/derelict/terralabs/main
	music = "music/areas/derelict-terralabs-main.wav"
	name = "Terralabs Main"
	icon_state = "hallP"

/area/derelict/terralabs/storage
	music = "music/areas/derelict-terralabs-storage.wav"
	name = "Terralabs Storage"
	icon_state = "storage"

/area/derelict/terralabs/power
	music = "music/areas/derelict-terralabs-power.wav"
	name = "Terralabs Power"
	icon_state = "green"

/area/derelict/terralabs/hall
	music = "music/areas/derelict-terralabs-hall.wav"
	name = "Terralabs Hall"
	icon_state = "hallS"

/area/derelict/hallway/primary
	music = "music/areas/derelict-hallway-primary.wav"
	name = "Derelict Primary Hallway"
	icon_state = "hallP"

/area/derelict/hallway/secondary
	music = "music/areas/derelict-hallway-secondary.wav"
	name = "Derelict Secondary Hallway"
	icon_state = "hallS"

/area/derelict/arrival
	music = "music/areas/derelict-arrival.wav"
	name = "Arrival Centre"
	icon_state = "yellow"

/area/derelict/storage/equipment
	music = "music/areas/derelict-storage-equipment.wav"
	name = "Derelict Equipment Storage"

/area/derelict/storage/storage_access
	music = "music/areas/derelict-storage-storage_access.wav"
	name = "Derelict Storage Access"

/area/derelict/storage/engine_storage
	music = "music/areas/derelct-storage-engine_storage.wav"
	name = "Derelict Engine Storage"
	icon_state = "green"

/area/derelict/bridge
	music = "music/areas/derelict-bridge.wav"
	name = "Control Room"
	icon_state = "bridge"

/area/derelict/secret
	music = "music/areas/derelict-secret.wav"
	name = "Secret Room"
	icon_state = "library"

/area/derelict/bridge/access
	music = "music/areas/derelict-bridge-access.wav"
	name = "Control Room Access"
	icon_state = "auxstorage"

/area/derelict/bridge/ai_upload
	music = "music/areas/derelict-bridge-ai_upload.wav"
	name = "Ruined Computer Core"
	icon_state = "ai"

/area/derelict/solar_control
	music = "music/areas/derelict-solar_control.wav"
	name = "Solar Control"
	icon_state = "engine"

/area/derelict/crew_quarters
	music = "music/areas/derelict-crew_quarters.wav"
	name = "Derelict Crew Quarters"
	icon_state = "fitness"

/area/derelict/medical
	music = "music/areas/derelict-medical.wav"
	name = "Derelict Medbay"
	icon_state = "medbay"

/area/derelict/medical/morgue
	music = "music/areas/derelict-medcal-morgue.wav"
	name = "Derelict Morgue"
	icon_state = "morgue"

/area/derelict/medical/chapel
	music = "music/areas/derelict-medical-chapel.wav"
	name = "Derelict Chapel"
	icon_state = "chapel"

/area/derelict/teleporter
	music = "music/areas/derelict-teleporter.wav"
	name = "Derelict Teleporter"
	icon_state = "teleporter"

/area/derelict/eva
	music = "music/areas/derelict-eva.wav"
	name = "Derelict EVA Storage"
	icon_state = "eva"

/area/derelict/ship
	music = "music/areas/derelict-ship.wav"
	name = "Abandoned ship"
	icon_state = "yellow"

/area/solar/derelict_starboard
	music = "music/areas/solar-derelict_starboard.wav"
	name = "Derelict Starboard Solar Array"
	icon_state = "panelsS"

/area/solar/derelict_aft
	music = "music/areas/solar-derelict_aft.wav"
	name = "Derelict Aft Solar Array"
	icon_state = "aft"

/area/derelict/singularity_engine
	music = "music/areas/derelict-singularity_engine.wav"
	name = "Derelict Singularity Engine"
	icon_state = "engine"

//Construction

/area/construction
	music = "music/areas/construction.wav"
	name = "Construction Area"
	icon_state = "yellow"

/area/construction/supplyshuttle
	music = "music/areas/construction-supplyshuttle.wav"
	name = "Supply Shuttle"
	icon_state = "yellow"

/area/construction/quarters
	music = "music/areas/construction-quarters.wav"
	name = "Engineer's Quarters"
	icon_state = "yellow"

/area/construction/qmaint
	music = "music/areas/construction-qmaint.wav"
	name = "Maintenance"
	icon_state = "yellow"

/area/construction/hallway
	music = "music/areas/construction-hallway.wav"
	name = "Hallway"
	icon_state = "yellow"

/area/construction/solars
	music = "music/areas/construction-solars.wav"
	name = "Solar Panels"
	icon_state = "yellow"

/area/construction/solarscontrol
	music = "music/areas/construction-solarscontrol.wav"
	name = "Solar Panel Control"
	icon_state = "yellow"

/area/construction/Storage
	music = "music/areas/construction-storage.wav"
	name = "Construction Site Storage"
	icon_state = "yellow"

//AI

/area/ai_monitored/storage/eva
	music = "music/areas/ai_monitored-storage-eva.wav"
	name = "EVA Storage"
	icon_state = "eva"
	sec_status = access_eva

/area/ai_monitored/storage/secure
	music = "music/areas/ai_monitored-storage-secure.wav"
	name = "Secure Storage"
	icon_state = "storage"

/area/ai_monitored/storage/emergency
	music = "music/areas/ai_monitored-storage-emergency.wav"
	name = "Emergency Storage"
	icon_state = "storage"

/area/turret_protected/ai_upload
	music = "music/areas/turret_protected-ai_upload.wav"
	name = "AI Upload Chamber"
	icon_state = "ai_upload"
	sec_status = access_ai_upload

/area/turret_protected/ai_upload_foyer
	music = "music/areas/turret_protected-ai_upload_foyer.wav"
	name = "AI Upload Foyer"
	icon_state = "ai_foyer"
	sec_status = access_ai_upload

/area/turret_protected/ai
	music = "music/areas/turret_protected-ai.wav"
	name = "AI Chamber"
	icon_state = "ai_chamber"
	sec_status = access_ai_upload
/area/turret_protected/aisat
	music = "music/areas/turret_protected-aisat.wav"
	name = "AI Satellite"
	icon_state = "ai"
	sec_status = access_ai_upload
/area/turret_protected/aisat_interior
	music = "music/areas/turret_protected-aisat_interior.wav"
	name = "AI Satellite"
	icon_state = "ai"
	sec_status = access_ai_upload
/area/turret_protected/AIsatextFP
	music = "music/areas/turret_protected-aisatextfp.wav"
	name = "AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	sd_lighting = 0

/area/turret_protected/AIsatextFS
	music = "music/areas/turret_protected-aisatextfs.wav"
	name = "AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	sd_lighting = 0

/area/turret_protected/AIsatextAS
	music = "music/areas/turret_protected-aisatextas.wav"
	name = "AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	sd_lighting = 0

/area/turret_protected/AIsatextAP
	music = "music/areas/turret_protected-aisatextap.wav"
	name = "AI Sat Ext"
	icon_state = "storage"
	luminosity = 1
	sd_lighting = 0

/area/turret_protected/NewAIMain
	music = "music/areas/turret_protected-newaimain.wav"
	name = "AI Main New"
	icon_state = "storage"


/area/syndicate_mothership/elite_squad
	music = "music/areas/syndicate_mothership-elite_squad.wav"
/area/syndicate_mothership/control/
	music = "music/areas/sundicate_mothership=control.wav"
/area/syndicate_mothership
	music = "music/areas/syndicate_mothership.wav"
/area/shuttle/syndicate_elite/mothership
	music = "music/areas/shuttle-syndicate_elite-mothership.wav"
/area/shuttle/syndicate_elite/station
	music = "music/areas/shuttle-syndicate_elite-station.wav"

/area/shuttle/alien/mine
	music = "music/areas/shuttle-alien-mine.wav"
/area/shuttle/alien/base
	music = "music/areas/shuttle-alien-base.wav"
/////////////////////////////////////////////////////////////////////
/*
 Lists of areas to be used with is_type_in_list.
 Used in gamemodes code at the moment. --rastaf0
*/

// CENTCOM
var/list/centcom_areas = list (
	/area/centcom,
	/area/shuttle/escape/centcom,
	/area/shuttle/transport1/centcom,
	/area/shuttle/transport2/centcom,
	/area/shuttle/administration/centcom,
	/area/shuttle/specops/centcom,
)

//SPACE STATION 13
var/list/the_station_areas = list (
	/area/shuttle/arrival,
	/area/shuttle/escape/station,
	/area/shuttle/mining/station,
	/area/shuttle/transport1/station,
	// /area/shuttle/transport2/station,
	/area/shuttle/prison/station,
	/area/shuttle/administration/station,
	/area/shuttle/specops/station,
	/area/atmos,
	/area/maintenance,
	/area/hallway,
	/area/bridge,
	/area/crew_quarters,
	/area/mint,
	/area/library,
	/area/chapel,
	/area/lawoffice,
	/area/engine,
	/area/solar,
	/area/assembly,
	/area/teleporter,
	/area/medical,
	/area/security,
	/area/quartermaster,
	/area/janitor,
	/area/hydroponics,
	/area/toxins,
	/area/storage,
	/area/construction,
	/area/ai_monitored/storage/eva, //do not try to simplify to "/area/ai_monitored" --rastaf0
	/area/ai_monitored/storage/secure,
	/area/ai_monitored/storage/emergency,
	/area/turret_protected/ai_upload, //do not try to simplify to "/area/turret_protected" --rastaf0
	/area/turret_protected/ai_upload_foyer,
	/area/turret_protected/ai,
)


/area/beach
	music = "music/areas/beach.wav"
	name = "Gaylord's private beach"
	icon_state = "null"
	luminosity = 1
	sd_lighting = 0
	requires_power = 0
	var/sound/mysound = null

	New()
		..()
		var/sound/S = new/sound()
		mysound = S
		S.file = 'shore.ogg'
		S.repeat = 1
		S.wait = 0
		S.channel = 123
		S.volume = 100
		S.priority = 255
		S.status = SOUND_UPDATE
		process()

	Entered(atom/movable/Obj,atom/OldLoc)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_UPDATE
				Obj << mysound
		return

	Exited(atom/movable/Obj)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_PAUSED | SOUND_UPDATE
				Obj << mysound

	proc/process()
		set background = 1

		var/sound/S = null
		var/sound_delay = 0
		if(prob(25))
			S = sound(file=pick('seag1.ogg','seag2.ogg','seag3.ogg'), volume=100)
			sound_delay = rand(0, 50)

		for(var/mob/living/carbon/human/H in src)
			if(H.s_tone > -55)
				H.s_tone--
				H.update_body()
			if(H.client)
				mysound.status = SOUND_UPDATE
				H << mysound
				if(S)
					spawn(sound_delay)
						H << S

		spawn(60) .()