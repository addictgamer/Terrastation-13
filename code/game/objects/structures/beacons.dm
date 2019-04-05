//Tauka has sex with guys! lol.

//Cosmetic objects that do basically jack shit. Just wanted em cuz they look cool.
//These were ported from a time in our code waaaay back in like 2013 or some shit. Whether or not I make them functional for anything is
//			A MYSTERY

/obj/structure/landing_beacon
	name = "Beacon"
	desc = "A ship landing beacon. Or something."
	icon = 'icons/obj/beacons.dmi'
	anchored = 1
	density = 0

/obj/structure/landing_beacon/s_yard
	desc = "Marks a border for something."
	icon_state = "s_yard"

/obj/structure/landing_beacon/antag_r
	desc = "That... is most certainly NOT a beacon of Nanotrasen origin. It also looks incredibly worn. How did it get there?"
	icon_state = "nefarious_r"

//Added by Quisoves Pugnat
/obj/item/shuttle_beacon
	dir = NORTH
	name = "portable landing beacon"
	desc = "ScataLogic proudly presents the latest in bluespace docking-techonology!\nJust deploy it in a sufficiently open space, and let the state-of-the-art scanner do the rest!"
	icon = 'icons/obj/beacons.dmi'
	icon_state = "shuttle"
	atom_say_verb = "chirps"
	var/active = FALSE
	var/shuttle_id = ""
	var/zlevel = 0	//If set, restricts the beacon's activation to a given z-level.
	var/turf/turf_type = /turf/space
	var/area/area_type = /area/space
	var/obj/docking_port/mobile/parent
	var/serial

/obj/item/shuttle_beacon/New()
	..()
	serial = rand(1, 100000)

/obj/item/shuttle_beacon/attack_self(mob/user)
	if(!parent)
		for(var/obj/docking_port/mobile/M in shuttle_master.mobile)
			if(M.id == shuttle_id)
				parent = M
				atom_say("Initialization succesful")
				break
		if(!parent)
			atom_say("Initialization failed: Could not find linked vessel.")
			return
	if(zlevel && user.z != zlevel)
		atom_say("Linked vessel not within range.")
		return
	var/port_name = input(user, "Label this location:", "Beacon Configuration", null)  as text
	if(!port_name)
		port_name = "Portable landing beacon #[serial]"
	user.drop_item()
	scan(user, port_name)

/obj/item/shuttle_beacon/proc/scan(mob/user, port_name)
	set waitfor = FALSE
	anchored = TRUE
	active = TRUE
	icon_state = "shuttle_active"
	atom_say("Scanning... Please stand by...")
	var/obj/docking_port/stationary/port = new /obj/docking_port/stationary(get_step(src, dir))
	shuttle_master.portable_beacon_count++
	port.name = port_name
	port.dir = dir
	port.turf_type = turf_type
	port.id = "portable_beacon[shuttle_master.portable_beacon_count]"
	port.width = parent.width
	port.height = parent.height
	port.dwidth = parent.dwidth
	port.dheight = parent.dheight
	var/list/scanner_overlays = list()
	var/list/shuttle_turfs = parent.ripple_area(port)
	var/abort = FALSE
	for(var/turf/T in shuttle_turfs)
		sleep(5)
		var/obj/effect/overlay/O = new /obj/effect/overlay(T)
		O.icon = 'icons/effects/effects.dmi'
		O.icon_state = "ion_fade"
		scanner_overlays += O
		if(T.type != turf_type || (get_area(T)).type != area_type)
			abort= TRUE
			break
//This trio of iterations is perhaps less than ideal, but it should minimize lag and will suffice until I streamline density checks.
		for(var/obj/structure/blargh in T)
			if(blargh.density)
				abort = TRUE
				break
		if(abort)
			break
		for(var/obj/machinery/blargh in T)
			if(blargh.density)
				abort = TRUE
				break
		if(abort)
			break

		for(var/obj/spacepod/blargh in T)
			if(blargh.density)
				abort = TRUE
				break
		if(abort)
			break

	if(abort)
		atom_say("The space you have selected is not safe for landing. Please try again elsewhere.")
		qdel(port)
		shuttle_master.portable_beacon_count--
		icon_state = "shuttle"
		active = FALSE
		anchored = FALSE
	else
		shuttle_master.stationary += port
		for(var/obj/machinery/computer/shuttle/console in shuttle_master.consoles)
			if(console.shuttleId == shuttle_id)
				if(!console.possible_destinations)
					console.possible_destinations = port.id
				else
					console.possible_destinations += ";[port.id]"
		atom_say("Portable landing beacon successfully deployed!")
	for(var/obj/effect/overlay/O in scanner_overlays)
		qdel(O)

/obj/item/shuttle_beacon/verb/rotate()
	set name = "Rotate beacon"
	set category = "Object"
	setDir(turn(dir, 90))

/obj/item/shuttle_beacon/salvage
	shuttle_id = "salvage"
	zlevel = 6
