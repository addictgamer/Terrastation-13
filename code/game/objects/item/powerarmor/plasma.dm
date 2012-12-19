
/obj/item/powerarmor/power/plasma
	name = "Miniaturized plasma generator"
	desc = "Runs on plasma."
	slowdown = 1
	var/fuel = 0

/obj/item/powerarmor/power/plasma/process()
	if (fuel > 0 && parent.active)
		fuel--
		spawn(50)
			process()
		return
	else if (parent.active)
		parent.powerdown(1)
		return

/obj/item/powerarmor/power/plasma/checkpower()
	return fuel
