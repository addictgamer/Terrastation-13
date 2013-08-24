
/obj/item/robot_parts/chest
	name = "Cyborg Torso"
	desc = "A heavily reinforced case containing cyborg logic boards, with space for a standard power cell."
	icon_state = "chest"
	construction_time = 350
	construction_cost = list("metal"=40000)
	var
		wires = 0.0
		obj/item/weapon/cell/cell = null

	attackby(obj/item/W as obj, mob/user as mob)
		..()
		if (istype(W, /obj/item/weapon/cell))
			if (src.cell)
				user << "\blue You have already inserted a cell!"
				return
			else
				user.drop_item()
				W.loc = src
				src.cell = W
				user << "\blue You insert the cell!"
		if (istype(W, /obj/item/cable_coil))
			if (src.wires)
				user << "\blue You have already inserted wire!"
				return
			else
				var/obj/item/cable_coil/coil = W
				coil.use(1)
				src.wires = 1.0
				user << "\blue You insert the wire!"
		return
