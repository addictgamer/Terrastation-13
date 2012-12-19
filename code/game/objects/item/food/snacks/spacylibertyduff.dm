
/obj/item/weapon/reagent_containers/food/snacks/spacylibertyduff
	name = "Spacy Liberty Duff"
	desc = "Jello gelatin, if Alfred Hubbard were a confectionist" //TODO
	icon_state = "spacylibertyduff"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		reagents.add_reagent("psilocybin", 6)
		bitesize = 3
