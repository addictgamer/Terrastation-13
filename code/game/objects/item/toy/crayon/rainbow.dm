
/obj/item/toy/crayon/rainbow
	icon_state = "crayonrainbow"
	desc = "So. Many. COLORS!"
	colour = "#FFF000"
	shadeColour = "#000FFF"
	colourName = "rainbow"
	uses = 0

	attack_self(mob/living/user as mob)
		colour = input(user, "Please select the main colour.", "Crayon colour") as color
		shadeColour = input(user, "Please select the shade colour.", "Crayon colour") as color
		return
