
/obj/item/weapon/reagent_containers/food/snacks/meatballsoup
	name = "Meatball soup"
	desc = "" //TODO
	icon_state = "meatballsoup"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		reagents.add_reagent("water", 10)
		bitesize = 5
