
/obj/machinery/computer/rdservercontrol
	name = "R&D Server Controller"
	icon_state = "rdcomp"
	var
		screen = 0
		obj/machinery/r_n_d/server/temp_server
		list
			servers = list()
			consoles = list()
		badmin = 0
		emagged = 0

	Topic(href, href_list)
		if(..())
			return

		add_fingerprint(usr)
		usr.machine = src
		if(!src.allowed(usr) && !emagged)
			usr << "\red You do not have the required access level"
			return

		if(href_list["main"])
			screen = 0

		else if(href_list["access"] || href_list["data"] || href_list["transfer"])
			temp_server = null
			consoles = list()
			servers = list()
			for(var/obj/machinery/r_n_d/server/S in world)
				if(S.server_id == text2num(href_list["access"]) || S.server_id == text2num(href_list["data"]) || S.server_id == text2num(href_list["transfer"]))
					temp_server = S
					break
			if(href_list["access"])
				screen = 1
				for(var/obj/machinery/computer/rdconsole/C in world)
					if(C.sync)
						consoles += C
			else if(href_list["data"])
				screen = 2
			else if(href_list["transfer"])
				screen = 3
				for(var/obj/machinery/r_n_d/server/S in world)
					if(S == src)
						continue
					servers += S

		else if(href_list["upload_toggle"])
			var/num = text2num(href_list["upload_toggle"])
			if(num in temp_server.id_with_upload)
				temp_server.id_with_upload -= num
			else
				temp_server.id_with_upload += num

		else if(href_list["download_toggle"])
			var/num = text2num(href_list["download_toggle"])
			if(num in temp_server.id_with_download)
				temp_server.id_with_download -= num
			else
				temp_server.id_with_download += num

		else if(href_list["reset_tech"])
			var/choice = alert("Technology Data Rest", "Are you sure you want to reset this technology to it's default data? Data lost cannot be recovered.", "Continue", "Cancel")
			if(choice == "Continue")
				for(var/datum/tech/T in temp_server.files.known_tech)
					if(T.id == href_list["reset_tech"])
						T.level = 1
						break
			temp_server.files.RefreshResearch()

		else if(href_list["reset_design"])
			var/choice = alert("Design Data Deletion", "Are you sure you want to delete this design? If you still have the prerequisites for the design, it'll reset to it's base reliability. Data lost cannot be recovered.", "Continue", "Cancel")
			if(choice == "Continue")
				for(var/datum/design/D in temp_server.files.known_designs)
					if(D.id == href_list["reset_design"])
						D.reliability_mod = 0
						temp_server.files.known_designs -= D
						break
			temp_server.files.RefreshResearch()

		updateUsrDialog()
		return

	attack_hand(mob/user as mob)
		if(stat & (BROKEN|NOPOWER))
			return
		user.machine = src
		var/dat = ""

		switch(screen)
			if(0) //Main Menu
				dat += "Connected Servers:<BR><BR>"

				for(var/obj/machinery/r_n_d/server/S in world)
					if(istype(S, /obj/machinery/r_n_d/server/centcom) && !badmin)
						continue
					dat += "[S.name] || "
					dat += "<A href='?src=\ref[src];access=[S.server_id]'> Access Rights</A> | "
					dat += "<A href='?src=\ref[src];data=[S.server_id]'>Data Management</A>"
					if(badmin) dat += " | <A href='?src=\ref[src];transfer=[S.server_id]'>Server-to-Server Transfer</A>"
					dat += "<BR>"

			if(1) //Access rights menu
				dat += "[temp_server.name] Access Rights<BR><BR>"
				dat += "Consoles with Upload Access<BR>"
				for(var/obj/machinery/computer/rdconsole/C in consoles)
					var/turf/console_turf = get_turf(C)
					dat += "* <A href='?src=\ref[src];upload_toggle=[C.id]'>[console_turf.loc]" //FYI, these are all numeric ids, eventually.
					if(C.id in temp_server.id_with_upload)
						dat += " (Remove)</A><BR>"
					else
						dat += " (Add)</A><BR>"
				dat += "Consoles with Download Access<BR>"
				for(var/obj/machinery/computer/rdconsole/C in consoles)
					var/turf/console_turf = get_turf(C)
					dat += "* <A href='?src=\ref[src];download_toggle=[C.id]'>[console_turf.loc]"
					if(C.id in temp_server.id_with_download)
						dat += " (Remove)</A><BR>"
					else
						dat += " (Add)</A><BR>"
				dat += "<HR><A href='?src=\ref[src];main=1'>Main Menu</A>"

			if(2) //Data Management menu
				dat += "[temp_server.name] Data ManagementP<BR><BR>"
				dat += "Known Technologies<BR>"
				for(var/datum/tech/T in temp_server.files.known_tech)
					dat += "* [T.name] "
					dat += "<A href='?src=\ref[src];reset_tech=[T.id]'>(Reset)</A><BR>" //FYI, these are all strings.
				dat += "Known Designs<BR>"
				for(var/datum/design/D in temp_server.files.known_designs)
					dat += "* [D.name] "
					dat += "<A href='?src=\ref[src];reset_design=[D.id]'>(Delete)</A><BR>"
				dat += "<HR><A href='?src=\ref[src];main=1'>Main Menu</A>"

			if(3) //Server Data Transfer
				dat += "[temp_server.name] Server to Server Transfer<BR><BR>"
				dat += "Send Data to what server?<BR>"
				for(var/obj/machinery/r_n_d/server/S in servers)
					dat += "[S.name] <A href='?src=\ref[src];send_to=[S.server_id]'> (Transfer)</A><BR>"
				dat += "<HR><A href='?src=\ref[src];main=1'>Main Menu</A>"
		user << browse("<TITLE>R&D Server Control</TITLE><HR>[dat]", "window=server_control;size=575x400")
		onclose(user, "server_control")
		return

	attackby(var/obj/item/weapon/D as obj, var/mob/user as mob)
		if(istype(D, /obj/item/weapon/screwdriver))
			playsound(src.loc, 'Screwdriver.ogg', 50, 1)
			if(do_after(user, 20))
				if (src.stat & BROKEN)
					user << "\blue The broken glass falls out."
					var/obj/computerframe/A = new /obj/computerframe( src.loc )
					new /obj/item/weapon/shard( src.loc )
					var/obj/item/weapon/circuitboard/rdservercontrol/M = new /obj/item/weapon/circuitboard/rdservercontrol( A )
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
					var/obj/item/weapon/circuitboard/rdservercontrol/M = new /obj/item/weapon/circuitboard/rdservercontrol( A )
					for (var/obj/C in src)
						C.loc = src.loc
					A.circuit = M
					A.state = 4
					A.icon_state = "4"
					A.anchored = 1
					del(src)
		else if(istype(D, /obj/item/weapon/card/emag) && !emagged)
			playsound(src.loc, 'sparks4.ogg', 75, 1)
			emagged = 1
			user << "\blue You you disable the security protocols"
		src.updateUsrDialog()
		return
