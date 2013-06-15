//This is a method (albiet a rondabout one) to allow a ruskie to trade with the main station.
//He or she can also use this method to board the actual station, but they would have no way of legitimately getting back.
//Also, this file will contain other stuff pertinent to the ruskie in the future.

//most of this is copypasta and edit from the mining shuttle

var/ruskie_shuttle_tickstomove = 10
var/ruskie_shuttle_moving = 0
var/ruskie_shuttle_location = 0 // 0 = centcom, 1 = ruskie station.
//Yes, this is a bit backwards.

proc/move_ruskie_shuttle()  //This is what makes the goddamn thing move
	if(ruskie_shuttle_moving)	return
	ruskie_shuttle_moving = 1
	spawn(ruskie_shuttle_tickstomove*10)
		var/area/fromArea
		var/area/toArea
		if (ruskie_shuttle_location == 1)
			fromArea = locate(/area/shuttle/ruskie/ruskie)
			toArea = locate(/area/shuttle/ruskie/centcom)
		else
			fromArea = locate(/area/shuttle/ruskie/centcom)
			toArea = locate(/area/shuttle/ruskie/ruskie)
		fromArea.move_contents_to(toArea)
		if (ruskie_shuttle_location)
			ruskie_shuttle_location = 0
		else
			ruskie_shuttle_location = 1
		ruskie_shuttle_moving = 0
	return

/obj/machinery/computer/ruskie_shuttle  //This is the computer that controls the shuttle.
	name = "DJ Station Shuttle Console"
	icon = 'computer.dmi'
	icon_state = "shuttle"
	req_access = list(access_cent_general)		//Need a centcom ID to use this; thankfully one spawns in DJ station.
	var/hacked = 0
	var/location = 0 //0 = centcom, 1 = ruskie station   //No idea wtf this does, but it was in the copied source so I'm afraid to dick with it

/obj/machinery/computer/ruskie_shuttle/attack_hand(user as mob) //The window that pops up
	src.add_fingerprint(usr)
	var/dat
	dat = text("<b>DJ Station shuttle: <A href='?src=\ref[src];move=[1]'>Call</A></b>")
	user << browse("[dat]", "window=ruskieshuttle;size=200x100")

/obj/machinery/computer/ruskie_shuttle/Topic(href, href_list) //The message that displays when you call it
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)
	if(href_list["move"])

		if (!mining_shuttle_moving)
			usr << "\blue shuttle called and will arrive shortly"
			move_mining_shuttle()
		else
			usr << "\blue shuttle is already moving"

/obj/machinery/computer/ruskie_shuttle/attackby(obj/item/weapon/W as obj, mob/user as mob) //emagging it

	if (istype(W, /obj/item/weapon/card/emag))
		src.req_access = list()
		hacked = 1
		usr << "The computer's controls are now all access"
