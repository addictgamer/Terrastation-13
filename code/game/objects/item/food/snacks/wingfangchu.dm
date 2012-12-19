
/obj/item/weapon/reagent_containers/food/snacks/wingfangchu
	name = "Wing Fang Chu"
	desc = "A savory dish of alien wing wang in soy."
	icon_state = "wingfangchu"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		reagents.add_reagent("xenomicrobes", 5)
		bitesize = 2
