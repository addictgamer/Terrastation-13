
/obj/item/weapon/reagent_containers/food/snacks/candiedapple
	name = "Candied Apple"
	desc = "An apple coated in sugary sweetness."
	icon_state = "candiedapple"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		bitesize = 3
