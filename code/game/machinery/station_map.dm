var/list/station_holomaps = list()

/obj/machinery/station_map
	name = "station holomap"
	desc = "A virtual map of the surrounding station."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "station_map"
	anchored = 1
	density = 0
	speed_process = 1
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 10
	dir = NORTH

//	use_auto_lights = 1
	light_color = "#64C864"
//	light_power_on = 1
//	light_range_on = 2

//	machine_flags = SCREWTOGGLE | FIXED2WORK | CROWDESTROY

	layer = ABOVE_WINDOW_LAYER

	var/mob/watching_mob = null
	var/image/small_station_map = null
	var/image/floor_markings = null
	var/image/panel = null

	var/original_zLevel = 1	//zLevel on which the station map was initialized.
	var/bogus = 0			//set to 1 when you initialize the station map on a zLevel that doesn't have its own icon formatted for use by station holomaps.
							//currently, the only supported zLevels are the Station, the Asteroid, and the Derelict.

	var/datum/station_holomap/holomap_datum

/obj/machinery/station_map/New()
	..()
	holomap_datum = new()
	original_zLevel = loc.z
	station_holomaps += src
//	flow_flags |= ON_BORDER
	component_parts = 0
	if(ticker && holomaps_initialized)
		initialize()

/obj/machinery/station_map/Destroy()
	stopWatching()
	station_holomaps -= src
	holomap_datum = null
	fast_processing -= src
	machine_processing -= src
	machines -= src
	..()

/*/obj/machinery/station_map/crowbarDestroy(mob/user)
	user.visible_message(	"[user] begins to pry out \the [src] from the wall.",
							"You begin to pry out \the [src] from the wall...")
	if(do_after(user, src, 40))
		user.visible_message(	"[user] detaches \the [src] from the wall.",
								"You detach \the [src] from the wall.")
		playsound(src, 'sound/items/Crowbar.ogg', 50, 1)
		new /obj/item/mounted/frame/station_map(src.loc)

		for(var/obj/I in src)
			qdel(I)

		new /obj/item/weapon/circuitboard/station_map(src.loc)
		new /obj/item/stack/cable_coil(loc,5)
		new /obj/item/stack/sheet/glass(loc,1)

		return 1
	return -1
*/

/obj/machinery/station_map/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/screwdriver) && anchored)
		playsound(loc, I.usesound, 50, 1)
		panel_open = !panel_open
		to_chat(user, "You [panel_open ? "open" : "close"] the maintenance panel.")
//		overlays.Cut()
		if(panel_open)
			overlays += image(icon, "[initial(icon_state)]-panel")
			overlays -= small_station_map
		else
			update_icon()
		return
	if(panel_open)
		if(istype(I, /obj/item/weapon/crowbar))
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message(	"[user] begins to pry out \the [src] from the wall.",
									"You begin to pry out \the [src] from the wall...")
			if(do_after(usr, 40 * I.toolspeed, target = src))
				user.visible_message(	"[user] detaches \the [src] from the wall.",
										"You detach \the [src] from the wall.")
				playsound(src, 'sound/items/Crowbar.ogg', 50, 1)
				overlays.Cut()
				new /obj/item/mounted/frame/station_map(src.loc)

				new /obj/item/weapon/circuitboard/station_map(src.loc)
				new /obj/item/stack/cable_coil(loc,5)
				new /obj/item/stack/sheet/glass(loc,1)
				Destroy(src)

/obj/machinery/station_map/initialize()
	..()
	holomap_setup()
	if(bogus)
		return
//	small_station_map.plane = LIGHTING_PLANE
	small_station_map.plane = 15
//	small_station_map.layer = ABOVE_LIGHTING_LAYER
	small_station_map.layer = 16
	update_icon()

/obj/machinery/station_map/proc/holomap_setup()
	bogus = 0
	var/turf/T = get_turf(src)
	original_zLevel = T.z
	if(!(HOLOMAP_EXTRA_STATIONMAP+"_[original_zLevel]" in extraMiniMaps))
		bogus = 1
		holomap_datum.initialize_holomap_bogus()
		update_icon()
		return

	holomap_datum.initialize_holomap(T)

	small_station_map = image(extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_NORTH+"_[original_zLevel]"])

	floor_markings = image('icons/turf/overlays.dmi', "station_map")
	floor_markings.dir = dir
	floor_markings.plane = 0
	floor_markings.layer = 2.08


/obj/machinery/station_map/attack_hand(var/mob/user)
	if(watching_mob && (watching_mob != user))
		to_chat(user, "<span class='warning'>Someone else is currently watching the holomap.</span>")
		return

	if(user.loc != loc)
		to_chat(user, "<span class='warning'>You need to stand in front of \the [src].</span>")
		return

	if(user.dir != dir)
		to_chat(user, "<span class='warning'>You need to face \the [src].</span>")
		return

	if(isliving(user) && !panel_open && anchored && !(stat & (NOPOWER|BROKEN)))
		if(watching_mob && (watching_mob == user))
			stopWatching(user)
		else if(user.hud_used && user.hud_used.holomap_obj)
			holomap_datum.station_map.loc = user.hud_used.holomap_obj
			holomap_datum.station_map.alpha = 0
			animate(holomap_datum.station_map, alpha = 255, time = 5, easing = LINEAR_EASING)
			watching_mob = user
			flick("station_map_activate", src)
			watching_mob.client.images |= holomap_datum.station_map
//			watching_mob.callOnFace["\ref[src]"] = "checkPosition"

			if(bogus)
				to_chat(user, "<span class='warning'>The holomap failed to initialize. This area of space cannot be mapped.</span>")
			else
				to_chat(user, "<span class='notice'>A hologram of the station appears before your eyes.</span>")

/*
/obj/machinery/station_map/attack_paw(var/mob/user)
	src.attack_hand(user)
*/
/obj/machinery/station_map/attack_animal(var/mob/user)
	src.attack_hand(user)

/obj/machinery/station_map/attack_ghost(var/mob/user)
//	if(!can_spook())
//		return FALSE
	add_hiddenprint(user)
	flick("station_map_activate", src)

obj/machinery/station_map/attack_ai(var/mob/living/silicon/robot/user)
	user.station_holomap.toggleHolomap(user, isAI(user))

/obj/machinery/station_map/process()
	if((stat & (NOPOWER|BROKEN)) || !anchored || panel_open)
		stopWatching()
	checkPosition()

/obj/machinery/station_map/proc/checkPosition()
	if(!watching_mob || (watching_mob.loc != loc) || (dir != watching_mob.dir))
		stopWatching()

/obj/machinery/station_map/proc/stopWatching()
	if(watching_mob)
		if(watching_mob.client)
			var/mob/M = watching_mob
			spawn(5)//we give it time to fade out
				M.client.images -= holomap_datum.station_map
//		watching_mob.callOnFace -= "\ref[src]"
//		watching_mob.permanent_huds -= "\ref[src]"
	watching_mob = null
	animate(holomap_datum.station_map, alpha = 0, time = 5, easing = LINEAR_EASING)

/obj/machinery/station_map/power_change()
	. = ..()
	update_icon()

/obj/machinery/station_map/proc/set_broken()
	stat |= BROKEN
	update_icon()

/obj/machinery/station_map/update_icon()
	if(!holomaps_initialized)
		return
	overlays.len = 0
	if(stat & BROKEN)
		icon_state = "station_mapb"
	else if((stat & NOPOWER) || !anchored)
		icon_state = "station_map0"
	else
		icon_state = "station_map"

		if(bogus)
			holomap_datum.station_map.overlays.len = 0
			holomap_datum.station_map.overlays |= holomap_datum.legend
		else
			switch(dir)
				if(NORTH)
					small_station_map.icon = extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_NORTH+"_[original_zLevel]"]
				if(SOUTH)
					small_station_map.icon = extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_SOUTH+"_[original_zLevel]"]
				if(EAST)
					small_station_map.icon = extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_EAST+"_[original_zLevel]"]
				if(WEST)
					small_station_map.icon = extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_WEST+"_[original_zLevel]"]

			overlays |= small_station_map
			holomap_datum.station_map.overlays.len = 0
			if(using_map.holomap_offset_x.len >= original_zLevel)
				holomap_datum.cursor.pixel_x = (x-6+using_map.holomap_offset_x[original_zLevel])*PIXEL_MULTIPLIER
				holomap_datum.cursor.pixel_y = (y-6+using_map.holomap_offset_y[original_zLevel])*PIXEL_MULTIPLIER
			else
				holomap_datum.cursor.pixel_x = (x-6)*PIXEL_MULTIPLIER
				holomap_datum.cursor.pixel_y = (y-6)*PIXEL_MULTIPLIER
			holomap_datum.station_map.overlays |= holomap_datum.cursor
			holomap_datum.station_map.overlays |= holomap_datum.legend

	switch(dir)
		if(NORTH)
			pixel_x = 0
			pixel_y = WORLD_ICON_SIZE
		if(SOUTH)
			pixel_x = 0
			pixel_y = -1*WORLD_ICON_SIZE
		if(EAST)
			pixel_x = WORLD_ICON_SIZE
			pixel_y = 0
		if(WEST)
			pixel_x = -1*WORLD_ICON_SIZE
			pixel_y = 0

	if(floor_markings)
		floor_markings.dir = dir
		floor_markings.pixel_x = -1*pixel_x
		floor_markings.pixel_y = -1*pixel_y
		overlays |= floor_markings

	if(panel_open)
		overlays |= "station_map-panel"
	else
		overlays -= "station_map-panel"

/obj/machinery/station_map/ex_act(severity)
	switch(severity)
		if(1)
			qdel(src)
		if(2)
			if (prob(50))
				qdel(src)
			else
				set_broken()
		if(3)
			if (prob(25))
				set_broken()

//Portable holomaps, currently AI/Borg/MoMMI only
/obj/item/device/station_map
	name					= "portable station holomap"
	desc					= "A virtual map of the surrounding station."
	icon_state				= "station_map"
//	flags					= FPRINT
	siemens_coefficient		= 1
	force					= 5.0
	w_class					= 2.0
	throwforce				= 5.0
	throw_range				= 15
	throw_speed				= 3
	materials		= list(MAT_METAL = 50, MAT_GLASS = 20)
//	w_type					= RECYK_ELECTRONIC
//	melt_temperature		= MELTPOINT_SILICON
	origin_tech				= "programming=2;engineering=2"

	var/mob/watching_mob = null

	var/datum/station_holomap/holomap_datum

/obj/item/device/station_map/New()
	..()
	holomap_datum = new()

/obj/item/device/station_map/attack_self(var/mob/user)
	toggleHolomap(user)

/obj/item/device/station_map/proc/toggleHolomap(var/mob/user,var/isAI=0)
	if(watching_mob)
		if(watching_mob == user)
			stopWatching()
			return
		else
			stopWatching()

	if(user.hud_used && user.hud_used.holomap_obj)
		watching_mob = user
		var/turf/T = get_turf(user)
		var/bogus = 0
		if(!(HOLOMAP_EXTRA_STATIONMAP+"_[T.z]" in extraMiniMaps))
			bogus = 1
			holomap_datum.initialize_holomap_bogus()
		else
			holomap_datum.initialize_holomap(T, isAI, user)

		holomap_datum.station_map.loc = user.hud_used.holomap_obj
		holomap_datum.station_map.alpha = 0
		animate(holomap_datum.station_map, alpha = 255, time = 5, easing = LINEAR_EASING)

		user.client.images |= holomap_datum.station_map

		if(bogus)
			to_chat(user, "<span class='warning'>The holomap failed to initialize. This area of space cannot be mapped.</span>")
		else
			to_chat(user, "<span class='notice'>A hologram of the station appears before your eyes.</span>")

/obj/item/device/station_map/Destroy()
	stopWatching()
	holomap_datum = null
	return ..()

/obj/item/device/station_map/dropped(mob/user)
	stopWatching()

/obj/item/device/station_map/proc/stopWatching()
	if(watching_mob)
		if(watching_mob.client)
			var/mob/M = watching_mob
			spawn(5)//we give it time to fade out
				M.client.images -= holomap_datum.station_map
	watching_mob = null
	if(holomap_datum && holomap_datum.station_map)//sanity check to prevent runtime when silicons get destroyed.
		animate(holomap_datum.station_map, alpha = 0, time = 5, easing = LINEAR_EASING)

//Holomap datum, for initialization
/datum/station_holomap
	var/image/station_map
	var/image/cursor
	var/image/legend

/datum/station_holomap/proc/initialize_holomap(var/turf/T, var/isAI=null, var/mob/user=null)
	if(isAI)
		T = get_turf(user.client.eye)
	station_map = image(extraMiniMaps[HOLOMAP_EXTRA_STATIONMAP+"_[T.z]"])
	cursor = image('icons/holomap_markers.dmi', "you")
	if(using_map.holomap_offset_x.len >= T.z)
		cursor.pixel_x = (T.x-6+using_map.holomap_offset_x[T.z])*PIXEL_MULTIPLIER
		cursor.pixel_y = (T.y-6+using_map.holomap_offset_y[T.z])*PIXEL_MULTIPLIER
	else
		cursor.pixel_x = (T.x-6)*PIXEL_MULTIPLIER
		cursor.pixel_y = (T.y-6)*PIXEL_MULTIPLIER
	legend = image('icons/effects/64x64.dmi', "legend")
	legend.pixel_x = 3*WORLD_ICON_SIZE
	legend.pixel_y = 3*WORLD_ICON_SIZE
	station_map.overlays |= cursor
	station_map.overlays |= legend

/datum/station_holomap/proc/initialize_holomap_bogus()
	station_map = image('icons/480x480.dmi', "stationmap")
	legend = image('icons/effects/64x64.dmi', "notfound")
	legend.pixel_x = 7*WORLD_ICON_SIZE
	legend.pixel_y = 7*WORLD_ICON_SIZE
	station_map.overlays |= legend

/obj/machinery/station_map/strategic
	name = "strategic station holomap"
	density = 1
//	machine_flags = null
	icon = 'icons/obj/stationobjs_64x64.dmi'
	pixel_x = -1*WORLD_ICON_SIZE/2
	pixel_y = -1*WORLD_ICON_SIZE/2

	var/list/watching_mobs = list()
	var/list/watcher_maps = list()

/obj/machinery/station_map/strategic/New()
	..()
	holomap_datum = new /datum/station_holomap/strategic()
	original_zLevel = using_map.zMainStation
	if(ticker && holomaps_initialized)
		initialize()

/obj/machinery/station_map/strategic/holomap_setup()
	holomap_datum.initialize_holomap()
	small_station_map = image(extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_NORTH+"_[using_map.zMainStation]"])

/obj/machinery/station_map/strategic/attack_hand(var/mob/user)
	if(isliving(user) && anchored && !(stat & (NOPOWER|BROKEN)))
		if(user in watching_mobs)
			stopWatching(user)
		else
			if(user.hud_used && user.hud_used.holomap_obj)
				if(!("\ref[user]" in watcher_maps))
					watcher_maps["\ref[user]"] = image(holomap_datum.station_map)
				var/image/I = watcher_maps["\ref[user]"]
				I.loc = user.hud_used.holomap_obj
				I.alpha = 0
				animate(watcher_maps["\ref[user]"], alpha = 255, time = 5, easing = LINEAR_EASING)
				watching_mobs |= user
				user.client.images |= watcher_maps["\ref[user]"]
//				user.callOnFace["\ref[src]"] = "checkPosition"
				to_chat(user, "<span class='notice'>An hologram of the station appears before your eyes.</span>")


/obj/machinery/station_map/strategic/checkPosition()
	for(var/mob/M in watching_mobs)
		if(get_dist(src,M) > 1)
			stopWatching(M)

/obj/machinery/station_map/strategic/stopWatching(var/mob/user)
	if(!user)
		for(var/mob/M in watching_mobs)
			if(M.client)
				spawn(5)//we give it time to fade out
				M.client.images -= watcher_maps["\ref[M]"]
//				M.callOnFace -= "\ref[src]"
				animate(watcher_maps["\ref[M]"], alpha = 0, time = 5, easing = LINEAR_EASING)

		watching_mobs = list()
	else
		if(user.client)
			spawn(5)//we give it time to fade out
				if(!(user in watching_mobs))
					user.client.images -= watcher_maps["\ref[user]"]
					watcher_maps -= "\ref[user]"
//			user.callOnFace -= "\ref[src]"
			animate(watcher_maps["\ref[user]"], alpha = 0, time = 5, easing = LINEAR_EASING)

			watching_mobs -= user

/obj/machinery/station_map/strategic/update_icon()
	overlays.len = 0
	if(!(stat & (NOPOWER|BROKEN)))
		if(!small_station_map)
			small_station_map = image(extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_NORTH+"_[using_map.zMainStation]"])
			small_station_map.plane = LIGHTING_PLANE
			small_station_map.layer = ABOVE_LIGHTING_LAYER
		small_station_map.icon = extraMiniMaps[HOLOMAP_EXTRA_STATIONMAPSMALL_NORTH+"_[using_map.zMainStation]"]
		small_station_map.pixel_x = WORLD_ICON_SIZE/2
		small_station_map.pixel_y = 5*PIXEL_MULTIPLIER+WORLD_ICON_SIZE/2
		overlays |= small_station_map

/datum/station_holomap/strategic/initialize_holomap(var/turf/T, var/isAI=null, var/mob/user=null)
	station_map = image(extraMiniMaps[HOLOMAP_EXTRA_STATIONMAP_STRATEGIC])
	legend = image('icons/effects/64x64.dmi', "strategic")
	legend.pixel_x = 3*WORLD_ICON_SIZE
	legend.pixel_y = 3*WORLD_ICON_SIZE
	station_map.overlays |= legend


/mob/living/silicon/robot/verb/toggle_station_map()
	set category = "Robot Commands"
	set name = "Toggle Station Holomap"
	set desc = "Toggle station holomap on your screen"

	if(stat == UNCONSCIOUS)
		return
	station_holomap.toggleHolomap(src)
