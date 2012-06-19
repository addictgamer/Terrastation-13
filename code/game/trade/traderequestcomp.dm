/obj/machinery/computer/traderequestcomp
	name = "Trade request console"
	icon = 'computer.dmi'
	icon_state = "request"
	circuit = "/obj/item/weapon/circuitboard/tradeordercomp"
	var/temp = null

/obj/item/weapon/circuitboard/traderequestcomp
	name = "Circuit board (Trading console)"
	build_path = "/obj/machinery/computer/tradecomp"
	origin_tech = "programming=2"


/obj/machinery/computer/traderequestcomp/attack_ai(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/traderequestcomp/attack_paw(var/mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/computer/traderequestcomp/attack_hand(var/mob/user as mob)
	if(..())
		return
	user.machine = src
	var/dat
	if (src.temp)
		dat = src.temp
	else

		dat += {"<BR><B>Trade shuttle</B><HR>
		Location: [trade_shuttle_moving ? "Moving to station ([trade_shuttle_timeleft] Mins.)":trade_shuttle_at_station ? "Station":"Dock"]<BR>
		<BR>\n<A href='?src=\ref[src];order=1'>Request items</A><BR><BR>
		<A href='?src=\ref[src];vieworders=1'>View approved orders</A><BR><BR>
		<A href='?src=\ref[src];viewrequests=1'>View requests</A><BR><BR>
		<A href='?src=\ref[user];mach_close=computer'>Close</A>"}

	user << browse(dat, "window=computer;size=575x450")
	onclose(user, "computer")
	return


/obj/machinery/computer/traderequestcomp/Topic(href, href_list)
	if(..())
		return

	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.machine = src

	if (href_list["order"])
		src.temp = "<BR>Request what?<BR><BR>"
		for(var/S in (typesof(/datum/trade_packs) - /datum/trade_packs) )
			var/datum/trade_packs/N = new S()
			if(N.hidden) continue																	//Have to send the type instead of a reference to
			src.temp += "<A href='?src=\ref[src];doorder=[N.type]'>[N.name]"   						 //the obj because it would get caught by the garbage
			src.temp += "<A href='?src=\ref[src];printform=[N.type]'>Print Requisition</A><br>"     //collector. oh well.
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["doorder"])
		var/datum/trade_order/O = new/datum/trade_order ()
		var/tradetype = href_list["doorder"]
		var/datum/trade_packs/P = new tradetype ()
		O.object = P
		O.orderedby = usr.name
		trade_shuttle_requestlist += O
		src.temp = "Thanks for your request. The cargo team will process it as soon as possible.<BR>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["printform"])
		var/tradetype = href_list["printform"]
		var/datum/trade_packs/P = new tradetype ()
		var/obj/item/weapon/paper/reqform = new /obj/item/weapon/paper(src.loc)
		var/idname = "Unknown"
		var/idrank = "Unknown"
		var/reason = input(usr,"Reason:","Why do you require this item?","")

		reqform.name = "Requisition Form - [P.name]"
		reqform.info += "<h3>[station_name] Supply Requisition Form</h3><hr>"

		if (istype(usr:wear_id, /obj/item/weapon/card/id))
			if(usr:wear_id.registered)
				idname = usr:wear_id.registered
			if(usr:wear_id.assignment)
				idrank = usr:wear_id.assignment
		if (istype(usr:wear_id, /obj/item/device/pda))
			var/obj/item/device/pda/pda = usr:wear_id
			if(pda.owner)
				idname = pda.owner
			if(pda.ownjob)
				idrank = pda.ownjob
		else
			idname = usr.name

		reqform.info += "REQUESTED BY: [idname]<br>"
		reqform.info += "RANK: [idrank]<br>"
		reqform.info += "REASON: [reason]<br>"
		reqform.info += "TRADE ITEM TYPE: [P.name]<br>"
		reqform.info += "Contents:<br><ul>"

		for(var/B in P.contains)
			var/thepath = text2path(B)
			var/atom/B2 = new thepath ()
			reqform.info += "<li>[B2.name]</li>"
		reqform.info += "</ul><hr>"
		reqform.info += "STAMP BELOW TO APPROVE THIS REQUISITION:<br>"

	else if (href_list["vieworders"])
		src.temp = "Current approved orders: <BR><BR>"
		for(var/S in trade_shuttle_shoppinglist)
			var/datum/trade_order/SO = S
			src.temp += "[SO.object.name] approved by [SO.orderedby]<BR>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["viewrequests"])
		src.temp = "Current requests: <BR><BR>"
		for(var/S in trade_shuttle_requestlist)
			var/datum/trade_order/SO = S
			src.temp += "[SO.object.name] requested by [SO.orderedby]<BR>"
		src.temp += "<BR><A href='?src=\ref[src];mainmenu=1'>OK</A>"

	else if (href_list["mainmenu"])
		src.temp = null

	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return