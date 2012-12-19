
/obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza
	name = "Pizza"
	desc = "Space Italy's greatest masterpiece."
	icon_state = "pizza"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/pizzaslice
	slices_num = 8
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
