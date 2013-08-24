
/obj/item/weapon/reagent_containers/food/snacks/omelette
	name = "Omelette Du Fromage"
	desc = "That's all you can say!"
	icon_state = "omelette"
	trash = "plate"
	//var/herp = 0
	New()
		..()
		reagents.add_reagent("nutriment", 8)
		bitesize = 1
	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W,/obj/item/weapon/kitchen/utensil/fork))
			if (W.icon_state == "forkloaded")
				user << "\red You already have omelette on your fork."
				return
			//W.icon = 'kitchen.dmi'
			W.icon_state = "forkloaded"
			/*if (herp)
				world << "[user] takes a piece of omelette with his fork!"*/
				//Why this unecessary check? Oh I know, because I'm bad >:C
				// Yes, you are. You griefing my badmin toys. --rastaf0
			user.visible_message( \
				"[user] takes a piece of omelette with their fork!", \
				"\blue You take a piece of omelette with your fork!" \
			)
			reagents.remove_reagent("nutriment", 1)
			if (reagents.total_volume <= 0)
				del(src)
/*
 * Unsused.
/obj/item/weapon/reagent_containers/food/snacks/omeletteforkload
	name = "Omelette Du Fromage"
	desc = "That's all you can say!"
	New()
		..()
		reagents.add_reagent("nutriment", 1)
*/
