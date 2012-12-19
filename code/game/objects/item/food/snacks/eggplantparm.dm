
/obj/item/weapon/reagent_containers/food/snacks/eggplantparm
	name = "Eggplant Parmigiana"
	desc = "The only good recipe for eggplant."
	icon_state = "eggplantparm"
	trash = "plate"
	New()
		..()
		reagents.add_reagent("nutriment", 6)
		bitesize = 2
