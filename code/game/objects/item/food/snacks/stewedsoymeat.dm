
/obj/item/weapon/reagent_containers/food/snacks/stewedsoymeat
	name = "Stewed Soy Meat"
	desc = "Even non-vegetarians will LOVE this!"
	icon_state = "stewedsoymeat"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 2
