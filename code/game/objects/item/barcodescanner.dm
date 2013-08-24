
/obj/item/weapon/barcodescanner
	name = "barcode scanner"
	icon = 'library.dmi'
	icon_state ="scanner"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
	flags = FPRINT | TABLEPASS
	var
		obj/machinery/librarycomp/computer // Associated computer - Modes 1 to 3 use this
		obj/item/book/book	 //  Currently scanned book
		mode = 0 					// 0 - Scan only, 1 - Scan and Set Buffer, 2 - Scan and Attempt to Check In, 3 - Scan and Attempt to Add to Inventory

	attack_self(mob/user as mob)
		mode += 1
		if (mode > 3)
			mode = 0
		user << "[src] Status Display:"
		var/modedesc
		switch(mode)
			if (0)
				modedesc = "Scan book to local buffer."
			if (1)
				modedesc = "Scan book to local buffer and set associated computer buffer to match."
			if (2)
				modedesc = "Scan book to local buffer, attempt to check in scanned book."
			if (3)
				modedesc = "Scan book to local buffer, attempt to add book to general inventory."
			else
				modedesc = "ERROR"
		user << " - Mode [mode] : [modedesc]"
		if (src.computer)
			user << "<font color=green>Computer has been associated with this unit.</font>"
		else
			user << "<font color=red>No associated computer found. Only local scans will function properly.</font>"
		user << "\n"
