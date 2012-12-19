
/obj/reagent_dispensers/fueltank
	name = "fueltank"
	desc = "A fueltank"
	icon = 'objects.dmi'
	icon_state = "weldtank"
	amount_per_transfer_from_this = 10
	New()
		..()
		reagents.add_reagent("fuel",1000)

/obj/reagent_dispensers/fueltank/blob_act()
	explosion(src.loc,0,1,5,7,10)
	if(src)
		del(src)

/obj/reagent_dispensers/fueltank/ex_act()
	explosion(src.loc,-1,0,2)
	if(src)
		del(src)
