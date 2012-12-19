
/obj/item/weapon/reagent_containers/food/snacks/boiledspagetti
	name = "Boiled Spagetti"
	desc = "A plain dish of noodles, this sucks."
	icon_state = "spagettiboiled"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 2)
		bitesize = 2
