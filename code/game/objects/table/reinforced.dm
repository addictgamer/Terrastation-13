
/obj/table/reinforced
	name = "reinforced table"
	desc = "A version of the four legged table. It is stronger."
	icon_state = "reinf_table"
	var/status = 2

/obj/table/reinforced/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/grab))
		var/obj/item/weapon/grab/G = W
		if (G.state<2)
			user << "\red You need a better grip to do that!"
			return
		G.affecting.loc = src.loc
		G.affecting.weakened = 5
		for(var/mob/O in viewers(world.view, src))
			if (O.client)
				O << text("\red [] puts [] on the reinforced table.", G.assailant, G.affecting)
		del(W)
		return

	if (istype(W, /obj/item/weapon/weldingtool))
		if (W:welding == 1)
			if (src.status == 2)
				W:welding = 2
				user << "\blue Now weakening the reinforced table"
				playsound(src.loc, 'Welder.ogg', 50, 1)
				sleep(50)
				user << "\blue Table weakened"
				src.status = 1
				W:welding = 1
			else
				W:welding = 2
				user << "\blue Now strengthening the reinforced table"
				playsound(src.loc, 'Welder.ogg', 50, 1)
				sleep(50)
				user << "\blue Table strengthened"
				src.status = 2
				W:welding = 1
			return
		if (isrobot(user))
			return
		user.drop_item()
		if (W && W.loc)	W.loc = src.loc
		return

	if (istype(W, /obj/item/weapon/wrench))
		if (src.status == 1)
			user << "\blue Now disassembling the reinforced table"
			playsound(src.loc, 'Ratchet.ogg', 50, 1)
			sleep(50)
			new /obj/item/weapon/table_parts/reinforced( src.loc )
			playsound(src.loc, 'Deconstruct.ogg', 50, 1)
			del(src)
			return
	if (isrobot(user))
		return

	if (istype(W, /obj/item/weapon/melee/energy/blade))
		var/datum/effects/system/spark_spread/spark_system = new /datum/effects/system/spark_spread()
		spark_system.set_up(5, 0, src.loc)
		spark_system.start()
		playsound(src.loc, 'blade1.ogg', 50, 1)
		playsound(src.loc, "sparks", 50, 1)
		for(var/mob/O in viewers(user, 4))
			O.show_message(text("\blue The reinforced table was sliced apart by []!", user), 1, text("\red You hear metal coming apart."), 2)
		new /obj/item/weapon/table_parts/reinforced( src.loc )
		del(src)
		return

	user.drop_item()
	if (W && W.loc)	W.loc = src.loc
	return
