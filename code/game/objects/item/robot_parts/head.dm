
/obj/item/robot_parts/head
	name = "Cyborg Head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals."
	icon_state = "head"
	construction_time = 350
	construction_cost = list("metal"=25000)
	var
		obj/item/device/flash/flash1 = null
		obj/item/device/flash/flash2 = null

	attackby(obj/item/W as obj, mob/user as mob)
		..()
		if (istype(W, /obj/item/device/flash))
			if (src.flash1 && src.flash2)
				user << "\blue You have already inserted the eyes!"
				return
			else if (src.flash1)
				user.drop_item()
				W.loc = src
				src.flash2 = W
				user << "\blue You insert the flash into the eye socket!"
			else
				user.drop_item()
				W.loc = src
				src.flash1 = W
				user << "\blue You insert the flash into the eye socket!"
		return
