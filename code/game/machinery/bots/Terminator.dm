// Mulebot - carries crates around for Quartermaster
// Navigates via floor navbeacons
// Remote Controlled from QM's PDA


/obj/machinery/bot/terminator
	name = "Terminator"
	desc = "Death and Destruction."
	icon_state = "mulebot0" //TODO: Correct this.
	layer = MOB_LAYER
	density = 1
	anchored = 1
	animate_movement=1
	health = 300
	maxhealth = 300
	fire_dam_coeff = 0.7
	brute_dam_coeff = 0.5
	var/locked = 1

	var/control_freq = 1447

	suffix = ""

	var/turf/target				//This is turf to navigate to.
	var/thought = "idle"		//What it's currently thinking.
	//req_access = list(access_cargo, access_cargo_bot)
	var/mob/target_mob			//The mob it's supposed to kill.
	var/path[] = new()

	var/mode = 0		//0 = idle/ready

	var/blockcount	= 0		//number of times retried a blocked path
	var/reached_target = 1 	//true if already reached the target

	var/refresh = 1		// true to refresh dialogue

	var/open = 0		// true if maint hatch is open
	var/obj/item/weapon/cell/cell
						// the installed power cell

	// constants for internal wiring bitflags
	var/const
		wire_power1 = 1			// power connections
		wire_power2 = 2
		wire_motor1 = 4		// motor wires
		wire_motor2 = 8		//
		wire_remote_rx = 16		// remote recv functions
		wire_remote_tx = 32	// remote trans status

	var/wires = 1023		// all flags on

	var/list/wire_text	// list of wire colours
	var/list/wire_order	// order of wire indices


	var/bloodiness = 0		// count of bloodiness

/obj/machinery/bot/terminator/New()
	..()
	req_access = get_all_accesses()
	botcard = new(src)
	botcard.access = get_all_accesses() //get_access("Quartermaster")
	botcard.access += access_robotics
	cell = new(src)
	cell.charge = 20000
	cell.maxcharge = 20000
	setup_wires()

	spawn(5)	// must wait for map loading to finish
		if(radio_controller)
			radio_controller.add_object(src, control_freq, filter = RADIO_TERMINATOR)

		var/count = 0
		for(var/obj/machinery/bot/terminator/other in world)
			count++
		if(!suffix)
			suffix = "#[count]"
		name = "Terminator ([suffix])"

	verbs -= /atom/movable/verb/pull


// set up the wire colours in random order
// and the random wire display order
// needs 10 wire colours
/obj/machinery/bot/terminator/proc/setup_wires()
	var/list/colours = list("Red", "Green", "Blue", "Magenta", "Cyan", "Yellow")
	var/list/orders = list("0","1","2","3","4","5")
	wire_text = list()
	wire_order = list()
	while(colours.len > 0)
		var/colour = colours[ rand(1,colours.len) ]
		wire_text += colour
		colours -= colour

		var/order = orders[ rand(1,orders.len) ]
		wire_order += text2num(order)
		orders -= order



// attack by item
// emag : lock/unlock,
// screwdriver: open/close hatch
// cell: insert it
/obj/machinery/bot/terminator/attackby(var/obj/item/I, var/mob/user)
	if(istype(I,/obj/item/weapon/card/emag))
		locked = !locked
		user << "\blue You [locked ? "lock" : "unlock"] the terminator's controls!"
		flick("mulebot-emagged", src) //TODO: Correct this.
		playsound(src.loc, 'sparks1.ogg', 100, 0)
	else if(istype(I,/obj/item/weapon/cell) && open && !cell)
		var/obj/item/weapon/cell/C = I
		user.drop_item()
		C.loc = src
		cell = C
		updateDialog()
	else if(istype(I,/obj/item/weapon/screwdriver))
		if(locked)
			user << "\blue The maintenance hatch cannot be opened or closed while the controls are locked."
			return

		open = !open
		if(open)
			src.visible_message("[user] opens the maintenance hatch of [src]", "\blue You open [src]'s maintenance hatch.")
			on = 0
			icon_state="mulebot-hatch" //TODO: Correct this.
		else
			src.visible_message("[user] closes the maintenance hatch of [src]", "\blue You close [src]'s maintenance hatch.")
			icon_state = "mulebot0" //TODO: Correct this.

		updateDialog()
	else if (istype(I, /obj/item/weapon/wrench))
		if (src.health < maxhealth)
			src.health = min(maxhealth, src.health+25)
			user.visible_message(
				"\red [user] repairs [src]!",
				"\blue You repair [src]!"
			)
		else
			user << "\blue [src] does not need a repair!"
	else
		..()
	return


/obj/machinery/bot/terminator/ex_act(var/severity)
	switch(severity)
		if(2)
			wires &= ~(1 << rand(0,9))
			wires &= ~(1 << rand(0,9))
			wires &= ~(1 << rand(0,9))
		if(3)
			wires &= ~(1 << rand(0,9))
	..()
	return

/obj/machinery/bot/terminator/bullet_act() //TODO: Update this.
	if(prob(50) && !isnull(load))
		load.bullet_act()
		unload(0)
	if(prob(25))
		src.visible_message("\red Something shorts out inside [src]!")
		var/index = 1<< (rand(0,9))
		if(wires & index)
			wires &= ~index
		else
			wires |= index
	..()


/obj/machinery/bot/terminator/attack_ai(var/mob/user)
	user.machine = src
	interact(user, 1)

/obj/machinery/bot/terminator/attack_hand(var/mob/user)
	. = ..()
	if (.)
		return
	user.machine = src
	interact(user, 0)

/obj/machinery/bot/terminator/proc/interact(var/mob/user, var/ai=0)
	var/dat
	dat += "<TT><B>Terminator Mk. I</B></TT><BR><BR>"
	dat += "ID: [suffix]<BR>"
	dat += "Power: [on ? "On" : "Off"]<BR>"

	if(!open)

		dat += "Status: "
		switch(mode)
			if(0)
				dat += "Idle/No orders"

		dat += "Destination: [!destination ? "<i>none</i>" : destination]<BR>"
		//if(!target_mob)
		//	dat += "No kill target.<BR>"
		//else
		//	dat += "Kill target: []"
			dat += "Kill target: [!target_mob ? "<i>none</i>" : target_mob]<BR>"
		dat += "Power level: [cell ? cell.percent() : 0]%<BR>"

		if(locked && !ai)
			dat += "<HR>Controls are locked <A href='byond://?src=\ref[src];op=unlock'><I>(unlock)</I></A>"
		else
			dat += "<HR>Controls are unlocked <A href='byond://?src=\ref[src];op=lock'><I>(lock)</I></A><BR><BR>"

			dat += "<A href='byond://?src=\ref[src];op=power'>Toggle Power</A><BR>"
			dat += "<A href='byond://?src=\ref[src];op=stop'>Stop</A><BR>"
			dat += "<A href='byond://?src=\ref[src];op=go'>Proceed</A><BR>"
			dat += "<A href='byond://?src=\ref[src];op=destination'>Set Destination</A><BR>"
			dat += "<A href='byond://?src=\ref[src];op=target_mob'>Set kill target</A><BR>"
			dat += "<A href='byond://?src=\ref[src];op=setid'>Set Bot ID</A><BR>"

			dat += "<HR>The maintenance hatch is closed.<BR>"

	else
		if(!ai)
			dat += "The maintenance hatch is open.<BR><BR>"
			dat += "Power cell: "
			if(cell)
				dat += "<A href='byond://?src=\ref[src];op=cellremove'>Installed</A><BR>"
			else
				dat += "<A href='byond://?src=\ref[src];op=cellinsert'>Removed</A><BR>"

			dat += wires()
		else
			dat += "The bot is in maintenance mode and cannot be controlled.<BR>"

	user << browse("<HEAD><TITLE>Terminator [suffix ? "([suffix])" : ""]</TITLE></HEAD>[dat]", "window=terminator;size=350x500")
	onclose(user, "mulebot") //TODO: Correct this.
	return

// returns the wire panel text
/obj/machinery/bot/terminator/proc/wires()
	var/t = ""
	for(var/i = 0 to 9)
		var/index = 1<<wire_order[i+1]
		t += "[wire_text[i+1]] wire: "
		if(index & wires)
			t += "<A href='byond://?src=\ref[src];op=wirecut;wire=[index]'>(cut)</A> <A href='byond://?src=\ref[src];op=wirepulse;wire=[index]'>(pulse)</A><BR>"
		else
			t += "<A href='byond://?src=\ref[src];op=wiremend;wire=[index]'>(mend)</A><BR>"

	return t




/obj/machinery/bot/terminator/Topic(href, href_list)
	if(..())
		return
	if (usr.stat)
		return
	if ((in_range(src, usr) && istype(src.loc, /turf)) || (istype(usr, /mob/living/silicon)))
		usr.machine = src

		switch(href_list["op"])
			if("lock", "unlock")
				if(src.allowed(usr))
					locked = !locked
					updateDialog()
				else
					usr << "\red Access denied."
					return
			if("power")
				if (src.on)
					turn_off()
				else if (cell && !open)
					if (!turn_on())
						usr << "\red You can't switch on [src]."
						return
				else
					return
				usr << "You switch [on ? "on" : "off"] [src]."
				for(var/mob/M in viewers(src))
					if(M==usr) continue
					M << "[usr] switches [on ? "on" : "off"] [src]."
				updateDialog()


			if("cellremove")
				if(open && cell && !usr.equipped())
					cell.loc = usr
					cell.layer = 20
					if(usr.hand)
						usr.l_hand = cell
					else
						usr.r_hand = cell

					cell.add_fingerprint(usr)
					cell.updateicon()
					cell = null

					usr.visible_message("\blue [usr] removes the power cell from [src].", "\blue You remove the power cell from [src].")
					updateDialog()

			if("cellinsert")
				if(open && !cell)
					var/obj/item/weapon/cell/C = usr.equipped()
					if(istype(C))
						usr.drop_item()
						cell = C
						C.loc = src
						C.add_fingerprint(usr)

						usr.visible_message("\blue [usr] inserts a power cell into [src].", "\blue You insert the power cell into [src].")
						updateDialog()


			if("stop")
				if(mode >=2)
					mode = 0
					updateDialog()

			if("go")
				if(mode == 0)
					start()
					updateDialog()

			if("destination")
				refresh=0
				var/new_dest = input("Enter new destination tag", "Mulebot [suffix ? "([suffix])" : ""]", destination) as text|null
				refresh=1
				if(new_dest)
					set_destination(new_dest)


			if("setid")
				refresh=0
				var/new_id = input("Enter new bot ID", "Terminator [suffix ? "([suffix])" : ""]", suffix) as text|null
				refresh=1
				if(new_id)
					suffix = new_id
					name = "Terminator ([suffix])"
					updateDialog()

			if("close")
				usr.machine = null
				usr << browse(null,"window=terminator")


			if("wirecut")
				if(istype(usr.equipped(), /obj/item/weapon/wirecutters))
					var/wirebit = text2num(href_list["wire"])
					wires &= ~wirebit
				else
					usr << "\blue You need wirecutters!"
			if("wiremend")
				if(istype(usr.equipped(), /obj/item/weapon/wirecutters))
					var/wirebit = text2num(href_list["wire"])
					wires |= wirebit
				else
					usr << "\blue You need wirecutters!"

			if("wirepulse")
				if(istype(usr.equipped(), /obj/item/device/multitool))
					switch(href_list["wire"])
						if("1","2")
							usr << "\blue \icon[src] The charge light flickers."
						if("4", "8")
							usr << "\blue \icon[src] The drive motor whines briefly."
						else
							usr << "\blue \icon[src] You hear a radio crackle."
				else
					usr << "\blue You need a multitool!"



		updateDialog()
		//src.updateUsrDialog()
	else
		usr << browse(null, "window=terminator")
		usr.machine = null
	return



// returns true if the bot has power
/obj/machinery/bot/terminator/proc/has_power()
	return !open && cell && cell.charge>0 && (wires & wire_power1) && (wires & wire_power2)

//If an object is mouse dragged onto the bot.
/obj/machinery/bot/terminator/MouseDrop_T(var/atom/movable/C, mob/user)

	if(user.stat)
		return

	if (!on || !istype(C)|| C.anchored || get_dist(user, src) > 1 || get_dist(src,C) > 1 )
		return


/obj/machinery/bot/terminator/process()
	if(!has_power())
		on = 0
		return
	if(on)
		var/speed = ((wires & wire_motor1) ? 1:0) + ((wires & wire_motor2) ? 2:0)
		//world << "speed: [speed]"
		switch(speed)
			if(0)
				// do nothing
			if(1)
				process_bot()
				spawn(3)
					process_bot()
					sleep(3)
					process_bot()
			if(2)
				process_bot()
				spawn(5)
					process_bot()
			if(3)
				process_bot()

	if(refresh) updateDialog()

/obj/machinery/bot/terminator/proc/process_bot()
	//if(mode) world << "Mode: [mode]"
	switch(mode)
		if(0)		// idle
			icon_state = "mulebot0" //TODO: Correct this.
			return
	return


// calculates a path to the current destination
// given an optional turf to avoid
/obj/machinery/bot/terminator/proc/calc_path(var/turf/avoid = null)
	src.path = AStar(src.loc, src.target, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, id=botcard, exclude=avoid)
	src.path = reverselist(src.path)

// called when bot bumps into anything
/obj/machinery/bot/terminator/Bump(var/atom/obs)
	if(!(wires))		//usually just bumps, but if avoidance disabled knock over mobs
		var/mob/M = obs
		if(ismob(M))
			if(istype(M,/mob/living/silicon/robot))
				src.visible_message("\red [src] bumps into [M]!")
			else
				src.visible_message("\red [src] knocks over [M]!")
				M.pulling = null
				M.stunned = 8
				M.weakened = 5
				M.lying = 1
	..()

/obj/machinery/bot/terminator/alter_health()
	return get_turf(src)


// called from mob/living/carbon/human/HasEntered()
// when terminator is in the same loc
/obj/machinery/bot/terminator/proc/RunOver(var/mob/living/carbon/human/H)
	src.visible_message("\red [src] drives over [H]!")
	playsound(src.loc, 'splat.ogg', 50, 1)

	/*
	if(ismob(load))
		var/mob/M = load
		if(M.reagents.has_reagent("beer"))
			M.unlock_medal("DUI", 1)
		if(M.reagents.has_reagent("space_drugs") && istype(H) && H.wear_id.assignment == "Security Officer")
			M.unlock_medel("Ridin' Dirty",1)
	*/

	var/damage = rand(5,15)

	H.TakeDamage("head", 2*damage, 0)
	H.TakeDamage("chest",2*damage, 0)
	H.TakeDamage("l_leg",0.5*damage, 0)
	H.TakeDamage("r_leg",0.5*damage, 0)
	H.TakeDamage("l_arm",0.5*damage, 0)
	H.TakeDamage("r_arm",0.5*damage, 0)

	var/obj/decal/cleanable/blood/B = new(src.loc)
	B.blood_DNA = H.dna.unique_enzymes
	B.blood_type = H.b_type

	bloodiness += 4

// receive a radio signal
// used for control
/obj/machinery/bot/terminator/receive_signal(datum/signal/signal)

	if(!on)
		return

	/*
	world << "rec signal: [signal.source]"
	for(var/x in signal.data)
		world << "* [x] = [signal.data[x]]"
	*/
	var/recv = signal.data["command"]
	// process all-bot input
	if(recv=="bot_status" && (wires & wire_remote_rx))
		send_status()


	recv = signal.data["command [suffix]"]
	if(wires & wire_remote_rx)
		// process control input
		switch(recv)
			if("stop")
				mode = 0
				return

			if("go")
				start()
				return

			if("target")
				set_destination(signal.data["destination"] )
				return

			if("bot_status")
				send_status()
				return

// send a radio signal with a single data key/value pair
/obj/machinery/bot/terminator/proc/post_signal(var/freq, var/key, var/value)
	post_signal_multiple(freq, list("[key]" = value) )

// send a radio signal with multiple data key/values
/obj/machinery/bot/terminator/proc/post_signal_multiple(var/freq, var/list/keyval)

	if(freq == control_freq && !(wires & wire_remote_tx))
		return

	var/datum/radio_frequency/frequency = radio_controller.return_frequency(freq)

	if(!frequency) return



	var/datum/signal/signal = new()
	signal.source = src
	signal.transmission_method = 1
	//for(var/key in keyval)
	//	signal.data[key] = keyval[key]
	signal.data = keyval
		//world << "sent [key],[keyval[key]] on [freq]"
	if (signal.data["findbeacon"])
		frequency.post_signal(src, signal, filter = RADIO_NAVBEACONS)
	else if (signal.data["type"] == "mulebot")
		frequency.post_signal(src, signal, filter = RADIO_MULEBOT)
	else
		frequency.post_signal(src, signal)

// signals bot status etc. to controller
/obj/machinery/bot/terminator/proc/send_status()
	var/list/kv = list(
		"type" = "terminator",
		"name" = suffix,
		"loca" = loc.loc,	// area
		"mode" = mode,
		"powr" = (cell ? cell.percent() : 0),
		"dest" = destination,
	)
	post_signal_multiple(control_freq, kv)

/obj/machinery/bot/terminator/emp_act(severity)
	if (cell)
		cell.emp_act(severity)
	..()


/obj/machinery/bot/terminator/explode()
	src.visible_message("\red <B>[src] blows apart!</B>", 1)
	var/turf/Tsec = get_turf(src)

	new /obj/item/device/prox_sensor(Tsec)
	new /obj/item/stack/rods(Tsec)
	new /obj/item/stack/rods(Tsec)
	new /obj/item/weapon/cable_coil/cut(Tsec)
	if (cell)
		cell.loc = Tsec
		cell.update_icon()
		cell = null

	var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	new /obj/decal/cleanable/oil(src.loc)
	unload(0)
	del(src)