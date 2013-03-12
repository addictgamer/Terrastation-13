
/obj/decal/cleanable/poop //Do not spawn this, spawn poop/splatter
	name = "Poop"
	desc = "It's brown. It's sloshy. It smells bad. Somebody must have taken a dump here."
	density = 0
	anchored = 1
	layer = 2
	icon = 'poop.dmi'

	HasEntered(AM as mob|obj)
		..()
		if (istype(AM, /mob/living/carbon))
			var/mob/M =	AM
			if ((istype(M, /mob/living/carbon/human) && (istype(M:shoes, /obj/item/clothing/shoes) && M:shoes.flags&NOSLIP)) || M.m_intent == "walk")
				return
			M.pulling = null
			M << "\blue You slipped on the poop!"
			playsound(src.loc, 'slip.ogg', 50, 1, -3)
			M.stunned = 8
			M.weakened = 5
