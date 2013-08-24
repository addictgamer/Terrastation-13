
/obj/machinery/mineral/processing_unit_console
	name = "Produciton machine console"
	icon = 'mining_machines.dmi'
	icon_state = "console"
	density = 1
	anchored = 1
	var/obj/machinery/mineral/processing_unit/machine = null

/obj/machinery/mineral/processing_unit_console/New()
	..()
	spawn(7)
		src.machine = locate(/obj/machinery/mineral/processing_unit, get_step(src, EAST))
		if (machine)
			machine.CONSOLE = src
		else
			del(src)

/obj/machinery/mineral/processing_unit_console/attack_hand(user as mob)

	var/dat = "<b>Smelter control console</b><br><br>"
	//iron
	if (machine.ore_iron || machine.ore_glass || machine.ore_plasma || machine.ore_uranium || machine.ore_gold || machine.ore_silver || machine.ore_diamond || machine.ore_clown || machine.ore_adamantine)
		if (machine.ore_iron)
			if (machine.selected_iron==1)
				dat += text("<A href='?src=\ref[src];sel_iron=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_iron=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Iron: [machine.ore_iron]<br>")
		else
			machine.selected_iron = 0

		//sand - glass
		if (machine.ore_glass)
			if (machine.selected_glass==1)
				dat += text("<A href='?src=\ref[src];sel_glass=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_glass=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Sand: [machine.ore_glass]<br>")
		else
			machine.selected_glass = 0

		//plasma
		if (machine.ore_plasma)
			if (machine.selected_plasma==1)
				dat += text("<A href='?src=\ref[src];sel_plasma=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_plasma=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Plasma: [machine.ore_plasma]<br>")
		else
			machine.selected_plasma = 0

		//uranium
		if (machine.ore_uranium)
			if (machine.selected_uranium==1)
				dat += text("<A href='?src=\ref[src];sel_uranium=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_uranium=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Uranium: [machine.ore_uranium]<br>")
		else
			machine.selected_uranium = 0

		//gold
		if (machine.ore_gold)
			if (machine.selected_gold==1)
				dat += text("<A href='?src=\ref[src];sel_gold=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_gold=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Gold: [machine.ore_gold]<br>")
		else
			machine.selected_gold = 0

		//silver
		if (machine.ore_silver)
			if (machine.selected_silver==1)
				dat += text("<A href='?src=\ref[src];sel_silver=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_silver=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Silver: [machine.ore_silver]<br>")
		else
			machine.selected_silver = 0

		//diamond
		if (machine.ore_diamond)
			if (machine.selected_diamond==1)
				dat += text("<A href='?src=\ref[src];sel_diamond=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_diamond=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Diamond: [machine.ore_diamond]<br>")
		else
			machine.selected_diamond = 0

		//bananium
		if (machine.ore_clown)
			if (machine.selected_clown==1)
				dat += text("<A href='?src=\ref[src];sel_clown=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_clown=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Bananium: [machine.ore_clown]<br>")
		else
			machine.selected_clown = 0

		//adamantine
		if (machine.ore_adamantine)
			if (machine.selected_adamantine==1)
				dat += text("<A href='?src=\ref[src];sel_adamantine=no'><font color='green'>Smelting</font></A> ")
			else
				dat += text("<A href='?src=\ref[src];sel_adamantine=yes'><font color='red'>Not smelting</font></A> ")
			dat += text("Adamantine: [machine.ore_adamantine]<br>")
		else
			machine.selected_adamantine = 0


		//On or off
		dat += text("Machine is currently ")
		if (machine.on==1)
			dat += text("<A href='?src=\ref[src];set_on=off'>On</A> ")
		else
			dat += text("<A href='?src=\ref[src];set_on=on'>Off</A> ")
	else
		dat+="---No Materials Loaded---"


	user << browse("[dat]", "window=console_processing_unit")



/obj/machinery/mineral/processing_unit_console/Topic(href, href_list)
	if (..())
		return
	usr.machine = src
	src.add_fingerprint(usr)
	if (href_list["sel_iron"])
		if (href_list["sel_iron"] == "yes")
			machine.selected_iron = 1
		else
			machine.selected_iron = 0
	if (href_list["sel_glass"])
		if (href_list["sel_glass"] == "yes")
			machine.selected_glass = 1
		else
			machine.selected_glass = 0
	if (href_list["sel_plasma"])
		if (href_list["sel_plasma"] == "yes")
			machine.selected_plasma = 1
		else
			machine.selected_plasma = 0
	if (href_list["sel_uranium"])
		if (href_list["sel_uranium"] == "yes")
			machine.selected_uranium = 1
		else
			machine.selected_uranium = 0
	if (href_list["sel_gold"])
		if (href_list["sel_gold"] == "yes")
			machine.selected_gold = 1
		else
			machine.selected_gold = 0
	if (href_list["sel_silver"])
		if (href_list["sel_silver"] == "yes")
			machine.selected_silver = 1
		else
			machine.selected_silver = 0
	if (href_list["sel_diamond"])
		if (href_list["sel_diamond"] == "yes")
			machine.selected_diamond = 1
		else
			machine.selected_diamond = 0
	if (href_list["sel_clown"])
		if (href_list["sel_clown"] == "yes")
			machine.selected_clown = 1
		else
			machine.selected_clown = 0
	if (href_list["sel_adamantine"])
		if (href_list["sel_adamantine"] == "yes")
			machine.selected_adamantine = 1
		else
			machine.selected_adamantine =0
	if (href_list["set_on"])
		if (href_list["set_on"] == "on")
			machine.on = 1
		else
			machine.on = 0
	src.updateUsrDialog()
	return
