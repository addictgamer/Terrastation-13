
/obj/effects/sleep_smoke
	name = "smoke"
	icon_state = "smoke"
	opacity = 1
	anchored = 0.0
	mouse_opacity = 0
	var/amount = 6.0
	//Remove this bit to use the old smoke
	icon = '96x96.dmi'
	pixel_x = -32
	pixel_y = -32

	New()
		..()
		spawn (200+rand(10,30))
			del(src)
		return

	Move()
		..()
		for(var/mob/living/carbon/M in get_turf(src))
			if (M.internal != null && M.wear_mask && (M.wear_mask.flags & MASKINTERNALS))
	//		if (M.wear_suit, /obj/item/clothing/suit/wizrobe && (M.hat, /obj/item/clothing/head/wizard) && (M.shoes, /obj/item/clothing/shoes/sandal))  // I'll work on it later
			else
				M.drop_item()
				M:sleeping += 1
				if (M.coughedtime != 1)
					M.coughedtime = 1
					M.emote("cough")
					spawn ( 20 )
						M.coughedtime = 0
		return

	HasEntered(mob/living/carbon/M as mob )
		..()
		if(istype(M, /mob/living/carbon))
			if (M.internal != null && M.wear_mask && (M.wear_mask.flags & MASKINTERNALS))
	//		if (M.wear_suit, /obj/item/clothing/suit/wizrobe && (M.hat, /obj/item/clothing/head/wizard) && (M.shoes, /obj/item/clothing/shoes/sandal)) // Work on it later
				return
			else
				M.drop_item()
				M:sleeping += 1
				if (M.coughedtime != 1)
					M.coughedtime = 1
					M.emote("cough")
					spawn ( 20 )
						M.coughedtime = 0
		return
