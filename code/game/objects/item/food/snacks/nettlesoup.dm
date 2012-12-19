
/obj/item/weapon/reagent_containers/food/snacks/nettlesoup
	name = "Nettle soup"
	desc = "" //TODO
	icon_state = "nettlesoup"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		reagents.add_reagent("water", 7)
		reagents.add_reagent("tricordrazine", 3)
		bitesize = 5
