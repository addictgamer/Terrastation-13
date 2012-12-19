
/obj/item/weapon/reagent_containers/food/snacks/appendix //yes, this is the same as meat. I might do something different in future
	name = "Appendix"
	desc = "An appendix which looks perfectly healthy."
	icon_state = "appendix"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		src.bitesize = 3
