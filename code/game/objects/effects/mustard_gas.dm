
/obj/effects/mustard_gas
	name = "mustard gas"
	icon_state = "mustard"
	opacity = 1
	anchored = 0.0
	mouse_opacity = 0
	var
		amount = 6.0

	New()
		..()
		spawn (100)
			del(src)
		return

	Move()
		..()
		for(var/mob/living/carbon/human/R in get_turf(src))
			if (R.internal != null && usr.wear_mask && (R.wear_mask.flags & MASKINTERNALS) && R.wear_suit != null && !istype(R.wear_suit, /obj/item/clothing/suit/labcoat) && !istype(R.wear_suit, /obj/item/clothing/suit/straight_jacket) && !istype(R.wear_suit, /obj/item/clothing/suit/straight_jacket && !istype(R.wear_suit, /obj/item/clothing/suit/armor)))
			else
				R.burn_skin(0.75)
				if (R.coughedtime != 1)
					R.coughedtime = 1
					R.emote("gasp")
					spawn (20)
						R.coughedtime = 0
				R.updatehealth()
		return

	HasEntered(mob/living/carbon/human/R as mob )
		..()
		if (istype(R, /mob/living/carbon/human))
			if (R.internal != null && usr.wear_mask && (R.wear_mask.flags & MASKINTERNALS) && R.wear_suit != null && !istype(R.wear_suit, /obj/item/clothing/suit/labcoat) && !istype(R.wear_suit, /obj/item/clothing/suit/straight_jacket) && !istype(R.wear_suit, /obj/item/clothing/suit/straight_jacket && !istype(R.wear_suit, /obj/item/clothing/suit/armor)))
				return
			R.burn_skin(0.75)
			if (R.coughedtime != 1)
				R.coughedtime = 1
				R.emote("gasp")
				spawn (20)
					R.coughedtime = 0
			R.updatehealth()
		return
