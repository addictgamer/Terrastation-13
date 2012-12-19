
/obj/item/weapon/reagent_containers/food/snacks/chips
	name = "chips"
	desc = "Commander Riker's What-The-Crisps"
	icon_state = "chips"
	trash = "chips"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		bitesize = 1
