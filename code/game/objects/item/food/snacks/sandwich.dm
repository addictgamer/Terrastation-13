
/obj/item/weapon/reagent_containers/food/snacks/sandwich
	name = "Sandwich"
	desc = "A grand creation of meat, cheese, bread and several leafs oflettuce! Arthur Dent would be proud."
	icon_state = "sandwich"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 3
