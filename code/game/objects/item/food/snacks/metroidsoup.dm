
/obj/item/weapon/reagent_containers/food/snacks/metroidsoup
	name = "Metroid soup"
	desc = "Tasty"
	icon_state = "metroidsoup"
	New()
		..()
		reagents.add_reagent("metroid", 5)
		reagents.add_reagent("water", 10)
		bitesize = 5
