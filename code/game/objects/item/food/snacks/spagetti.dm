
/obj/item/weapon/reagent_containers/food/snacks/spagetti
	name = "Spagetti"
	desc = "Now thats a nice pasta!"
	icon_state = "spagetti"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		bitesize = 1
