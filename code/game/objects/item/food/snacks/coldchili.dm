
/obj/item/weapon/reagent_containers/food/snacks/coldchili
	name = "Cold Chili"
	desc = "Is it just me, or is this bowl a little... chili? AWWWW YEAAAH!"
	icon_state = "coldchili"
	trash = "snack_bowl"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		reagents.add_reagent("frostoil", 3)
		reagents.add_reagent("tomatojuice", 2)
		bitesize = 5
