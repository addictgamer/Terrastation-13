
/obj/machinery/chem_dispenser
	name = "chem dispenser"
	density = 1
	anchored = 1
	icon = 'chemical.dmi'
	icon_state = "dispenser"
	var/energy = 25
	var/max_energy = 25
	var/list/dispensable_reagents = list("hydrogen","lithium","carbon","nitrogen","oxygen","fluorine","sodium","aluminum","silicon","phosphorus","sulfur","chlorine","potassium","iron","copper","mercury","radium","water","ethanol","sugar","acid",)
	proc
		recharge()
			if (stat & BROKEN) return
			if (energy != max_energy)
				energy++
				use_power(50)
			spawn(600) recharge()

	New()
		recharge()

	ex_act(severity)
		switch(severity)
			if (1.0)
				del(src)
				return
			if (2.0)
				if (prob(50))
					del(src)
					return

	blob_act()
		if (prob(50))
			del(src)

	meteorhit()
		del(src)
		return

	Topic(href, href_list)
		if (stat & BROKEN) return
		if (usr.stat || usr.restrained()) return
		if (!in_range(src, usr)) return

		usr.machine = src

		if (href_list["dispense"])
			if (!energy)
				var/dat = "Not enough energy.<BR><A href='?src=\ref[src];ok=1'>OK</A>"
				usr << browse("<TITLE>Chemical Dispenser</TITLE>Chemical dispenser:<BR>Energy = [energy]/[max_energy]<BR><BR>[dat]", "window=chem_dispenser")
				return
			var/id = href_list["dispense"]
			var/obj/item/weapon/reagent_containers/glass/dispenser/G = new/obj/item/weapon/reagent_containers/glass/dispenser(src.loc)
			switch(text2num(href_list["state"]))
				if (LIQUID)
					G.icon_state = "liquid"
				if (GAS)
					G.icon_state = "vapour"
				if (SOLID)
					G.icon_state = "solid"
			G.pixel_x = rand(-7, 7)
			G.pixel_y = rand(-7, 7)
			G.name += " ([lowertext(href_list["name"])])"
			G.reagents.add_reagent(id,30)
			energy--
			src.updateUsrDialog()
			return
		else
			usr << browse(null, "window=chem_dispenser")
			return

		src.add_fingerprint(usr)
		return

	attack_ai(mob/user as mob)
		return src.attack_hand(user)

	attack_paw(mob/user as mob)
		return src.attack_hand(user)

	attack_hand(mob/user as mob)
		if (stat & BROKEN)
			return
		user.machine = src
		var/dat = ""
		for(var/re in dispensable_reagents)
			for(var/da in typesof(/datum/reagent) - /datum/reagent)
				var/datum/reagent/temp = new da()
				if (temp.id == re)
					dat += "<A href='?src=\ref[src];dispense=[temp.id];state=[temp.reagent_state];name=[temp.name]'>[temp.name]</A><BR>"
					dat += "[temp.description]<BR><BR>"
		user << browse("<TITLE>Chemical Dispenser</TITLE>Chemical dispenser:<BR>Energy = [energy]/[max_energy]<BR><BR>[dat]", "window=chem_dispenser")

		onclose(user, "chem_dispenser")
		return
