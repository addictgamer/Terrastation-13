
/obj/item/weapon/reagent_containers/food/snacks/tofukabob
	name = "Tofu-kabob"
	icon_state = "kabob"
	desc = "A delicious kabob"
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 2
	On_Consume()
		if (!reagents.total_volume)
			var/mob/M = usr
			var/obj/item/stack/rods/W = new /obj/item/stack/rods( M )
			M << "\blue You lick clean the rod."
			M.put_in_hand(W)
