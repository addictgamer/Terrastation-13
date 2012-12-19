
/obj/item/weapon/reagent_containers/food/snacks/no_raisin
	name = "4no Raisins"
	icon_state = "4no_raisins"
	desc = "Best raisins in the universe. Not sure why."
	trash = "raisins"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
