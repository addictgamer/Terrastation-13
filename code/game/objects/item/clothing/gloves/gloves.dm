// NO GLOVES NO LOVES

/obj/item/clothing/gloves
	name = "gloves"
	desc = "A pair of gloves, they don't look special in any way."
	w_class = 2.0
	icon = 'gloves.dmi'
	protective_temperature = 400
	heat_transfer_coefficient = 0.25
	siemens_coefficient = 0.50
	var/elecgen = 0
	var/uses = 0
	var/wired = 0
	body_parts_covered = HANDS
	armor = list(melee = 0, bullet = 0, laser = 2, taser = 2, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/gloves/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/cable_coil))
		var/obj/item/weapon/cable_coil/C = W
		if(!istype(src, /obj/item/clothing/gloves/yellow))
			if(!wired)
				if(C.amount >= 2)
					C.amount -= 2
					wired = 1
					user << "You wrap some wires around [src]."
				else
					user << "There is not enough wire to cover [src]."
			else
				user << "[src] is already wired."

	else
		..()
	return
