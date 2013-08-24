
// TODO: Make this an actual /obj/machinery/computer that can be crafted from circuit boards and such

/obj/machinery/librarycomp
	name = "Check-In/Out Computer"
	icon = 'library.dmi'
	icon_state = "computer"
	anchored = 1
	density = 1
	var
		emagged = 0
		arcanecheckout = 0
		screenstate = 0 // 0 - Main Menu, 1 - Inventory, 2 - Checked Out, 3 - Check Out a Book
		buffer_book
		buffer_mob
		upload_category = "Fiction"
		list/checkouts = list()
		list/inventory = list()
		checkoutperiod = 5 // In minutes
		obj/machinery/libraryscanner/scanner // Book scanner that will be used when uploading books to the Archive

		bibledelay = 0 // LOL NO SPAM (1 minute delay) -- Doohl

/obj/machinery/librarycomp/attack_hand(var/mob/user as mob)
	usr.machine = src
	var/dat = "<HEAD><TITLE>Book Inventory Management</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	switch(screenstate)
		if (0)
			// Main Menu
			dat += "<A href='?src=\ref[src];switchscreen=1'>1. View General Inventory</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=2'>2. View Checked Out Inventory</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=3'>3. Check out a Book</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=4'>4. Connect to External Archive</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=5'>5. Upload New Title to Archive</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=6'>6. Print a Bible</A><BR>"
			if (src.emagged)
				dat += "<A href='?src=\ref[src];switchscreen=7'>7. Access the Forbidden Lore Vault</A><BR>"
			if (src.arcanecheckout)
				new /obj/item/weapon/tome(src.loc)
				user << "<font color=red>Your sanity barely endures the seconds spent in the vault's browsing window. The only thing to remind you of this when you stop browsing is a dusty old tome sitting on the desk. You don't really remember printing it.</font>"
				for (var/mob/V in hearers(src))
					V.show_message("[usr] stares at the blank screen for a few moments, his expression frozen in fear. When he finally awakens from it, he looks a lot older.", 2)
				src.arcanecheckout = 0
		if (1)
			// Inventory
			dat += "<H3>Inventory</H3><BR>"
			for(var/obj/item/book/b in inventory)
				dat += "[b.name] <A href='?src=\ref[src];delbook=\ref[b]'>(Delete)</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if (2)
			// Checked Out
			dat += "<h3>Checked Out Books</h3><BR>"
			for(var/datum/borrowbook/b in checkouts)
				var/timetaken = world.time - b.getdate
				//timetaken *= 10
				timetaken /= 600
				timetaken = round(timetaken)
				var/timedue = b.duedate - world.time
				//timedue *= 10
				timedue /= 600
				if (timedue <= 0)
					timedue = "<font color=red><b>(OVERDUE)</b> [timedue]</font>"
				else
					timedue = round(timedue)
				dat += "\"[b.bookname]\", Checked out to: [b.mobname]<BR>--- Taken: [timetaken] minutes ago, Due: in [timedue] minutes<BR>"
				dat += "<A href='?src=\ref[src];checkin=\ref[b]'>(Check In)</A><BR><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if (3)
			// Check Out a Book
			dat += "<h3>Check Out a Book</h3><BR>"
			dat += "Book: [src.buffer_book] "
			dat += "<A href='?src=\ref[src];editbook=1'>\[Edit\]</A><BR>"
			dat += "Recipient: [src.buffer_mob] "
			dat += "<A href='?src=\ref[src];editmob=1'>\[Edit\]</A><BR>"
			dat += "Checkout Date : [world.time/600]<BR>"
			dat += "Due Date: [(world.time + checkoutperiod)/600]<BR>"
			dat += "(Checkout Period: [checkoutperiod] minutes) (<A href='?src=\ref[src];increasetime=1'>+</A>/<A href='?src=\ref[src];decreasetime=1'>-</A>)"
			dat += "<A href='?src=\ref[src];checkout=1'>(Commit Entry)</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if (4)
			dat += "<h3>External Archive</h3>"
			var/DBConnection/dbcon = new()
			dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
			if (!dbcon.IsConnected())
				dat += "<font color=red><b>ERROR</b>: Unable to contact External Archive. Please contact your system administrator for assistance.</font>"
			else
				dat += "<A href='?src=\ref[src];orderbyid=1'>(Order book by SS<sup>13</sup>BN)</A><BR><BR>"
				dat += "<table>"
				dat += "<tr><td>AUTHOR</td><td>TITLE</td><td>CATEGORY</td><td></td></tr>"

				var/DBQuery/query = dbcon.NewQuery("SELECT id, author, title, category FROM library")
				query.Execute()

				while(query.NextRow())
					var/id = query.item[1]
					var/author = query.item[2]
					var/title = query.item[3]
					var/category = query.item[4]
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td><A href='?src=\ref[src];targetid=[id]'>\[Order\]</A></td></tr>"
				dat += "</table><BR>"
				dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
			dbcon.Disconnect()
		if (5)
			dat += "<H3>Upload a New Title</H3>"
			if (!scanner)
				for(var/obj/machinery/libraryscanner/S in range(9))
					scanner = S
					break
			if (!scanner)
				dat += "<FONT color=red>No scanner found within wireless network range.</FONT><BR>"
			else if (!scanner.cache)
				dat += "<FONT color=red>No data found in scanner memory.</FONT><BR>"
			else
				dat += "<TT>Data marked for upload...</TT><BR>"
				dat += "<TT>Title: </TT>[scanner.cache.name]<BR>"
				if (!scanner.cache.author)
					scanner.cache.author = "Anonymous"
				dat += "<TT>Author: </TT><A href='?src=\ref[src];setauthor=1'>[scanner.cache.author]</A><BR>"
				dat += "<TT>Category: </TT><A href='?src=\ref[src];setcategory=1'>[upload_category]</A><BR>"
				dat += "<A href='?src=\ref[src];upload=1'>\[Upload\]</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if (7)
			dat += "<h3>Accessing Forbidden Lore Vault v 1.3</h3>"
			dat += "Are you absolutely sure you want to proceed? EldritchTomes Inc. takes no responsibilities for loss of sanity resulting from this action.<p>"
			dat += "<A href='?src=\ref[src];arccheckout=1'>Yes.</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>No.</A><BR>"

	//dat += "<A HREF='?src=\ref[user];mach_close=library'>Close</A><br><br>"
	user << browse(dat, "window=library")
	onclose(user, "library")

/obj/machinery/librarycomp/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (src.density && istype(W, /obj/item/weapon/card/emag))
		src.emagged = 1
	if (istype(W, /obj/item/weapon/barcodescanner))
		var/obj/item/weapon/barcodescanner/scanner = W
		scanner.computer = src
		user << "[scanner]'s associated machine has been set to [src]."
		for (var/mob/V in hearers(src))
			V.show_message("[src] lets out a low, short blip.", 2)
	else
		..()

/obj/machinery/librarycomp/Topic(href, href_list)
	if (href_list["switchscreen"])
		switch(href_list["switchscreen"])
			if ("0")
				screenstate = 0
			if ("1")
				screenstate = 1
			if ("2")
				screenstate = 2
			if ("3")
				screenstate = 3
			if ("4")
				screenstate = 4
			if ("5")
				screenstate = 5
			if ("6")
				if (!bibledelay)

					var/obj/item/weapon/storage/bible/B = new /obj/item/weapon/storage/bible(src.loc)
					if (ticker && ( ticker.Bible_icon_state && ticker.Bible_item_state) )
						B.icon_state = ticker.Bible_icon_state
						B.item_state = ticker.Bible_item_state
						B.name = ticker.Bible_name

					bibledelay = 60
					spawn(0)
						while(bibledelay >= 1 && src)
							sleep(10)
							bibledelay -- // subtract one second to countdown

						bibledelay = 0

				else
					for (var/mob/V in hearers(src))
						V.show_message("<b>[src]</b>'s monitor flashes, \"[bibledelay] seconds remaining until the bible printer is ready for use.\"")

			if ("7")
				screenstate = 7
	if (href_list["arccheckout"])
		src.arcanecheckout = 1
		src.screenstate = 0
	if (href_list["increasetime"])
		checkoutperiod += 1
	if (href_list["decreasetime"])
		checkoutperiod -= 1
		if (checkoutperiod < 1)
			checkoutperiod = 1
	if (href_list["editbook"])
		buffer_book = input("Enter the book's title:") as text|null
	if (href_list["editmob"])
		buffer_mob = input("Enter the recipient's name:") as text|null
	if (href_list["checkout"])
		var/datum/borrowbook/b = new /datum/borrowbook
		b.bookname = sanitize(buffer_book)
		b.mobname = sanitize(buffer_mob)
		b.getdate = world.time
		b.duedate = world.time + (checkoutperiod * 600)
		checkouts.Add(b)
	if (href_list["checkin"])
		var/datum/borrowbook/b = locate(href_list["checkin"])
		checkouts.Remove(b)
	if (href_list["delbook"])
		var/obj/item/book/b = locate(href_list["delbook"])
		inventory.Remove(b)
	if (href_list["setauthor"])
		var/newauthor = input("Enter the author's name: ") as text|null
		if (newauthor)
			scanner.cache.author = sanitize(newauthor)
	if (href_list["setcategory"])
		var/newcategory = input("Choose a category: ") in list("Fiction", "Non-Fiction", "Adult", "Reference", "Religion")
		if (newcategory)
			upload_category = newcategory
	if (href_list["upload"])
		if (scanner)
			if (scanner.cache)
				var/choice = input("Are you certain you wish to upload this title to the Archive?") in list("Confirm", "Abort")
				if (choice == "Confirm")
					var/DBConnection/dbcon = new()
					dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
					if (!dbcon.IsConnected())
						alert("Connection to Archive has been severed. Aborting.")
					else
						/*
						var/sqltitle = dbcon.Quote(scanner.cache.name)
						var/sqlauthor = dbcon.Quote(scanner.cache.author)
						var/sqlcontent = dbcon.Quote(scanner.cache.dat)
						var/sqlcategory = dbcon.Quote(upload_category)
						*/
						var/sqltitle = dd_replacetext(scanner.cache.name, "'", "''")
						var/sqlauthor = dd_replacetext(scanner.cache.author, "'", "''")
						var/sqlcontent = dd_replacetext(scanner.cache.dat, "'", "''")
						var/sqlcategory = upload_category
						///proc/dd_replacetext(text, search_string, replacement_string)
						var/DBQuery/query = dbcon.NewQuery("INSERT INTO library (author, title, content, category) VALUES ('[sqlauthor]', '[sqltitle]', '[sqlcontent]', '[sqlcategory]')")
						if (!query.Execute())
							usr << query.ErrorMsg()
						else
							log_game("[usr.name]/[usr.key] has uploaded the book titled [scanner.cache.name], [length(scanner.cache.dat)] signs")
							alert("Upload Complete.")
						dbcon.Disconnect()
	if (href_list["targetid"])
		var/sqlid = href_list["targetid"]
		var/DBConnection/dbcon = new()
		dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
		if (!dbcon.IsConnected())
			alert("Connection to Archive has been severed. Aborting.")
		else
			var/DBQuery/query = dbcon.NewQuery("SELECT * FROM library WHERE id=[sqlid]")
			query.Execute()

			while(query.NextRow())
				var/author = query.item[2]
				var/title = query.item[3]
				var/content = query.item[4]
				var/obj/item/book/B = new(src.loc)
				B.name = title
				B.author = author
				B.dat = content
				B.icon_state = "book[rand(1,7)]"
				src.visible_message("[src]'s printer hums as it produces a completely bound book. How did it do that?")
				break
			dbcon.Disconnect()
	if (href_list["orderbyid"])
		var/orderid = input("Enter your order:") as num|null
		if (orderid)
			var/nhref = "src=\ref[src];targetid=[orderid]"
			spawn() src.Topic(nhref, params2list(nhref), src)
	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return
