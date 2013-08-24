
/obj/machinery/r_n_d/server
	name = "R&D Server"
	icon_state = "server"
	var
		datum/research/files
		health = 100
		list
			id_with_upload = list()		//List of R&D consoles with upload to server access.
			id_with_download = list()	//List of R&D consoles with download from server access.
		id_with_upload_string = ""		//String versions for easy editing in map editor.
		id_with_download_string = ""
		server_id = 0
		heat_gen = 100
		heating_power = 40000
		delay = 10
	req_access = list(access_rd) //Only the R&D can change server settings.

	New()
		..()
		component_parts = list()
		component_parts += new /obj/item/weapon/circuitboard/rdserver(src)
		component_parts += new /obj/item/weapon/stock_parts/scanning_module(src)
		component_parts += new /obj/item/cable_coil(src)
		component_parts += new /obj/item/cable_coil(src)
		RefreshParts()

	RefreshParts()
		var/tot_rating = 0
		for(var/obj/item/weapon/stock_parts/SP in src)
			tot_rating += SP.rating
		heat_gen /= max(1, tot_rating)

	initialize()
		if (!files) files = new /datum/research(src)
		var/list/temp_list
		if (!id_with_upload.len)
			temp_list = list()
			temp_list = dd_text2list(id_with_upload_string, ";")
			for(var/N in temp_list)
				id_with_upload += text2num(N)
		if (!id_with_download.len)
			temp_list = list()
			temp_list = dd_text2list(id_with_download_string, ";")
			for(var/N in temp_list)
				id_with_download += text2num(N)

	process()
		var/datum/gas_mixture/environment = loc.return_air()
		switch(environment.temperature)
			if (0 to T0C)
				health = min(100, health + 1)
			if (T0C to (T20C + 20))
				health = between(0, health, 100)
			if ((T20C + 20) to (T0C + 70))
				health = max(0, health - 1)
		if (health <= 0)
			files.known_designs = list()
			for(var/datum/tech/T in files.known_tech)
				if (prob(1))
					T.level--
			files.RefreshResearch()
		if (delay)
			delay--
		else
			produce_heat(heat_gen)
			delay = initial(delay)


	proc
		produce_heat(heat_amt)
			if (!(stat & (NOPOWER|BROKEN))) //Blatently stolen from space heater.
				var/turf/simulated/L = loc
				if (istype(L))
					var/datum/gas_mixture/env = L.return_air()
					if (env.temperature < (heat_amt+T0C))

						var/transfer_moles = 0.25 * env.total_moles()

						var/datum/gas_mixture/removed = env.remove(transfer_moles)

						if (removed)

							var/heat_capacity = removed.heat_capacity()
							if (heat_capacity == 0 || heat_capacity == null)
								heat_capacity = 1
							removed.temperature = min((removed.temperature*heat_capacity + heating_power)/heat_capacity, 1000)

						env.merge(removed)

	attackby(var/obj/item/O as obj, var/mob/user as mob)
		if (disabled)
			return
		if (shocked)
			shock(user,50)
		if (istype(O, /obj/item/weapon/screwdriver))
			if (!opened)
				opened = 1
				icon_state = "server_o"
				user << "You open the maintenance hatch of [src]."
			else
				opened = 0
				icon_state = "server"
				user << "You close the maintenance hatch of [src]."
			return
		if (opened)
			if (istype(O, /obj/item/weapon/crowbar))
				playsound(src.loc, 'Crowbar.ogg', 50, 1)
				var/obj/machinery/constructable_frame/machine_frame/M = new /obj/machinery/constructable_frame/machine_frame(src.loc)
				M.state = 2
				M.icon_state = "box_1"
				for(var/obj/I in component_parts)
					if (I.reliability != 100 && crit_fail)
						I.crit_fail = 1
					I.loc = src.loc
				del(src)
				return 1

	attack_hand(mob/user as mob)
		if (disabled)
			return
		if (shocked)
			shock(user,50)
		if (ishuman(user))
			if (istype(user:gloves, /obj/item/clothing/gloves/space_ninja)&&user:gloves:candrain&&!user:gloves:draining)
				call(/obj/item/clothing/gloves/space_ninja/proc/drain)("RESEARCH",src,user:wear_suit)
		return
