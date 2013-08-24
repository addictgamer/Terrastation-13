
/obj/item/weapon/reagent_containers/food/snacks/chaosdonut
	name = "Chaos Donut"
	desc = "Like life, it never quite tastes the same."
	icon_state = "donut1"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		bitesize = 2
		if (prob(30))
			src.icon_state = "donut2"
			src.name = "Frosted Chaos Donut"
			reagents.add_reagent("sprinkles", 3)
		reagents.add_reagent(pick("capsaicin", "frostoil", "nutriment"), 3)
