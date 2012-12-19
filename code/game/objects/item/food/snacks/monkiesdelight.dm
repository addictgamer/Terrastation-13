
/obj/item/weapon/reagent_containers/food/snacks/monkiesdelight
	name = "Monkie's Delight"
	desc = "Eeee Eee!"
	icon_state = "monkiesdelight"
	trash = "tray"
	New()
		..()
		reagents.add_reagent("nutriment", 14)
		reagents.add_reagent("banana", 5)
		reagents.add_reagent("blackpepper", 1)
		reagents.add_reagent("sodiumchloride", 1)
		bitesize = 6
