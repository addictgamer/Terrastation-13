
/obj/bookcase
	name = "bookcase"
	icon = 'library.dmi'
	icon_state = "bookcase"
	anchored = 1
	density = 1
	opacity = 1

	attackby(obj/O as obj, mob/user as mob)
		if (istype(O, /obj/item/book))
			user.drop_item()
			O.loc = src
		else if (istype(O, /obj/item/weapon/pen))
			var/newname = input("What would you like to title this bookshelf?") as text|null
			if (!newname)
				return
			else
				src.setname(sanitize(newname))
		else
			..()
	attack_hand(var/mob/user as mob)
		var/list/books = list()
		for(var/obj/item/book/b in src.contents)
			books.Add(b)
		if (books.len)
			var/obj/item/book/choice = input("Which book would you like to remove from the shelf?") in books as obj|null
			if (choice)
				choice.loc = src.loc
			else
				return
		else
			user << "None of these books pique your interest in the slightest."

	proc
		setname(var/t as text)
			if (t)
				src.name = "bookcase ([t])"

	ex_act(severity)
		switch(severity)
			if (1.0)
				for(var/obj/item/book/b in src.contents)
					del(b)
				del(src)
				return
			if (2.0)
				for(var/obj/item/book/b in src.contents)
					if (prob(50)) b.loc = (get_turf(src))
					else del(b)
				del(src)
				return
			if (3.0)
				if (prob(50))
					for(var/obj/item/book/b in src.contents)
						b.loc = (get_turf(src))
					del(src)
				return
			else
		return
