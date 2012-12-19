
/obj/item/weapon/reagent_containers/food/snacks/superbiteburger
	name = "Super Bite Burger"
	desc = "This is a mountain of a burger. FOOD!"
	icon_state = "superbiteburger"
	New()
		..()
		reagents.add_reagent("nutriment", 40)
		bitesize = 10
