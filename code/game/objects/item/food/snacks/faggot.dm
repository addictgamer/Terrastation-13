
/obj/item/weapon/reagent_containers/food/snacks/faggot
	name = "Faggot"
	desc = "A great meal all round. Not a cord of wood."
	icon_state = "faggot"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		bitesize = 2
