
/obj/item/weapon/reagent_containers/food/snacks/fortunecookie
	name = "Fortune cookie"
	desc = "A true prophecy in each cookie!"
	icon_state = "fortune_cookie"
	New()
		..()
		reagents.add_reagent("nutriment", 3)
		bitesize = 2
	On_Consume()
		if(!reagents.total_volume)
			var/mob/M = usr
			var/obj/item/weapon/paper/paper = locate() in src
			M.visible_message( \
				"\blue [M] takes a piece of paper from the cookie!", \
				"\blue You take a piece of paper from the cookie! Read it!" \
			)
			M.put_in_hand(paper)
			paper.add_fingerprint(M)
