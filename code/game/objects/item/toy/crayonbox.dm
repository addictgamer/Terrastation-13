
/obj/item/toy/crayonbox
	name = "box of crayons"
	desc = "A box of crayons for all your rune drawing needs."
	icon = 'crayons.dmi'
	icon_state = "crayonbox"
	w_class = 2.0

	New()
		..()
		new /obj/item/toy/crayon/red(src)
		new /obj/item/toy/crayon/orange(src)
		new /obj/item/toy/crayon/yellow(src)
		new /obj/item/toy/crayon/green(src)
		new /obj/item/toy/crayon/blue(src)
		new /obj/item/toy/crayon/purple(src)
		updateIcon()

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W,/obj/item/toy/crayon))
			switch(W:colourName)
				if ("mime")
					usr << "This crayon is too sad to be contained in this box."
					return
				if ("rainbow")
					usr << "This crayon is too powerful to be contained in this box."
					return
				else
					usr << "You add the crayon to the box."
					user.u_equip(W)
					W.loc = src
					if ((user.client && user.s_active != src))
						user.client.screen -= W
					W.dropped(user)
					add_fingerprint(user)
					updateIcon()
					return
		else
			..()

	attack_hand(mob/user as mob)
		if (user.r_hand == src || user.l_hand == src)
			if (!contents.len)
				user << "\red You're out of crayons!"
				return
			else
				var/crayon = pick(contents)
				user.contents += crayon
				if (user.hand)
					user.l_hand = crayon
				else
					user.r_hand = crayon
				crayon:layer = 20
				user << "You take the [crayon:colourName] crayon out of the box."
				updateIcon()
		else
			return ..()
		icon_state = "crayonbox[contents.len]"
		return

	proc
		updateIcon()
			overlays = list() //resets list
			overlays += image('crayons.dmi',"crayonbox")
			for(var/obj/item/toy/crayon/crayon in contents)
				overlays += image('crayons.dmi',crayon.colourName)
