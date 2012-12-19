
/obj/item/weapon/reagent_containers/food/snacks/vegetablesoup
	name = "Vegetable soup"
	desc = "" //TODO
	icon_state = "vegetablesoup"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		reagents.add_reagent("water", 10)
		bitesize = 5
