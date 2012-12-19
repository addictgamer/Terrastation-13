
/obj/item/toy/sword
	name = "toy sword"
	desc = "A cheap, plastic replica of an energy sword. Realistic sounds! Ages 8 and up."
	icon = 'weapons.dmi'
	icon_state = "sword0"
	item_state = "sword0"
	var/active = 0.0
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD

/obj/item/toy/sword/attack_self(mob/user as mob)
	src.active = !( src.active )
	if (src.active)
		user << "\blue You extend the plastic blade with a quick flick of your wrist."
		playsound(user, 'saberon.ogg', 50, 1)
		src.icon_state = "swordblue"
		src.item_state = "swordblue"
		src.w_class = 4
	else
		user << "\blue You push the plastic blade back down into the handle."
		playsound(user, 'saberoff.ogg', 50, 1)
		src.icon_state = "sword0"
		src.item_state = "sword0"
		src.w_class = 2
	src.add_fingerprint(user)
	return
