
/obj/item/weapon/reagent_containers/food/snacks/fishandchips
	name = "Fish and Chips"
	desc = "I do say so myself chap."
	icon_state = "fishandchips"
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		reagents.add_reagent("carpotoxin", 3)
		bitesize = 3
