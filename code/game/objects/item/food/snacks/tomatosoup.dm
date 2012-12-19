
/obj/item/weapon/reagent_containers/food/snacks/tomatosoup
	name = "Tomato Soup"
	desc = "Drinking this feels like being a vampire! A tomato vampire..."
	icon_state = "tomatosoup"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		reagents.add_reagent("tomatojuice", 10)
		reagents.add_reagent("water", 10)
		bitesize = 5
