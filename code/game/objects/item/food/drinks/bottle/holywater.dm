
/obj/item/weapon/reagent_containers/food/drinks/bottle/holywater
	name = "Flask of Holy Water"
	desc = "A flask of the chaplains holy water."
	icon_state = "holyflask"
	New()
		..()
		reagents.add_reagent("holywater", 100)
