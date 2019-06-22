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

#define BEACON_INACTIVE		0
#define BEACON_SCANNING		1
#define BEACON_TRANSITIONAL	2
#define	BEACON_ACTIVE		3

//Added by Quisoves Pugnat
/obj/item/shuttle_beacon
	dir = NORTH
	name = "portable landing beacon"
	desc = "ScataLogic proudly presents the latest in bluespace docking-techonology!\nJust deploy it in a sufficiently open space, and let the state-of-the-art scanner do the rest!"
	icon = 'icons/obj/beacons.dmi'
	icon_state = "shuttle"
	atom_say_verb = "chirps"
	origin_tech = "bluespace=3"
	var/status = 0
	var/shuttle_id = ""
	var/zlevel = 0	//If set, restricts the beacon's activation to a given z-level.
	var/turf/turf_type = /turf/space
	var/area/area_type = /area/space
	var/obj/docking_port/mobile/parent
	var/obj/docking_port/stationary/port
	var/serial
	var/abort_message = "The space you have selected is not safe for landing. Please try again elsewhere."
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
		atom_say("Sector unmmapped: Please try again elsewhere.")
		return
	var/turf/T = get_step(src, dir)
	var/list/L = parent.return_coords(T.x, T.y, dir)
	if(L[1] <= (TRANSITION_BORDER_WEST + 1) || L[2] <= (TRANSITION_BORDER_SOUTH + 1) || L[3] >= (TRANSITION_BORDER_EAST - 1) || L[4] >= (TRANSITION_BORDER_NORTH - 1))
		atom_say("Insufficient distance from sector edge: Please try again elsewhere.")
		return
	var/port_name = input(user, "Label this location:", "Beacon Configuration", null)  as text
	if(!port_name)
		port_name = "Portable landing beacon #[serial]"
	user.drop_item()
	scan(user, port_name)

/obj/item/shuttle_beacon/proc/scan(mob/user, port_name)
	set waitfor = FALSE
	anchored = TRUE
	status = BEACON_SCANNING
	icon_state = "shuttle_active"
	atom_say("Scanning... Please stand by...")
	port = new /obj/docking_port/stationary(get_step(src, dir))
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
	for(var/turf/T in shuttle_turfs)
		sleep(5)
		var/obj/effect/overlay/O = new /obj/effect/overlay(T)
		O.icon = 'icons/effects/effects.dmi'
		O.icon_state = "ion_fade"
		O.mouse_opacity = 0
		scanner_overlays += O
		if(T.type != turf_type || (get_area(T)).type != area_type)
			status = BEACON_INACTIVE
			break
//This trio of iterations is perhaps less than ideal, but it should minimize lag and will suffice until I streamline density checks.
		for(var/obj/structure/blargh in T)
			if(blargh.density)
				status = BEACON_INACTIVE
				break
		if(!status)
			break
		for(var/obj/machinery/blargh in T)
			if(blargh.density)
				status = BEACON_INACTIVE
				break
		if(!status)
			break

		for(var/obj/spacepod/blargh in T)
			if(blargh.density)
				status = BEACON_INACTIVE
				break
		if(!status)
			break

	if(!status)
		atom_say(abort_message)
		abort_message = "The space you have selected is not safe for landing. Please try again elsewhere."
		qdel(port)
		port = null
		shuttle_master.portable_beacon_count--
		icon_state = "shuttle"
		status = BEACON_INACTIVE
		anchored = FALSE
	else
		status = BEACON_TRANSITIONAL	//Parnoid? Moi?
		shuttle_master.stationary += port
		for(var/obj/machinery/computer/shuttle/console in shuttle_master.consoles)
			if(console.shuttleId == shuttle_id)
				if(!console.possible_destinations)
					console.possible_destinations = port.id
				else
					console.possible_destinations += ";[port.id]"
		atom_say("Portable landing beacon successfully deployed!")
		status = BEACON_ACTIVE
	for(var/obj/effect/overlay/O in scanner_overlays)
		qdel(O)


/obj/item/shuttle_beacon/attack_hand(mob/user as mob)
	var/response
	if(!status)
		..()
	else if(status == BEACON_SCANNING)
		response = alert(user, "Do you want to interrupt this scan?","Scan in Progress","No","Yes")
		if(response == "Yes" && status == BEACON_SCANNING)
			qdel(port)
			shuttle_master.portable_beacon_count--
			icon_state = "shuttle"
			anchored = FALSE
			abort_message = "Scan aborted."
			status = BEACON_INACTIVE
			..()
			return

	else if(status == BEACON_ACTIVE)
		response = alert(user, "Deactivate beacon?","ScataLogic PLB MK I","No","Yes")
		if(response == "Yes")
			shuttle_master.portable_beacon_count--
			icon_state = "shuttle"
			anchored = FALSE
			status = BEACON_INACTIVE
			for(var/obj/machinery/computer/shuttle/console in shuttle_master.consoles)
				if(console.shuttleId == shuttle_id)
					console.possible_destinations = replacetext(console.possible_destinations, port.id, "")
					console.possible_destinations = replacetext(console.possible_destinations, ";;", "")

			shuttle_master.stationary -= port
			qdel(port)
			atom_say("Beacon deactivated")
			..()
			return

	else
		return
/obj/item/shuttle_beacon/verb/rotate()
	set name = "Rotate beacon"
	set category = "Object"
	setDir(turn(dir, 90))

/obj/item/shuttle_beacon/salvage
	shuttle_id = "salvage"
	zlevel = 6
