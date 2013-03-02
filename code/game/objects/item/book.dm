
/obj/item/book
	name = "book"
	icon = 'library.dmi'
	icon_state ="book"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
	flags = FPRINT | TABLEPASS
	var
		dat			 // Actual page content
		due_date = 0 // Game time in 1/10th seconds
		author		 // Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
		unique = 0   // 0 - Normal book, 1 - Should not be treated as normal book, unable to be copied, unable to be modified

	attack_self(var/mob/user as mob)
		if(src.dat)
			user << browse("<TT><I>Penned by [author].</I></TT> <BR>" + "[dat]", "window=book")
			user.visible_message("[user] opens a book titled \"[src.name]\" and begins reading intently.")
			onclose(user, "book")
		else
			user << "This book is completely blank!"

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/pen))
			if(unique)
				user << "These pages don't seem to take the ink well. Looks like you can't modify it."
				return
			var/choice = input("What would you like to change?") in list("Title", "Contents", "Author", "Cancel")
			switch(choice)
				if("Title")
					var/title = input("Write a new title:") as text|null
					if(!title)
						return
					else
						src.name = sanitize(title)
				else if("Contents")
					var/content = strip_html(input("Write your book's contents (HTML NOT allowed):"),8192) as message|null
					if(!content)
						return
					else
						src.dat += content
				else if("Author")
					var/nauthor = input("Write the author's name:") as text|null
					if(!nauthor)
						return
					else
						src.author = sanitize(nauthor)
				else
					return
		else if(istype(W, /obj/item/weapon/barcodescanner))
			var/obj/item/weapon/barcodescanner/scanner = W
			if(!scanner.computer)
				user << "[W]'s screen flashes: 'No associated computer found!'"
			else
				switch(scanner.mode)
					if(0)
						scanner.book = src
						user << "[W]'s screen flashes: 'Book stored in buffer.'"
					if(1)
						scanner.book = src
						scanner.computer.buffer_book = src.name
						user << "[W]'s screen flashes: 'Book stored in buffer. Book title stored in associated computer buffer.'"
					if(2)
						scanner.book = src
						for(var/datum/borrowbook/b in scanner.computer.checkouts)
							if(b.bookname == src.name)
								scanner.computer.checkouts.Remove(b)
								user << "[W]'s screen flashes: 'Book stored in buffer. Book has been checked in.'"
								return
						user << "[W]'s screen flashes: 'Book stored in buffer. No active check-out record found for current title.'"
					if(3)
						scanner.book = src
						for(var/obj/item/book in scanner.computer.inventory)
							if(book == src)
								user << "[W]'s screen flashes: 'Book stored in buffer. Title already present in inventory, aborting to avoid duplicate entry.'"
								return
						scanner.computer.inventory.Add(src)
						user << "[W]'s screen flashes: 'Book stored in buffer. Title added to general inventory.'"
		else
			..()
