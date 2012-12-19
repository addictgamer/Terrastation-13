
/obj/item/weapon/reagent_containers/food/snacks/mysterysoup
	name = "Mystery soup"
	desc = "A....strange, strange soup."
	icon_state = "mysterysoup"
	New()
		..()
		reagents.add_reagent("nutriment", 12)
		reagents.add_reagent("water", 7)
		bitesize = 4
