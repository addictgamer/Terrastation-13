/obj/item/weapon/poop
	name = "poop"
	desc = "It's brown, squishy, and reeks. You feel the urge to throw it at people."
	icon = 'poop.dmi'
	icon_state = "poop"
	w_class = 1.0
	throwforce = 1
	throw_speed = 4
	throw_range = 20
	var/material_ammount = 0 //The ammount of material it's made up of.

	proc
		place_in_world(var/turf/location)
		splatter_ground(var/ammount_lost = 1, var/turf/location = src.loc)