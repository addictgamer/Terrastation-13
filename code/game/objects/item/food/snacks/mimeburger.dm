
/obj/item/weapon/reagent_containers/food/snacks/mimeburger
	name = "Mime Burger"
	desc = "It's taste defies language."
	icon_state = "mimeburger"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
