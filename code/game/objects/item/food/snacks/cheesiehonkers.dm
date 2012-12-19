
/obj/item/weapon/reagent_containers/food/snacks/cheesiehonkers
	name = "Cheesie Honkers"
	icon_state = "cheesie_honkers"
	desc = "Bite sized cheesie snacks that will honk all over your mouth"
	trash = "cheesie"
	New()
		..()
		reagents.add_reagent("nutriment", 4)
		bitesize = 2
