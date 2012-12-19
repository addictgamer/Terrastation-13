
/obj/item/weapon/reagent_containers/food/snacks/fries
	name = "Space Fries"
	desc = "AKA: French Fries, Freedom Fries, etc"
	icon_state = "fries"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		bitesize = 2
