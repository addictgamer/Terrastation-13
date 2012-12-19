
/obj/item/weapon/reagent_containers/food/snacks/donkpocket
	name = "Donk-pocket"
	desc = "The food of choice for the seasoned traitor."
	icon_state = "donkpocket"
	New()
		..()
		reagents.add_reagent("nutriment", 4)

	var/warm = 0
	proc/cooltime() //Not working, derp?
		if (src.warm)
			spawn( 4200 )
				src.warm = 0
				src.reagents.del_reagent("tricordrazine")
				src.name = "donk-pocket"
		return
