
/obj/machinery/door_control
	name = "Remote Door Control"
	desc = "This controls doors."
	icon = 'stationobjs.dmi'
	icon_state = "doorctrl0"
	desc = "A remote control switch for a door."
	var/id = null
	anchored = 1.0
	use_power = 1
	idle_power_usage = 2
	active_power_usage = 4

/obj/machinery/door_control/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door_control/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door_control/attackby(obj/item/weapon/W, mob/user as mob)
	if (istype(W, /obj/item/device/detective_scanner))
		return
	return src.attack_hand(user)

/obj/machinery/door_control/attack_hand(mob/user as mob)
	if (stat & (NOPOWER|BROKEN))
		return
	use_power(5)
	icon_state = "doorctrl1"

	for(var/obj/machinery/door/poddoor/M in machines)
		if (M.id == src.id)
			if (M.density)
				spawn( 0 )
					M.open()
					return
			else
				spawn( 0 )
					M.close()
					return

	spawn(15)
		if (!(stat & NOPOWER))
			icon_state = "doorctrl0"
	src.add_fingerprint(usr)

/obj/machinery/door_control/power_change()
	..()
	if (stat & NOPOWER)
		icon_state = "doorctrl-p"
	else
		icon_state = "doorctrl0"
