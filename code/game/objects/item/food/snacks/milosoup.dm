
/obj/item/weapon/reagent_containers/food/snacks/milosoup
	name = "Milosoup"
	desc = "The universes best soup! Yum!!!"
	icon_state = "milosoup"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 12)
		reagents.add_reagent("water", 20)
		bitesize = 4
