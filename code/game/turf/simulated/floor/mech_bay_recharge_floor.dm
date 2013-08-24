
/turf/simulated/floor/mech_bay_recharge_floor
	name = "Mech Bay Recharge Station"
	icon = 'mech_bay.dmi'
	icon_state = "recharge_floor"
	var/obj/machinery/mech_bay_recharge_port/recharge_port
	var/obj/machinery/computer/mech_bay_power_console/recharge_console
	var/obj/mecha/recharging_mecha = null

	Entered(var/obj/mecha/mecha)
		. = ..()
		if (istype(mecha))
			mecha.occupant_message("<b>Initializing power control devices.</b>")
			init_devices()
			if (recharge_console && recharge_port)
				recharging_mecha = mecha
				recharge_console.mecha_in(mecha)
				return
			else if (!recharge_console)
				mecha.occupant_message("<font color='red'>Control console not found. Terminating.</font>")
			else if (!recharge_port)
				mecha.occupant_message("<font color='red'>Power port not found. Terminating.</font>")
		return

	Exited(atom)
		. = ..()
		if (atom == recharging_mecha)
			recharging_mecha = null
			if (recharge_console)
				recharge_console.mecha_out()
		return

	proc/init_devices()
		recharge_console = locate() in range(1,src)
		recharge_port = locate(/obj/machinery/mech_bay_recharge_port, get_step(src, WEST))
		if (recharge_console)
			recharge_console.recharge_floor = src
			if (recharge_port)
				recharge_console.recharge_port = recharge_port
		if (recharge_port)
			recharge_port.recharge_floor = src
			if (recharge_console)
				recharge_port.recharge_console = recharge_console
		return
