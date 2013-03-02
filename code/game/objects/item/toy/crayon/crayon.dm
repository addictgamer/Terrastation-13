
/obj/item/toy/crayon
	name = "crayon"
	desc = "A colourful crayon. Looks tasty. Mmmm..."
	icon = 'crayons.dmi'
	icon_state = "crayonred"
	w_class = 1.0
	var
		colour = "#FF0000" //RGB
		shadeColour = "#220000" //RGB
		uses = 30 //0 for unlimited uses
		instant = 0
		colourName = "red" //for updateIcon purposes

	afterattack(atom/target, mob/user as mob)
		if(istype(target,/turf/simulated/floor))
			var/drawtype = input("Choose what you'd like to draw.", "Crayon scribbles") in list("graffiti","rune","letter")
			switch(drawtype)
				if("letter")
					drawtype = input("Choose the letter.", "Crayon scribbles") in list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
					user << "You start drawing a letter on the [target.name]."
				if("graffiti")
					user << "You start drawing graffiti on the [target.name]."
				if("rune")
					user << "You start drawing a rune on the [target.name]."
			if(instant || do_after(user, 50))
				new /obj/decal/cleanable/crayon(target,colour,shadeColour,drawtype)
				user << "You finish drawing."
				if(uses)
					uses--
					if(!uses)
						user << "\red You used up your crayon!"
						del(src)
		return

	attack(mob/M as mob, mob/user as mob)
		if(M == user)
			user << "You take a bite of the crayon. Delicious!"
			user.nutrition += 5
			if(uses)
				uses -= 5
				if(uses <= 0)
					user << "\red You ate your crayon!"
					del(src)
		else
			..()
