
/datum/global_iterator/mech_bay_recharger
	delay = 20
	var/max_charge = 45
	check_for_null = 0 //since port.stop_charge() must be called. The checks are made in process()

	process(var/obj/machinery/mech_bay_recharge_port/port, var/obj/mecha/mecha)
		if ((!port) || (!mecha))	return 0
		if (mecha in port.recharge_floor)
			if (!mecha.cell)	return
			var/delta = min(max_charge, mecha.cell.maxcharge - mecha.cell.charge)
			if (delta>0)
				mecha.give_power(delta)
				port.use_power(delta*150)
			else
				mecha.occupant_message("<font color='blue'><b>Fully charged.</b></font>")
				port.stop_charge()
		else
			port.stop_charge()
		return
