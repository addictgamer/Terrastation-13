
/obj/item/weapon/reagent_containers/food/snacks/monkeyburger
	name = "burger"
	desc = "The cornerstone of every nutritious breakfast."
	icon_state = "hburger"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
