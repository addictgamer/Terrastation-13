
/obj/item/weapon/reagent_containers/food/snacks/flour
	name = "flour"
	desc = "Some flour"
	icon_state = "flour"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
