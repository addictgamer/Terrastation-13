
/obj/item/weapon/reagent_containers/food/snacks/xemeatpie
	name = "Xeno-pie"
	icon_state = "xenomeatpie"
	desc = "A delicious meatpie. Probably heretical."
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 2)
		reagents.add_reagent("xenomicrobes", 10)
		bitesize = 4
