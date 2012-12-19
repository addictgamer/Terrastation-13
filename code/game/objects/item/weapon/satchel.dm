
/obj/item/weapon/satchel
	icon = 'mining.dmi'
	icon_state = "satchel"
	name = "Mining Satchel"
	var/mode = 1;  //0 = pick one at a time, 1 = pick all on tile
	var/capacity = 50; //the number of ore pieces it can carry.
	flags = FPRINT | TABLEPASS | ONBELT
	w_class = 1

/obj/item/weapon/satchel/attack_self(mob/user as mob)
	for (var/obj/item/weapon/ore/O in contents)
		contents -= O
		O.loc = user.loc
	user << "\blue You empty the satchel."
	return

/obj/item/weapon/satchel/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if (istype(W, /obj/item/weapon/ore))
		var/obj/item/weapon/ore/O = W
		src.contents += O;
	return

/obj/item/weapon/satchel/verb/toggle_mode()
	set name = "Switch Satchel Method"
	set category = "Object"

	mode = !mode
	switch (mode)
		if(1)
			usr << "The satchel now picks up all ore in a tile at once."
		if(0)
			usr << "The satchel now picks up one ore at a time."
