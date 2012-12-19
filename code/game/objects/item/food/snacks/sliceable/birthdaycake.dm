
/obj/item/weapon/reagent_containers/food/snacks/sliceable/birthdaycake
	name = "Birthday Cake"
	desc = "Happy Birthday little clown..."
	icon_state = "birthdaycake"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/birthdaycakeslice
	slices_num = 5
	New()
		..()
		reagents.add_reagent("nutriment", 30)
		reagents.add_reagent("sprinkles", 10)
		bitesize = 3
