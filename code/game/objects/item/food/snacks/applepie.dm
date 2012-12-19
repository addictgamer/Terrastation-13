
/obj/item/weapon/reagent_containers/food/snacks/applepie
	name = "Apple Pie"
	desc = "A pie containing sweet sweet love...or apple."
	icon_state = "applepie"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		bitesize = 3
