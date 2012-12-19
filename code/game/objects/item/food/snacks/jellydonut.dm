
/obj/item/weapon/reagent_containers/food/snacks/jellydonut
	name = "Jelly Donut"
	desc = "Oh so gooey on the inside."
	icon_state = "jdonut1"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		reagents.add_reagent("sprinkles", 1)
		reagents.add_reagent("berryjuice", 5)
		bitesize = 5
		if(prob(30))
			src.icon_state = "jdonut2"
			src.name = "Frosted Jelly Donut"
			reagents.add_reagent("sprinkles", 2)
