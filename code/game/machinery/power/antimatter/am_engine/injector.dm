
/obj/machinery/power/am_engine/injector
	name = "Injector"
	icon_state = "injector"
	var/engine_id = 0
	var/injecting = 0
	var/fuel = 0
	var/obj/machinery/power/am_engine/engine/connected = null

/obj/machinery/power/am_engine/injector/New()
	..()
	spawn( 13 )
		var/loc = get_step(src, NORTH)
		src.connected = locate(/obj/machinery/power/am_engine/engine, get_step(loc, NORTH))
		return
	return

/obj/machinery/power/am_engine/injector/attackby(obj/item/weapon/fuel/F, mob/user)
	if ( (stat & BROKEN) || !connected) return

	if (istype(F, /obj/item/weapon/fuel/H))
		if (injecting)
			user << "Theres already a fuel rod in the injector!"
			return
		user << "You insert the rod into the injector"
		injecting = 1
		var/fuel = F.fuel
		del(F)
		spawn( 300 )
			injecting = 0
			new/obj/item/weapon/fuel(src.loc)
			connected.H_fuel += fuel

	if (istype(F, /obj/item/weapon/fuel/antiH))
		if (injecting)
			user << "Theres already a fuel rod in the injector!"
			return
		user << "You insert the rod into the injector"
		injecting = 1
		var/fuel = F.fuel
		del(F)
		spawn( 300 )
			injecting = 0
			new /obj/item/weapon/fuel(src.loc)
			connected.antiH_fuel += fuel
	return
