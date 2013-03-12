
//NOT using the existing /obj/machinery/door type, since that has some complications on its own, mainly based on its machineryness

/obj/mineral_door
	name = "mineral door"
	density = 1
	anchored = 1
	opacity = 1
	icon = 'mineral_doors.dmi'
	icon_state = "iron"
	var
		mineralType = "iron"
		state = 0 //closed, 1 == open
		isSwitchingStates = 0
		hardness = 1
		oreAmount = 7

	New(location)
		..()
		icon_state = mineralType
		name = "[mineralType] door"
		update_nearby_tiles(need_rebuild=1)

	Del()
		update_nearby_tiles()
		..()

	Bumped(atom/user)
		..()
		if(!state)
			return TryToSwitchState(user)
		return

	attack_ai(mob/user as mob) //those aren't machinery, they're just big fucking slabs of a mineral
		if(isAI(user)) //so the AI can't open it
			return
		else if(isrobot(user)) //but cyborgs can
			if(get_dist(user,src) <= 1) //not remotely though
				return TryToSwitchState(user)

	attack_paw(mob/user as mob)
		return TryToSwitchState(user)

	attack_hand(mob/user as mob)
		return TryToSwitchState(user)

	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(air_group) return 0
		if(istype(mover, /obj/beam))
			return !opacity
		return !density

	update_icon()
		if(state)
			icon_state = "[mineralType]open"
		else
			icon_state = mineralType

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W,/obj/item/weapon/pickaxe))
			var/obj/item/weapon/pickaxe/digTool = W
			user << "You start digging the [name]."
			if(do_after(user,digTool.digspeed*hardness) && src)
				user << "You finished digging."
				Dismantle()
		else if(istype(W,/obj/item/weapon)) //not sure, can't not just weapons get passed to this proc?
			hardness -= W.force/100
			user << "You hit the [name] with your [W.name]!"
			CheckHardness()
		else
			attack_hand(user)
		return

	ex_act(severity = 1)
		switch(severity)
			if(1)
				Dismantle(1)
			if(2)
				if(prob(20))
					Dismantle(1)
				else
					hardness--
					CheckHardness()
			if(3)
				hardness -= 0.1
				CheckHardness()
		return

	proc
		TryToSwitchState(atom/user)
			if(isSwitchingStates) return
			if(ismob(user))
				var/mob/M = user
				if(world.time - user.last_bumped <= 60) return //NOTE do we really need that?
				if(M.client && !M:handcuffed)
					SwitchState()
			else if(istype(user, /obj/mecha))
				SwitchState()

		SwitchState()
			if(state)
				Close()
			else
				Open()

		Open()
			isSwitchingStates = 1
			playsound(loc, 'stonedoor_openclose.ogg', 100, 1)
			flick("[mineralType]opening",src)
			sleep(10)
			density = 0
			opacity = 0
			state = 1
			update_icon()
			isSwitchingStates = 0

		Close()
			isSwitchingStates = 1
			playsound(loc, 'stonedoor_openclose.ogg', 100, 1)
			flick("[mineralType]closing",src)
			sleep(10)
			density = 1
			opacity = 1
			state = 0
			update_icon()
			isSwitchingStates = 0

		CheckHardness()
			if(hardness <= 0)
				Dismantle(1)

		Dismantle(devastated = 0)
			if(!devastated)
				var/ore = text2path("/obj/item/weapon/ore/[mineralType]")
				for(var/i = 1, i <= oreAmount, i++)
					new ore(get_turf(src))
			del(src)

		update_nearby_tiles(need_rebuild) //Copypasta from airlock code
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
