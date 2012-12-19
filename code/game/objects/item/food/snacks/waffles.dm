
/obj/item/weapon/reagent_containers/food/snacks/waffles
	name = "waffles"
	desc = "Mmm, waffles"
	icon_state = "waffles"
	trash = "waffles"
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 2
