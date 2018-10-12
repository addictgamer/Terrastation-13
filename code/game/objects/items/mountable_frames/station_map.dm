/obj/item/mounted/frame/station_map
	name = "station holomap frame"
	desc = "A virtual map of the station."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "station_map_frame0"
	mount_reqs = list("nospace")

/obj/item/mounted/frame/station_map/do_build(turf/on_wall, mob/user)
	new /obj/machinery/station_map_frame(get_turf(src), get_dir(user, on_wall))
	qdel(src)

/obj/machinery/station_map_frame
	name = "station holomap frame"
	desc = "A virtual map of the station."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "station_map_frame0"
	anchored = 1
	density = 0

	var/datum/construction/construct

/obj/machinery/station_map_frame/attackby(var/obj/item/W, var/mob/user)
	if(!construct || !construct.action(W, user))
		..()

/obj/machinery/station_map_frame/New(turf/loc, var/ndir)
	..()
	dir = ndir
	switch(ndir)
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

	construct = new /datum/construction/reversible/station_map(src)
	/*
/obj/machinery/station_map_frame/update_icon()
	icon_state = "station_map_frame[build]"
	*/
/datum/construction/reversible/station_map
	result = /obj/machinery/station_map
	original = /obj/item/mounted/frame/station_map
	var/base_icon = "station_map_frame"

	steps = list(
					//1
					 list("desc"="The glass screen is in place.",
					 	"nextstep" = list("key"=/obj/item/weapon/screwdriver,
					 		"vis_msg" = "{USER} {VERB} the panel.",
					 		"verb_2nd" = "close",
							"verb_3rd" = "closes"
					 		),
					 	"backstep" = list("key"=/obj/item/weapon/crowbar,
					 		"vis_msg" = "{USER} {VERB} the glass screen from {HOLDER}.",
					 		"verb_2nd" = "pry",
							"verb_3rd" = "pries",
					 		"start_msg" = "{USER} {VERB} removing the glass screen...",
					 		"start_2nd" = "begin",
					 		"start_3rd" = "begins",
					 		"delay" = 30)
					 	),
					 //2
					 list("desc"="The wiring is added.",
					 	"nextstep" = list("key"=/obj/item/stack/sheet/glass,
					 		"amount" = 1,
					 		"vis_msg" = "{USER} {VERB} the glass screen to {HOLDER}.",
					 		"verb_2nd" = "install",
							"verb_3rd" = "installs",
					 		"start_msg" = "{USER} {VERB} installing the glass screen...",
					 		"start_2nd" = "begin",
					 		"start_3rd" = "begins",
					 		"delay" = 30),
					 	"backstep" = list("key"=/obj/item/weapon/wirecutters,
					 		"vis_msg" = "{USER} {VERB} the wiring from {HOLDER}.",
					 		"verb_2nd" = "remove",
							"verb_3rd" = "removes")
					 	),
					 //3
					 list("desc"="The circuitboard is installed",
					 	"nextstep" = list("key"=/obj/item/stack/cable_coil,
					 		"amount" = 5,
					 		"vis_msg" = "{USER} {VERB} the wiring to {HOLDER}.",
					 		"verb_2nd" = "add",
							"verb_3rd" = "adds",
					 		"delay" = 20),
					 	"backstep" = list("key"=/obj/item/weapon/crowbar,
					 		"vis_msg" = "{USER} {VERB} the glass screen from {HOLDER}.",
							"verb_2nd" = "pry",
							"verb_3rd" = "pries")
					 	),
					 //4
					 list("desc"="The frame is on the wall.",
					 	"nextstep" = list("key"=/obj/item/weapon/circuitboard/station_map,
					 		"vis_msg" = "{USER} {VERB} the circuitboard into {HOLDER}.",
					 		"verb_2nd" = "install",
							"verb_3rd" = "installs",
					 		"amount" = 1),
					 	"backstep" = list("key"=/obj/item/weapon/screwdriver,
					 		"vis_msg" = "{USER} {VERB} {HOLDER} from the wall.",
					 		"verb_2nd" = "unfasten",
							"verb_3rd" = "unfastens",
					 		"start_msg" = "{USER} {VERB} removing {HOLDER}'s screws...",
					 		"start_2nd" = "begin",
							"start_3rd" = "begins",
					 		"delay" = 30)
					 	)
					)

/datum/construction/reversible/station_map/custom_action(index, diff, atom/used_atom, mob/user)
	if(!..())
		return 0

	holder.icon_state = "[base_icon][steps.len - index - diff]"
	return 1

/datum/construction/reversible/station_map/action(atom/used_atom,mob/user)
	return check_step(used_atom,user)

/datum/construction/reversible/station_map/spawn_result(mob/user as mob)
	if(result)
		//testing("[user] finished a [result]!")

		var/obj/machinery/station_map/S = new result(get_turf(holder))
		S.dir = holder.dir
		S.update_icon()

		qdel (holder)
		holder = null

	feedback_inc("station_map_created",1)




/obj/item/weapon/circuitboard/station_map
	icon = 'icons/obj/module.dmi'
	name = "holomap module"
	icon_state = "card_mod"
	desc = "Holographic circuits for station holomaps."
	board_type = "other"

