//Used for ordering trades.

/obj/machinery/computer/tradecomp
	name = "Trading console"
	icon = 'computer.dmi'
	icon_state = "supply"
	req_access = list(access_cargo)
	circuit = "/obj/item/weapon/circuitboard/tradecomp"
	var/temp = null
	var/hacked = 0

/obj/item/weapon/circuitboard/tradecomp
	name = "Circuit board (Trading console)"
	build_path = "/obj/machinery/computer/tradecomp"
	origin_tech = "programming=2"

/obj/machinery/computer/tradecomp/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/tradecomp/attack_paw(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/tradecomp/attack_hand(var/mob/user as mob)
	if(!src.allowed(user))
		user << "\red Access Denied."
		return

	if(..())
		return
	user.machine = src
	post_signal("trade")
	var/dat
	if (src.temp)
		dat = src.temp
	else
		dat += {"<BR><B>Trade shuttle</B><HR>
		\nLocation: [trade_shuttle_moving ? "Moving to station ([trade_shuttle_timeleft] Mins.)":trade_shuttle_at_station ? "Station":"Dock"]<BR>
		["\n<A href='?src=\ref[src];order=1'>Order items</A><BR>\n<BR>"]
		\n<A href='?src=\ref[src];viewrequests=1'>View requests</A><BR>\n<BR>
		\n<A href='?src=\ref[src];vieworders=1'>View orders</A><BR>\n<BR>
		\n<A href='?src=\ref[user];mach_close=computer'>Close</A>"}

	user << browse(dat, "window=computer;size=575x450")
	onclose(user, "computer")
	return


/obj/machinery/computer/tradecomp/attackby(I as obj, user as mob)
	/*if(istype(I,/obj/item/weapon/card/emag) && !hacked)
		user << "\blue Special supplies unlocked."
		src.hacked = 1
		return*/ //TODO: Maybe open up some kind of black market?
	if(istype(I, /obj/item/weapon/screwdriver))
		playsound(src.loc, 'Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			if (src.stat & BROKEN)
				user << "\blue The broken glass falls out."
				var/obj/computerframe/A = new /obj/computerframe( src.loc )
				new /obj/item/weapon/shard( src.loc )
				var/obj/item/weapon/circuitboard/tradecomp/M = new /obj/item/weapon/circuitboard/tradecomp( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 3
				A.icon_state = "3"
				A.anchored = 1
				del(src)
			else
				user << "\blue You disconnect the monitor."
				var/obj/computerframe/A = new /obj/computerframe( src.loc )
				var/obj/item/weapon/circuitboard/tradecomp/M = new /obj/item/weapon/circuitboard/tradecomp( A )
				for (var/obj/C in src)
					C.loc = src.loc
				A.circuit = M
				A.state = 4
				A.icon_state = "4"
				A.anchored = 1
				del(src)
	else
		src.attack_hand(user)
	return







/obj/machinery/computer/tradecomp/Topic(href, href_list)
	if(..())
		return

	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.machine = src

	/*if (href_list["sendtodock"])
		if(!supply_shuttle_at_station || supply_shuttle_moving) return

		//if (!supply_can_move())
		//	usr << "\red The supply shuttle can not transport station employees or homing beacons."
		//	return

		src.temp = "Shuttle sent.<BR><BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
		src.updateUsrDialog()
		post_signal("supply")

		supply_shuttle_shoppinglist = null
		supply_shuttle_shoppinglist = new/list()

		sell_crates()
		send_supply_shuttle()*/

	/*else if (href_list["sendtostation"])
		if(supply_shuttle_at_station || supply_shuttle_moving) return

		//if (!supply_can_move())
		//	usr << "\red The supply shuttle can not transport station employees or homing beacons."
		//	return

		post_signal("supply")
		usr << "\blue The supply shuttle has been called and will arrive in [round(((SUPPLY_MOVETIME/10)/60))] minutes."

		src.temp = "Shuttle sent.<BR><BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
		src.updateUsrDialog()

		supply_shuttle_moving = 1

		process_supply_order()

		supply_shuttle_time = world.timeofday + SUPPLY_MOVETIME
		spawn(0)
			supply_process()*/

	if (href_list["order"])
		for(var/S in (typesof(/datum/trade_packs) - /datum/trade_packs) )
			var/datum/trade_packs/N = new S()
			if(N.hidden && !src.hacked) continue													//Have to send the type instead of a reference to
			src.temp += "<A href='?src=\ref[src];doorder=[N.type]'>[N.name]</A><BR>" 				//the obj because it would get caught by the garbage
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"								//collector. oh well.

	else if (href_list["doorder"])

		if(locate(href_list["doorder"])) //Comes from the requestlist
			var/datum/trade_order/O = locate(href_list["doorder"])
			var/datum/trade_packs/P = O.object
			trade_shuttle_requestlist -= O

		else							//Comes from the orderform
			var/datum/trade_order/O = new/datum/trade_order ()
			var/tradetype = href_list["doorder"]
			var/datum/trade_packs/P = new tradetype ()
			O.object = P
			O.orderedby = usr.name
			trade_shuttle_shoppinglist += O
			src.temp = "This item has been requested at the galactic trade market.<BR>"
			src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["vieworders"])
		src.temp = "Current approved orders: <BR><BR>"
		for(var/S in trade_shuttle_shoppinglist)
			var/datum/trade_order/SO = S
			src.temp += "[SO.object.name] approved by [SO.orderedby]<BR>"// <A href='?src=\ref[src];cancelorder=[S]'>(Cancel)</A><BR>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
/*
	else if (href_list["cancelorder"])
		var/datum/supply_order/remove_supply = href_list["cancelorder"]
		supply_shuttle_shoppinglist -= remove_supply
		supply_shuttle_points += remove_supply.object.cost
		src.temp += "Canceled: [remove_supply.object.name]<BR><BR><BR>"

		for(var/S in supply_shuttle_shoppinglist)
			var/datum/supply_order/SO = S
			src.temp += "[SO.object.name] approved by [SO.orderedby][SO.comment ? " ([SO.comment])":""] <A href='?src=\ref[src];cancelorder=[S]'>(Cancel)</A><BR>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
*/
	else if (href_list["viewrequests"])
		src.temp = "Current requests: <BR><BR>"
		for(var/S in trade_shuttle_requestlist)
			var/datum/trade_order/SO = S
			src.temp += "[SO.object.name] requested by [SO.orderedby]  <A href='?src=\ref[src];doorder=\ref[SO]'>Approve</A> <A href='?src=\ref[src];rreq=\ref[SO]'>Remove</A><BR>"

		src.temp += "<BR><A href='?src=\ref[src];clearreq=1'>Clear list</A>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["rreq"])
		trade_shuttle_requestlist -= locate(href_list["rreq"])
		src.temp = "Request removed.<BR>"
		src.temp += "<BR><A href='?src=\ref[src];viewrequests=1'>OK</A>"

	else if (href_list["clearreq"])
		trade_shuttle_requestlist = null
		trade_shuttle_requestlist = new/list()
		src.temp = "List cleared.<BR>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["mainmenu"])
		src.temp = null

	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return

/obj/machinery/computer/tradecomp/proc/post_signal(var/command)

	var/datum/radio_frequency/frequency = radio_controller.return_frequency(1435)

	if(!frequency) return

	var/datum/signal/status_signal = new
	status_signal.source = src
	status_signal.transmission_method = 1
	status_signal.data["command"] = command

	frequency.post_signal(src, status_signal)