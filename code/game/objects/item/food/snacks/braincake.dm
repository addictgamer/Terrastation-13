
/obj/item/weapon/reagent_containers/food/snacks/braincake
	name = "Brain Cake"
	desc = "A squishy cake-thing."
	icon_state = "braincake"
	New()
		..()
		reagents.add_reagent("nutriment", 28)
		bitesize = 3
