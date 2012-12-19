
/obj/item/weapon/reagent_containers/food/snacks/sosjerky
	name = "Scaredy's Private Reserve Beef Jerky"
	icon_state = "sosjerky"
	desc = "Beef jerky made from the finest space cows."
	trash = "sosjerky"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		bitesize = 2
