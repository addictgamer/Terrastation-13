//testing to get this goddamn thing working properly
/obj/machinery/power/port_gen/pacman/pingas
	name = "Pingas Wheel Generator"
	desc = "A portable generator for emergency backup power. It is rumored that this model generates its power with a disc that never stops spinning."
	power_gen = 5025

/obj/machinery/power/port_gen/pacman/pingas/HasFuel()
	return 1

/obj/machinery/power/port_gen/pacman/pingas/UseFuel()
 	return

/obj/machinery/power/port_gen/pacman/pingas/DropFuel()
 	return

//This machine is at no time ever supposed to produce over 5025. This next block does exactly that but the inherited GUI doesn't reflect this behavior entirely.
/obj/machinery/power/port_gen/pacman/pingas/process()
	if(active && HasFuel() && !crit_fail && anchored && powernet)
		add_avail(power_gen)
		UseFuel()
		src.updateDialog()

	else
		active = 0
		icon_state = initial(icon_state)
		handleInactive()
