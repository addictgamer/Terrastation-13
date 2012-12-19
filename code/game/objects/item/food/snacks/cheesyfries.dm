
/obj/item/weapon/reagent_containers/food/snacks/cheesyfries
	name = "Cheesy Fries"
	desc = "Fries. Covered in cheese. Duh."
	icon_state = "cheesyfries"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
