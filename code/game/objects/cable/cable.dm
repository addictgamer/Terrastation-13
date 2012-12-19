
/obj/cable
	level = 1
	anchored =1
	var/netnum = 0
	name = "power cable"
	desc = "A flexible superconducting cable for heavy-duty power transfer. Comes in clown colors now."
	icon = 'power_cond_red.dmi'
	icon_state = "0-1"
	var/d1 = 0
	var/d2 = 1
	layer = 2.5
	var/color="red"

/obj/cable/New()
	..()


	// ensure d1 & d2 reflect the icon_state for entering and exiting cable

	var/dash = findtext(icon_state, "-")

	d1 = text2num( copytext( icon_state, 1, dash ) )

	d2 = text2num( copytext( icon_state, dash+1 ) )

	var/turf/T = src.loc			// hide if turf is not intact

	if(level==1) hide(T.intact)


/obj/cable/Del()		// called when a cable is deleted

	if(!defer_powernet_rebuild)	// set if network will be rebuilt manually

		if(netnum && powernets && powernets.len >= netnum)		// make sure cable & powernet data is valid
			var/datum/powernet/PN = powernets[netnum]
			PN.cut_cable(src)									// updated the powernets
	else
		if(Debug) diary << "Defered cable deletion at [x],[y]: #[netnum]"
	..()													// then go ahead and delete the cable

/obj/cable/hide(var/i)

	if(level == 1 && istype(loc, /turf))
		invisibility = i ? 101 : 0
	updateicon()

/obj/cable/proc/updateicon()
	if(invisibility)
		icon_state = "[d1]-[d2]-f"
	else
		icon_state = "[d1]-[d2]"


// returns the powernet this cable belongs to
/obj/cable/proc/get_powernet()
	var/datum/powernet/PN			// find the powernet
	if(netnum && powernets && powernets.len >= netnum)
		PN = powernets[netnum]
	return PN

/obj/cable/attack_hand(mob/user)
	if(ishuman(user))
		if(istype(user:gloves, /obj/item/clothing/gloves/space_ninja)&&user:gloves:candrain&&!user:gloves:draining)
			call(/obj/item/clothing/gloves/space_ninja/proc/drain)("WIRE",src,user:wear_suit)
	return

/obj/cable/attackby(obj/item/W, mob/user)

	var/turf/T = src.loc
	if(T.intact)
		return

	if(istype(W, /obj/item/weapon/wirecutters))

		if (shock(user, 50))
			return

		if(src.d1)	// 0-X cables are 1 unit, X-X cables are 2 units long
			new/obj/item/weapon/cable_coil(T, 2, color)
		else
			new/obj/item/weapon/cable_coil(T, 1, color)

		for(var/mob/O in viewers(src, null))
			O.show_message("\red [user] cuts the cable.", 1)

		if(defer_powernet_rebuild)
			if(netnum && powernets && powernets.len >= netnum)
				var/datum/powernet/PN = powernets[netnum]
				PN.cut_cable(src)
		del(src)

		return	// not needed, but for clarity


	else if(istype(W, /obj/item/weapon/cable_coil))
		var/obj/item/weapon/cable_coil/coil = W
		coil.cable_join(src, user)

	else if(istype(W, /obj/item/device/multitool))

		var/datum/powernet/PN = get_powernet()		// find the powernet

		if(PN && (PN.avail > 0))		// is it powered?
			user << "\red [PN.avail]W in power network."

		else
			user << "\red The cable is not powered."

		shock(user, 5, 0.2)

	else
		if (W.flags & CONDUCT)
			shock(user, 50, 0.7)

	src.add_fingerprint(user)

// shock the user with probability prb

/obj/cable/proc/shock(mob/user, prb, var/siemens_coeff = 1.0)
	if(!prob(prb))
		return 0
	if (electrocute_mob(user, powernets[src.netnum], src, siemens_coeff))
		var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
		return 1
	else
		return 0

/obj/cable/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
		if(2.0)
			if (prob(50))
				new/obj/item/weapon/cable_coil(src.loc, src.d1 ? 2 : 1, color)
				del(src)

		if(3.0)
			if (prob(25))
				new/obj/item/weapon/cable_coil(src.loc, src.d1 ? 2 : 1, color)
				del(src)
	return

/obj/cable/proc/mergeConnectedNetworks(var/direction)
	var/turf/TB
	if((d1 == direction || d2 == direction) != 1)
		return
	TB = get_step(src, direction)

	for(var/obj/cable/TC in TB)

		if(!TC)
			continue

		if(src == TC)
			continue

		var/fdir = (!direction)? 0 : turn(direction, 180)

		if(TC.d1 == fdir || TC.d2 == fdir)

			if(!netnum)
				var/datum/powernet/PN = powernets[TC.netnum]
				netnum = TC.netnum
				PN = powernets[netnum]
				PN.cables += src
				continue

			if(TC.netnum != netnum)
				var/datum/powernet/PN = powernets[netnum]
				var/datum/powernet/TPN = powernets[TC.netnum]

				PN.merge_powernets(TPN)

/obj/cable/proc/mergeConnectedNetworksOnTurf()


	for(var/obj/cable/C in loc)


		if(!C)
			continue

		if(C == src)
			continue
		if(netnum == 0)
			var/datum/powernet/PN = powernets[C.netnum]
			netnum = C.netnum
			PN.cables += src
			continue

		var/datum/powernet/PN = powernets[netnum]
		var/datum/powernet/TPN = powernets[C.netnum]

		PN.merge_powernets(TPN)

	for(var/obj/machinery/power/M in loc)

		if(!M)
			continue

		if(!M.netnum)
			var/datum/powernet/PN = powernets[netnum]
			PN.nodes += M
			M.netnum = netnum
			M.powernet = powernets[M.netnum]

		if(M.netnum < 0)
			continue

		var/datum/powernet/PN = powernets[netnum]
		var/datum/powernet/TPN = powernets[M.netnum]

		PN.merge_powernets(TPN)

	for(var/obj/machinery/power/apc/N in loc)

		if(!N)
			continue

		var/obj/machinery/power/M
		M = N.terminal

		if(M.netnum == 0)
			if(netnum == 0)
				continue
			var/datum/powernet/PN = powernets[netnum]
			PN.nodes += M
			M.netnum = netnum
			M.powernet = powernets[M.netnum]
			continue

		var/datum/powernet/PN = powernets[netnum]
		var/datum/powernet/TPN = powernets[M.netnum]

		PN.merge_powernets(TPN)

/obj/cable/proc/get_connections()

	var/list/res = list()	// this will be a list of all connected power objects

	var/turf/T
	if(!d1)
		T = src.loc		// if d1=0, same turf as src
	else
		T = get_step(src, d1)

	res += power_list(T, src , d1, 1)

	T = get_step(src, d2)

	res += power_list(T, src, d2, 1)

	return res

/obj/cable/proc/cableColor(var/colorC)
	var/color_n = "red"
	if(colorC)
		color_n = colorC
	color = color_n
	switch(colorC)
		if("red")
			icon = 'power_cond_red.dmi'
		if("yellow")
			icon = 'power_cond_yellow.dmi'
		if("green")
			icon = 'power_cond_green.dmi'
		if("blue")
			icon = 'power_cond_blue.dmi'
