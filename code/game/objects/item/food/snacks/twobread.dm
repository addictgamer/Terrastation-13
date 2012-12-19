
/obj/item/weapon/reagent_containers/food/snacks/twobread
	name = "Two Bread"
	desc = "It is very bitter and winy."
	icon_state = "twobread"
	New()
		..()
		reagents.add_reagent("nutriment", 2)
		bitesize = 3
