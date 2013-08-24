
/obj/machinery/librarypubliccomp
	name = "visitor computer"
	icon = 'library.dmi'
	icon_state = "computer"
	anchored = 1
	density = 1
	var
		screenstate = 0
		title
		category = "Any"
		author
		SQLquery


/obj/machinery/librarypubliccomp/attack_hand(var/mob/user as mob)
	usr.machine = src
	var/dat = "<HEAD><TITLE>Library Visitor</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	switch(screenstate)
		if (0)
			dat += "<h2>Search Settings</h2><br>"
			dat += "<A href='?src=\ref[src];settitle=1'>Filter by Title: [title]</A><BR>"
			dat += "<A href='?src=\ref[src];setcategory=1'>Filter by Category: [category]</A><BR>"
			dat += "<A href='?src=\ref[src];setauthor=1'>Filter by Author: [author]</A><BR>"
			dat += "<A href='?src=\ref[src];search=1'>\[Start Search\]</A><BR>"
		if (1)
			var/DBConnection/dbcon = new()
			dbcon.Connect("dbi:mysql:[sqldb]:[sqladdress]:[sqlport]","[sqllogin]","[sqlpass]")
			if (!dbcon.IsConnected())
				dat += "<font color=red><b>ERROR</b>: Unable to contact External Archive. Please contact your system administrator for assistance.</font><BR>"
			else if (!SQLquery)
				dat += "<font color=red><b>ERROR</b>: Malformed search request. Please contact your system administrator for assistance.</font><BR>"
			else
				dat += "<table>"
				dat += "<tr><td>AUTHOR</td><td>TITLE</td><td>CATEGORY</td><td>SS<sup>13</sup>BN</td></tr>"

				var/DBQuery/query = dbcon.NewQuery(SQLquery)
				query.Execute()

				while(query.NextRow())
					var/author = query.item[1]
					var/title = query.item[2]
					var/category = query.item[3]
					var/id = query.item[4]
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td>[id]</td></tr>"
				dat += "</table><BR>"
			dbcon.Disconnect()
			dat += "<A href='?src=\ref[src];back=1'>\[Go Back\]</A><BR>"
	user << browse(dat, "window=publiclibrary")
	onclose(user, "publiclibrary")


/obj/machinery/librarypubliccomp/Topic(href, href_list)
	if (href_list["settitle"])
		var/newtitle = input("Enter a title to search for:") as text|null
		if (newtitle)
			title = sanitize(newtitle)
		else
			title = null
		title = dd_replacetext(title, "'", "''")
	if (href_list["setcategory"])
		var/newcategory = input("Choose a category to search for:") in list("Any", "Fiction", "Non-Fiction", "Adult", "Reference", "Religion")
		if (newcategory)
			category = newcategory
		else
			category = "Any"
	if (href_list["setauthor"])
		var/newauthor = input("Enter an author to search for:") as text|null
		if (newauthor)
			author = sanitize(newauthor)
		else
			author = null
		author = dd_replacetext(author, "'", "''")
	if (href_list["search"])
		SQLquery = "SELECT author, title, category, id FROM library WHERE "
		if (category == "Any")
			SQLquery += "author LIKE '%[author]%' AND title LIKE '%[title]%'"
		else
			SQLquery += "author LIKE '%[author]%' AND title LIKE '%[title]%' AND category='[category]'"
		screenstate = 1

	if (href_list["back"])
		screenstate = 0

	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return
