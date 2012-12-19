
/obj/item/weapon/reagent_containers/food/snacks/bloodsoup
	name = "Meatball soup"
	desc = "So very, very red."
	icon_state = "meatballsoup"
	New()
		..()
		reagents.add_reagent("nutriment", 2)
		reagents.add_reagent("blood", 15)
		reagents.add_reagent("water", 10)
		bitesize = 5
