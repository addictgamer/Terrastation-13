
/obj/item/weapon/reagent_containers/food/snacks/momeatpie
	name = "Meat-pie"
	icon_state = "meatpie"
	desc = "A delicious meatpie."
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 2
