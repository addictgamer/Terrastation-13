
/turf/simulated/wall
	name = "wall"
	desc = "A huge chunk of metal used to seperate rooms."
	icon = 'walls.dmi'
	opacity = 1
	density = 1
	blocks_air = 1

	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m steel wall

	var/walltype = "wall"

/turf/simulated/wall/New()
	..()

/turf/simulated/wall/proc/checkForMultipleDoors()
	if(!src.loc)
		return 0
	for(var/obj/machinery/door/D in locate(src.x,src.y,src.z))
		if(!istype(D, /obj/machinery/door/window) && D.density)
			return 0
	//There are no false wall checks because that would be fucking retarded
	return 1

/turf/simulated/wall/proc/dismantle_wall(devastated=0, explode=0)
	if(istype(src,/turf/simulated/wall/r_wall))
		if(!devastated)
			playsound(src.loc, 'Welder.ogg', 100, 1)
			new /obj/structure/girder/reinforced(src)
			new /obj/item/stack/sheet/r_metal( src )
		else
			new /obj/item/stack/sheet/metal( src )
			new /obj/item/stack/sheet/metal( src )
			new /obj/item/stack/sheet/r_metal( src )
	else
		if(!devastated)
			playsound(src.loc, 'Welder.ogg', 100, 1)
			new /obj/structure/girder(src)
			new /obj/item/stack/sheet/metal( src )
			new /obj/item/stack/sheet/metal( src )
		else
			new /obj/item/stack/sheet/metal( src )
			new /obj/item/stack/sheet/metal( src )
			new /obj/item/stack/sheet/metal( src )

	ReplaceWithFloor(explode)

/turf/simulated/wall/examine()
	set src in oview(1)

	usr << "It looks like a regular wall."
	return

/turf/simulated/wall/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			src.ReplaceWithSpace()
			del(src)
			return
		if(2.0)
			if (prob(50))
				dismantle_wall(0,1)
			else
				dismantle_wall(1,1)
		if(3.0)
			var/proba
			if (istype(src, /turf/simulated/wall/r_wall))
				proba = 15
			else
				proba = 40
			if (prob(proba))
				dismantle_wall(0,1)
		else
	return

/turf/simulated/wall/blob_act()
	if(prob(50))
		dismantle_wall()

/turf/simulated/wall/attack_paw(mob/user as mob)
	if ((user.mutations & HULK))
		if (prob(40))
			usr << text("\blue You smash through the wall.")
			dismantle_wall(1)
			return
		else
			usr << text("\blue You punch the wall.")
			return

	return src.attack_hand(user)

/turf/simulated/wall/attack_hand(mob/user as mob)
	if ((user.mutations & HULK))
		if (prob(40))
			usr << text("\blue You smash through the wall.")
			dismantle_wall(1)
			return
		else
			usr << text("\blue You punch the wall.")
			return

	user << "\blue You push the wall but nothing happens!"
	playsound(src.loc, 'Genhit.ogg', 25, 1)
	src.add_fingerprint(user)
	return

/turf/simulated/wall/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		usr << "\red You don't have the dexterity to do this!"
		return

	if (istype(W, /obj/item/weapon/weldingtool) && W:welding)
		var/turf/T = get_turf(user)
		if (!( istype(T, /turf) ))
			return

		if (thermite)
			var/obj/overlay/O = new/obj/overlay( src )
			O.name = "Thermite"
			O.desc = "Looks hot."
			O.icon = 'fire.dmi'
			O.icon_state = "2"
			O.anchored = 1
			O.density = 1
			O.layer = 5
			var/turf/simulated/floor/F = ReplaceWithFloor()
			F.burn_tile()
			F.icon_state = "wall_thermite"
			user << "\red The thermite melts the wall."
			spawn(100) del(O)
			F.sd_LumReset()
			return

		if (W:remove_fuel(0,user))
			W:welding = 2
			user << "\blue Now disassembling the outer wall plating."
			playsound(src.loc, 'Welder.ogg', 100, 1)
			sleep(100)
			if (istype(src, /turf/simulated/wall))
				if ((get_turf(user) == T && user.equipped() == W))
					user << "\blue You disassembled the outer wall plating."
					dismantle_wall()
			W:welding = 1
		else
			user << "\blue You need more welding fuel to complete this task."
			return

	else if (istype(W, /obj/item/weapon/pickaxe/plasmacutter))
		var/turf/T = user.loc
		if (!( istype(T, /turf) ))
			return

		if (thermite)
			var/obj/overlay/O = new/obj/overlay( src )
			O.name = "Thermite"
			O.desc = "Looks hot."
			O.icon = 'fire.dmi'
			O.icon_state = "2"
			O.anchored = 1
			O.density = 1
			O.layer = 5
			var/turf/simulated/floor/F = ReplaceWithFloor()
			F.burn_tile()
			F.icon_state = "wall_thermite"
			user << "\red The thermite melts the wall."
			spawn(100) del(O)
			F.sd_LumReset()
			return

		else
			user << "\blue Now disassembling the outer wall plating."
			playsound(src.loc, 'Welder.ogg', 100, 1)
			sleep(60)
			if (istype(src, /turf/simulated/wall))
				if ((get_turf(user) == T && user.equipped() == W))
					user << "\blue You disassembled the outer wall plating."
					dismantle_wall()
					for(var/mob/O in viewers(user, 5))
						O.show_message(text("\blue The wall was sliced apart by []!", user), 1, text("\red You hear metal being sliced apart."), 2)
		return

	else if(istype(W, /obj/item/weapon/pickaxe/diamonddrill))
		var/turf/T = user.loc
		user << "\blue Now drilling through wall."
		sleep(60)
		if ((user.loc == T && user.equipped() == W))
			dismantle_wall(1)
			for(var/mob/O in viewers(user, 5))
				O.show_message(text("\blue The wall was drilled apart by []!", user), 1, text("\red You hear metal being drilled appart."), 2)
		return

	else if(istype(W, /obj/item/weapon/melee/energy/blade))
		var/turf/T = user.loc
		user << "\blue Now slicing through wall."
		W:spark_system.start()
		playsound(src.loc, "sparks", 50, 1)
		sleep(70)
		if ((user.loc == T && user.equipped() == W))
			W:spark_system.start()
			playsound(src.loc, "sparks", 50, 1)
			playsound(src.loc, 'blade1.ogg', 50, 1)
			dismantle_wall(1)
			for(var/mob/O in viewers(user, 5))
				O.show_message(text("\blue The wall was sliced apart by []!", user), 1, text("\red You hear metal being sliced and sparks flying."), 2)
		return

	else if(istype(W,/obj/item/apc_frame))
		var/obj/item/apc_frame/AH = W
		AH.try_build(src)
	else
		return attack_hand(user)
	return

/turf/simulated/wall/meteorhit(obj/M as obj)
	if (M.icon_state == "flaming")
		dismantle_wall()
	return 0
