/obj/item/weapon/secstorage/ssafe
	name = "secure safe"
	icon = 'storage.dmi'
	icon_state = "safe"
	icon_open = "safe0"
	icon_locking = "safeb"
	icon_sparking = "safespark"
	flags = FPRINT | TABLEPASS
	force = 8.0
	w_class = 4.0
	anchored = 1.0
	density = 0

	New()
		..()
		new /obj/item/paper(src)
		new /obj/item/weapon/pen(src)

	attack_hand(mob/user as mob)
		return attack_self(user)
