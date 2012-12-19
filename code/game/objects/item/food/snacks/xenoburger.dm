
/obj/item/weapon/reagent_containers/food/snacks/xenoburger
	name = "xenoburger"
	desc = "Smells caustic. Tastes like heresy."
	icon_state = "xburger"
	New()
		..()
		reagents.add_reagent("xenomicrobes", 10)
		reagents.add_reagent("nutriment", 2)
		bitesize = 3
