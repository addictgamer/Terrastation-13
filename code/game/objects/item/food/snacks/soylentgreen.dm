
/obj/item/weapon/reagent_containers/food/snacks/soylentgreen
	name = "Soylent Green"
	desc = "Not made of people. Honest." //Totally people.
	icon_state = "soylent_green"
	trash = "waffles"
	New()
		..()
		reagents.add_reagent("nutriment", 14)
		bitesize = 2
