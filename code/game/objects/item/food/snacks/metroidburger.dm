
/obj/item/weapon/reagent_containers/food/snacks/metroidburger
	name = "Metroid Burger"
	desc = "A very toxic and tasty burger."
	icon_state = "metroidburger"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		reagents.add_reagent("metroid", 5)
		bitesize = 2
