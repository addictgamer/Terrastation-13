
/obj/machinery/mech_bay_recharge_port
	name = "Mech Bay Power Port"
	density = 1
	anchored = 1
	icon = 'mech_bay.dmi'
	icon_state = "recharge_port"
	var/turf/simulated/floor/mech_bay_recharge_floor/recharge_floor
	var/obj/machinery/computer/mech_bay_power_console/recharge_console
	var/datum/global_iterator/mech_bay_recharger/pr_recharger

	New()
		..()
		pr_recharger = new /datum/global_iterator/mech_bay_recharger(null,0)
		return

	proc/start_charge(var/obj/mecha/recharging_mecha)
		if (stat&(NOPOWER|BROKEN))
			recharging_mecha.occupant_message("<font color='red'>Power port not responding. Terminating.</font>")
			return 0
		else
			if (recharging_mecha.cell)
				recharging_mecha.occupant_message("Now charging...")
				pr_recharger.start(list(src,recharging_mecha))
				return 1
			else
				return 0

	proc/stop_charge()
		if (recharge_console && !recharge_console.stat)
			recharge_console.icon_state = initial(recharge_console.icon_state)
		pr_recharger.stop()
		return

	proc/active()
		if (pr_recharger.active())
			return 1
		else
			return 0

	power_change()
		if (powered())
			stat &= ~NOPOWER
		else
			spawn(rand(0, 15))
				stat |= NOPOWER
				pr_recharger.stop()
		return

	proc/set_voltage(new_voltage)
		if (new_voltage && isnum(new_voltage))
			pr_recharger.max_charge = new_voltage
			return 1
		else
			return 0
