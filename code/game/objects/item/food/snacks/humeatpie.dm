
/obj/item/weapon/reagent_containers/food/snacks/humeatpie
	name = "Meat-pie"
//	var/hname = "" //TODO: need some way to find out that facts for the characters.
//	var/job = null
	icon_state = "meatpie"
	desc = "The best meatpies on station."
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 2
