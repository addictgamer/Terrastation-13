
// Basically this Metroid Core catalyzes reactions that normally wouldn't happen anywhere
/obj/item/metroid_core
	name = "metroid core"
	desc = "A very slimy and tender part of a Metroid. They also legend to have \"magical powers\"."
	icon = 'surgery.dmi'
	icon_state = "metroid core"
	flags = TABLEPASS
	force = 1.0
	w_class = 1.0
	throwforce = 1.0
	throw_speed = 3
	throw_range = 6
	origin_tech = "biotech=4"
	var/POWERFLAG = 0 // sshhhhhhh
	var/Flush = 30

/obj/item/metroid_core/New()
	..()
	var/datum/reagents/R = new/datum/reagents(100)
	reagents = R
	R.my_atom = src
	POWERFLAG = rand(1,10)
	//flags |= NOREACT
	spawn()
		Life()

/obj/item/metroid_core/proc/Life()
	while(src)
		sleep(10)
		Flush--
		if (Flush <= 0)
			reagents.clear_reagents()
			Flush = 30
