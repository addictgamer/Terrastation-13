
/obj/machinery/bookbinder
	name = "Book Binder"
	icon = 'library.dmi'
	icon_state = "binder"
	anchored = 1
	density = 1

	attackby(var/obj/O as obj, var/mob/user as mob)
		if (istype(O, /obj/item/paper))
			user.drop_item()
			O.loc = src
			user.visible_message("[user] loads some paper into [src].", "You load some paper into [src].")
			src.visible_message("[src] begins to hum as it warms up its printing drums.")
			sleep(rand(200,400))
			src.visible_message("[src] whirs as it prints and binds a new book.")
			var/obj/item/book/b = new(src.loc)
			b.dat = O:info
			b.name = "Print Job #" + "[rand(100, 999)]"
			b.icon_state = "book[rand(1,7)]"
			del(O)
		else
			..()
