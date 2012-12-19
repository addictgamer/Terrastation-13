
/obj/item/weapon/reagent_containers/food/snacks/candy_corn
	name = "candy corm" //Not a typo
	desc = "It's a handful of candy corm. Can be stored in a detective's hat."
	icon_state = "candy_corn"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		reagents.add_reagent("sugar", 2)
		bitesize = 2
