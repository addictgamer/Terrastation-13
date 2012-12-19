
/obj/item/weapon/reagent_containers/food/snacks/sausage
	name = "Sausage"
	desc = "A piece of mixed, long meat."
	icon_state = "sausage"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
