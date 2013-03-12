
// wall formed by metal foams
// dense and opaque, but easy to break

/obj/foamedmetal
	icon = 'effects.dmi'
	icon_state = "metalfoam"
	density = 1
	opacity = 0 	// changed in New()
	anchored = 1
	name = "foamed metal"
	desc = "A lightweight foamed metal wall."
	var/metal = 1		// 1=aluminum, 2=iron

	New()
		..()
		update_nearby_tiles(1)
		spawn(1)
			sd_NewOpacity(1)

	Del()
		sd_NewOpacity(0)
		density = 0
		update_nearby_tiles(1)
		..()

	ex_act(severity)
		del(src)

	blob_act()
		del(src)

	bullet_act()
		if(metal==1 || prob(50))
			del(src)

	attack_paw(var/mob/user)
		attack_hand(user)
		return

	attack_hand(var/mob/user)
		if (user.mutations & HULK || (prob(75 - metal*25)))
			user << "\blue You smash through the metal foam wall."
			for(var/mob/O in oviewers(user))
				if ((O.client && !( O.blinded )))
					O << "\red [user] smashes through the foamed metal."
			del(src)
		else
			user << "\blue You hit the metal foam but bounce off it."
		return

	attackby(var/obj/item/I, var/mob/user)
		if (istype(I, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = I
			G.affecting.loc = src.loc
			for(var/mob/O in viewers(src))
				if (O.client)
					O << "\red [G.assailant] smashes [G.affecting] through the foamed metal wall."
			del(I)
			del(src)
			return
		if(prob(I.force*20 - metal*25))
			user << "\blue You smash through the foamed metal with \the [I]."
			for(var/mob/O in oviewers(user))
				if ((O.client && !( O.blinded )))
					O << "\red [user] smashes through the foamed metal."
			del(src)
		else
			user << "\blue You hit the metal foam to no effect."

// only air group geometry can pass
	CanPass(atom/movable/mover, turf/target, height=1.5, air_group = 0)
		return air_group

	proc
		updateicon()
			if(metal == 1)
				icon_state = "metalfoam"
			else
				icon_state = "ironfoam"

	// shouldn't this be a general procedure?
	// not sure if this neccessary or overkill
		update_nearby_tiles(need_rebuild)
			if(!air_master) return 0
			var/turf/simulated/source = loc
			var/turf/simulated/north = get_step(source,NORTH)
			var/turf/simulated/south = get_step(source,SOUTH)
			var/turf/simulated/east = get_step(source,EAST)
			var/turf/simulated/west = get_step(source,WEST)
			if(need_rebuild)
				if(istype(source)) //Rebuild/update nearby group geometry
					if(source.parent)
						air_master.groups_to_rebuild += source.parent
					else
						air_master.tiles_to_update += source
				if(istype(north))
					if(north.parent)
						air_master.groups_to_rebuild += north.parent
					else
						air_master.tiles_to_update += north
				if(istype(south))
					if(south.parent)
						air_master.groups_to_rebuild += south.parent
					else
						air_master.tiles_to_update += south
				if(istype(east))
					if(east.parent)
						air_master.groups_to_rebuild += east.parent
					else
						air_master.tiles_to_update += east
				if(istype(west))
					if(west.parent)
						air_master.groups_to_rebuild += west.parent
					else
						air_master.tiles_to_update += west
			else
				if(istype(source)) air_master.tiles_to_update += source
				if(istype(north)) air_master.tiles_to_update += north
				if(istype(south)) air_master.tiles_to_update += south
				if(istype(east)) air_master.tiles_to_update += east
				if(istype(west)) air_master.tiles_to_update += west
			return 1
