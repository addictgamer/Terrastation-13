
/obj/item/toy/crayon/mime
	icon_state = "crayonmime"
	desc = "A very sad-looking crayon."
	colour = "#FFFFFF"
	shadeColour = "#000000"
	colourName = "mime"
	uses = 0

	attack_self(mob/living/user as mob) //inversion
		if(colour != "#FFFFFF" && shadeColour != "#000000")
			colour = "#FFFFFF"
			shadeColour = "#000000"
			user << "You will now draw in white and black with this crayon."
		else
			colour = "#000000"
			shadeColour = "#FFFFFF"
			user << "You will now draw in black and white with this crayon."
		return
