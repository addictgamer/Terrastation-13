
/obj/item/weapon/bedsheet
	name = "bedsheet"
	desc = "Nice, linen, bedsheet. Perfect to put on."
	icon = 'items.dmi'
	icon_state = "sheet"
	layer = 4.0
	item_state = "bedsheet"
	throwforce = 1
	w_class = 1.0
	throw_speed = 2
	throw_range = 10

/obj/item/weapon/bedsheet/ex_act(severity)
	if (severity <= 2)
		del(src)
		return
	return

/obj/item/weapon/bedsheet/attack_self(mob/user as mob)
	user.drop_item()
	src.layer = 5
	add_fingerprint(user)
	return
