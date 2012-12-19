
/obj/item/weapon/reagent_containers/food/snacks/spacetwinkie
	name = "Space Twinkie"
	icon_state = "space_twinkie"
	desc = "Guaranteed to survive longer than you will."
	New()
		..()
		reagents.add_reagent("sugar", 4)
		bitesize = 2
