
/obj/machinery/crema_switch
	desc = "Burn baby burn!"
	name = "crematorium igniter"
	icon = 'power.dmi'
	icon_state = "crema_switch"
	anchored = 1.0
	req_access = list(access_crematorium)
	var
		on = 0
		area/area = null
		otherarea = null
		id = 1

	attack_hand(mob/user as mob)
		if(src.allowed(usr))
			for (var/obj/crematorium/C in world)
				if (C.id == id)
					if (!C.cremating)
						C.cremate(user)
		else
			usr << "\red Access denied."
		return
