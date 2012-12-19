
/obj/item/powerarmor/power/powercell
	name = "Powercell interface"
	desc = "Boring, but reliable."
	var/obj/item/weapon/cell/cell
	slowdown = 0.5

/obj/item/powerarmor/power/powercell/process()
	if (cell && cell.charge > 0 && parent.active)
		cell.use(50)
		spawn(50)
			process()
		return
	else if (parent.active)
		parent.powerdown(1)
		return

/obj/item/powerarmor/power/powercell/checkpower()
	return max(cell.charge, 0)
