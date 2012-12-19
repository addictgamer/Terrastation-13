
/obj/item/weapon/reagent_containers/food/snacks/appendixinflamed
	name = "Inflamed Appendix"
	desc = "An appendix which appears to be inflamed."
	icon_state = "appendixinflamed"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		src.bitesize = 1
