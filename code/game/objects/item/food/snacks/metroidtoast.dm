
/obj/item/weapon/reagent_containers/food/snacks/metroidtoast
	name = "Metroid Toast"
	desc = "A slice of bread covered with delicious jam."
	icon_state = "metroidtoast"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		reagents.add_reagent("metroid", 5)
		bitesize = 3
