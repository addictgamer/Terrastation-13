
/obj/item/weapon/reagent_containers/food/snacks/meatballspagetti
	name = "Spagetti & Meatballs"
	desc = "Now thats a nic'e meatball!"
	icon_state = "meatballspagetti"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 2
