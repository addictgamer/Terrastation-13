
/obj/item/weapon/reagent_containers/food/snacks/toastedsandwich
	name = "Toasted Sandwich"
	desc = "Now if you only had a pepper bar."
	icon_state = "toastedsandwich"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 9)
		bitesize = 3
