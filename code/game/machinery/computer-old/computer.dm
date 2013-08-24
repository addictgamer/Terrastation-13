
/obj/machinery/computer
	name = "computer"
	icon = 'computer.dmi'
	density = 1
	anchored = 1.0
	var/obj/item/weapon/circuitboard/circuit = null //if circuit==null, computer can't disassemble
	var/list/tracked =	list(  )

/obj/machinery/computer/New()
	..()
	spawn(2)
		power_change()

/obj/machinery/computer/attack_ai(mob/user)
	attack_hand(user)
	interact(user)


/obj/machinery/computer/attack_hand(mob/user)
	add_fingerprint(user)
	if (stat & (BROKEN|NOPOWER))
		return
	interact(user)


/obj/machinery/computer/process()
	return


/obj/machinery/computer/power_change()
	if (stat & BROKEN)
		icon_state = "broken"
	else
		if ( powered() )
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
		else
			spawn(rand(0, 15))
				src.icon_state = "c_unpowered"
				stat |= NOPOWER


/obj/machinery/computer/Topic(href, href_list)
	..()
	if ( href_list["close"] )
		usr << browse(null, "window=crewcomp")
		usr.machine = null
		return
	if (href_list["update"])
		src.updateDialog()
		return

/obj/machinery/computer/proc/interact(mob/user)
	if ( (get_dist(src, user) > 1 ) || (stat & (BROKEN|NOPOWER)) )
		if (!istype(user, /mob/living/silicon))
			user.machine = null
			user << browse(null, "window=powcomp")
			return
	user.machine = src
	src.scan()
	var/t = "<TT><B>Crew Monitoring</B><HR>"
	t += "<BR><A href='?src=\ref[src];update=1'>Refresh</A>"
	t += "<BR><A href='?src=\ref[src];close=1'>Close</A>"
	t += "<table><tr><td>Name</td><td>Vitals</td><td>Position</td></tr>"
	for(var/obj/item/clothing/under/C in src.tracked)
		if ((C) && (C.has_sensor) && (C.loc) && (C.loc.z == 1))
			if (istype(C.loc, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = C.loc
				var/dam1 = round(H.oxyloss,1)
				var/dam2 = round(H.toxloss,1)
				var/dam3 = round(H.fireloss,1)
				var/dam4 = round(H.bruteloss,1)
				switch(C.sensor_mode)
					if (1)
						if (H.wear_id)
							t += "<tr><td>[H.wear_id.name]</td><td>"
						else
							t += "<tr><td>Unknown:</td><td>"
						t+= "[H.stat > 1 ? "<font color=red>Deceased</font>" : "Living"]</td><td>Not Available</td></tr>"
					if (2)
						if (H.wear_id)
							t += "<tr><td>[H.wear_id.name]</td><td>"
						else
							t += "<tr><td>Unknown:</td><td>"
						t += "[H.stat > 1 ? "<font color=red>Deceased</font>" : "Living"], [dam1] - [dam2] - [dam3] - [dam4]</td><td>Not Available</td></tr>"
					if (3)
						t += "<tr><td>[H.name]</td><td>[H.stat > 1 ? "<font color=red>Deceased</font>" : "Living"], [dam2] - [dam2] - [dam3] - [dam4]</td><td>[get_area(H)] ([H.x], [H.y])</td></tr>"
	t += "</table>"
	t += "</FONT></PRE></TT>"
	user << browse(t, "window=crewcomp;size=500x800")
	onclose(user, "crewcomp")

/obj/machinery/computer/proc/scan()
	for(var/obj/item/clothing/under/C in world)
		if ((C.has_sensor) && (istype(C.loc, /mob/living/carbon/human)))
			var/check = 0
			for(var/O in src.tracked)
				if (O == C)
					check = 1
					break
			if (!check)
				src.tracked.Add(C)
	return 1

/obj/machinery/computer/meteorhit(var/obj/O as obj)
	for(var/x in verbs)
		verbs -= x
	set_broken()
	var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
	smoke.set_up(5, 0, src)
	smoke.start()
	return

/obj/machinery/computer/emp_act(severity)
	if (prob(20/severity)) set_broken()
	..()

/obj/machinery/computer/ex_act(severity)
	switch(severity)
		if (1.0)
			del(src)
			return
		if (2.0)
			if (prob(25))
				del(src)
				return
			if (prob(50))
				for(var/x in verbs)
					verbs -= x
				set_broken()
		if (3.0)
			if (prob(25))
				for(var/x in verbs)
					verbs -= x
				set_broken()
		else
	return

/obj/machinery/computer/blob_act()
	if (prob(75))
		for(var/x in verbs)
			verbs -= x
		set_broken()
		density = 0

/obj/machinery/computer/power_change()
	if (!istype(src,/obj/machinery/computer/security/telescreen))
		if (stat & BROKEN)
			icon_state = initial(icon_state)
			icon_state += "b"
			if (istype(src,/obj/machinery/computer/aifixer))
				overlays = null

		else if (powered())
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
			if (istype(src,/obj/machinery/computer/aifixer))
				var/obj/machinery/computer/aifixer/O = src
				if (O.occupant)
					switch (O.occupant.stat)
						if (0)
							overlays += image('computer.dmi', "ai-fixer-full")
						if (2)
							overlays += image('computer.dmi', "ai-fixer-404")
				else
					overlays += image('computer.dmi', "ai-fixer-empty")
		else
			spawn(rand(0, 15))
				//icon_state = "c_unpowered"
				icon_state = initial(icon_state)
				icon_state += "0"
				stat |= NOPOWER
				if (istype(src,/obj/machinery/computer/aifixer))
					overlays = null

/obj/machinery/computer/process()
	if (stat & (NOPOWER|BROKEN))
		return
	use_power(250)

/obj/machinery/computer/proc/set_broken()
	icon_state = initial(icon_state)
	icon_state += "b"
	stat |= BROKEN

/obj/machinery/computer/attackby(I as obj, user as mob)
	if (istype(I, /obj/item/weapon/screwdriver) && circuit)
		playsound(src.loc, 'Screwdriver.ogg', 50, 1)
		if (do_after(user, 20))
			var/obj/computerframe/A = new /obj/computerframe( src.loc )
			var/obj/item/weapon/circuitboard/M = new circuit( A )
			A.circuit = M
			A.anchored = 1
			for (var/obj/C in src)
				C.loc = src.loc
			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				new /obj/item/weapon/shard( src.loc )
				A.state = 3
				A.icon_state = "3"
			else
				user << "\blue You disconnect the monitor."
				A.state = 4
				A.icon_state = "4"
			del(src)
	else
		src.attack_hand(user)
	return

/*
/obj/machinery/computer/airtunnel
	name = "Air Tunnel Control"
	icon = 'airtunnelcomputer.dmi'
	icon_state = "console00"
*/

/*
/obj/machinery/computer/scan_consolenew    //Coming Soon
	name = "DNA Modifier Access Console"
	desc = "Scand DNA."
	icon = 'computer.dmi'
	icon_state = "scanner"
	density = 1
	var/uniblock = 1.0
	var/strucblock = 1.0
	var/subblock = 1.0
	var/status = null
	var/radduration = 2.0
	var/radstrength = 1.0
	var/radacc = 1.0
	var/buffer1 = null
	var/buffer2 = null
	var/buffer3 = null
	var/buffer1owner = null
	var/buffer2owner = null
	var/buffer3owner = null
	var/buffer1label = null
	var/buffer2label = null
	var/buffer3label = null
	var/buffer1type = null
	var/buffer2type = null
	var/buffer3type = null
	var/buffer1iue = 0
	var/buffer2iue = 0
	var/buffer3iue = 0
	var/delete = 0
	var/injectorready = 1
	var/temphtml = null
	var/obj/machinery/dna_scanner/connected = null
	var/obj/item/weapon/disk/data/diskette = null
	anchored = 1.0
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 400
*/
