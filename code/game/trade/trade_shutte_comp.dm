/obj/machinery/computer/tradeshuttlecomp
	name = "Trade Shuttle Console - Buy your stuff here."
	icon = 'trade.dmi'
	icon_state = "tradeshuttle_console"
	req_access = list(access_cargo)
	circuit = "/obj/item/weapon/circuitboard/tradecomp"
	var/temp = null
	var/hacked = 0

/obj/item/weapon/circuitboard/tradeshuttlecomp
	name = "Circuit board (Trade shuttle console)"
	build_path = "/obj/machinery/computer/tradecomp"
	origin_tech = "programming=2"

/obj/machinery/computer/tradeshuttlecomp/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/tradeshuttlecomp/attack_paw(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/tradeshuttlecomp/attack_hand(var/mob/user as mob)
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
		<HR>Account status: [trade_shuttle_money_inserted] moneys<BR>
		\n<A href='?src=\ref[src];order=1'>Purchase items</A><BR>\n<BR>
		\n<A href='?src=\ref[src];viewrequests=1'>View requests</A><BR>\n<BR>
		\n<A href='?src=\ref[user];mach_close=computer'>Close</A>"}

	user << browse(dat, "window=computer;size=575x450")
	onclose(user, "computer")
	return

/obj/machinery/computer/tradeshuttlecomp/Topic(href, href_list)
	if(..())
		return

	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.machine = src

	if (href_list["order"])
		if(trade_shuttle_moving) return
		src.temp = "Account status: [trade_shuttle_money_inserted] moneys<BR><HR><BR>Purchase what?<BR><BR>"
		for(var/S in (typesof(/datum/trade_packs) - /datum/trade_packs) )
			var/datum/trade_packs/N = new S()
			if(N.hidden) continue													//Have to send the type instead of a reference to
			src.temp += "<A href='?src=\ref[src];doorder=[N.type]'>[N.name]</A> Cost: [N.cost]<BR>" //the obj because it would get caught by the garbage
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"								//collector. oh well.

	else if (href_list["doorder"])

		if(locate(href_list["doorder"])) //Comes from the requestlist
			var/datum/trade_order/O = locate(href_list["doorder"])
			var/datum/trade_packs/P = O.object
			trade_shuttle_requestlist -= O

			if(trade_shuttle_money_inserted >= P.cost)
				trade_shuttle_money_inserted -= P.cost
				O.object = P
				O.orderedby = usr.name
				O.comment = input(usr,"Comment:","Enter comment","")
				trade_shuttle_shoppinglist += O
				src.temp = "Thanks for your purchase.<BR>"
				src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
				process_trade_order()
			else
				src.temp = "Not enough money.<BR>"
				src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

		else							//Comes from the orderform
			var/datum/trade_order/O = new/datum/trade_order ()
			var/tradetype = href_list["doorder"]
			var/datum/trade_packs/P = new tradetype ()
			if(trade_shuttle_money_inserted >= P.cost)
				O.object = P
				O.orderedby = usr.name
				O.comment = input(usr,"Comment:","Enter comment","")
				var/count = 12
				count = input(usr, "Ammount:","Enter ammount","") as num
				var/i = 0
				while(i < count)
					if(trade_shuttle_money_inserted >= P.cost)
						trade_shuttle_shoppinglist += O
						trade_shuttle_money_inserted -= P.cost
					i++
				src.temp = "Thanks for your purchase.<BR>"
				src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"
				process_trade_order()
			else
				src.temp = "Not enough money.<BR>"

	else if (href_list["viewrequests"])
		src.temp = "Current requests: <BR><BR>"
		for(var/S in trade_shuttle_requestlist)
			var/datum/trade_order/SO = S
			src.temp += "[SO.object.name] requested by [SO.orderedby]  [trade_shuttle_moving ? "":trade_shuttle_at_station ? "":"<A href='?src=\ref[src];doorder=\ref[SO]'>Approve</A> <A href='?src=\ref[src];rreq=\ref[SO]'>Remove</A>"]<BR>"

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

/obj/machinery/computer/tradeshuttlecomp/proc/post_signal(var/command)

	var/datum/radio_frequency/frequency = radio_controller.return_frequency(1435)

	if(!frequency) return

	var/datum/signal/status_signal = new
	status_signal.source = src
	status_signal.transmission_method = 1
	status_signal.data["command"] = command

	frequency.post_signal(src, status_signal)