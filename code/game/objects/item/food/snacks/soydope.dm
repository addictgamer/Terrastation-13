
/obj/item/weapon/reagent_containers/food/snacks/soydope
	name = "Soy Dope"
	desc = "Dope from a soy."
	icon_state = "soydope"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 2)
		bitesize = 2
