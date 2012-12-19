
/obj/item/weapon/reagent_containers/food/snacks/syndicake
	name = "Syndi-Cakes"
	icon_state = "syndi_cakes"
	desc = "An extremely moist snack cake that tastes just as good after being nuked."
	trash = "syndi_cakes"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		reagents.add_reagent("syndicream", 2)
		bitesize = 3
