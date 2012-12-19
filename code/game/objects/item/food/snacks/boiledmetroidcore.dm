
/obj/item/weapon/reagent_containers/food/snacks/boiledmetroidcore
	name = "Boiled Metroid Core"
	desc = "A boiled red thing."
	icon_state = "boiledmetroidcore"
	New()
		..()
		reagents.add_reagent("metroid", 5)
		bitesize = 3
