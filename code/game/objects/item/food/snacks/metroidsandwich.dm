
/obj/item/weapon/reagent_containers/food/snacks/metroidsandwich
	name = "Metroid Sandwich"
	desc = "A sandwich is green stuff."
	icon_state = "metroidsandwich"
	New()
		..()
		reagents.add_reagent("nutriment", 2)
		reagents.add_reagent("metroid", 5)
		bitesize = 3
