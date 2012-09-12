/obj/machinery/disease2/monkeycloner
	name = "Monkey dispensor"
	icon = 'cloning.dmi'
	icon_state = "pod_0"
	density = 1
	anchored = 1

	var/cloning = 0
	var/clone_time = 120
	var/power_usage = 5000

	proc/togglePower()

/obj/machinery/disease2/monkeycloner/attack_hand()
	togglePower()
	return

/obj/machinery/disease2/monkeycloner/process()
	if(stat & (NOPOWER|BROKEN))
		return
	use_power(power_usage)
	src.updateDialog()

	if(cloning) //IT IS ON.
		cloning -= 1 //Continue the cloning process.
		if(!cloning) //Check if it finished.
			new /mob/living/carbon/monkey(src.loc) //Spawn monkey.
			icon_state = "pod_0"
	return

/obj/machinery/disease2/monkeycloner/togglePower()
	if(cloning) //If it's on.
		cloning = 0 //Turn it off.

		icon_state = "pod_0" //Set the icon state to off.
	else
		cloning = clone_time //Turn it on.

		icon_state = "pod_g" //Set the icon state to on.
	return