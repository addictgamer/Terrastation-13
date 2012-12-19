
/obj/item/weapon/reagent_containers/food/snacks/tofupie
	name = "Tofu-pie"
	icon_state = "meatpie"
	desc = "A delicious tofu pie."
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 2
