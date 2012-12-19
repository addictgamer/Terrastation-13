
/obj/item/weapon/reagent_containers/food/snacks/muffin
	name = "Muffin"
	desc = "A delicious and spongy little cake"
	icon_state = "muffin"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
