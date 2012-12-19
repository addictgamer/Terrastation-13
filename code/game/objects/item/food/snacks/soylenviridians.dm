
/obj/item/weapon/reagent_containers/food/snacks/soylenviridians
	name = "Soylen Virdians"
	desc = "Not made of people. Honest." //Actually honest for once.
	icon_state = "soylent_yellow"
	trash = "waffles"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 2
