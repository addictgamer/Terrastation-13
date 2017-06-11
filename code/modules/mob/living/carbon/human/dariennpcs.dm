/obj/item/clothing/under/gobbo
	name = "miniature overalls"
	desc = "A pair of curiously tailored, Mechanics-issue overalls."
//	icon = 'icons/mob/dariennpcs.dmi'
	icon_state = "gobbo"
	item_color = "gobbo"
	species_restricted = list("Monkey")

/mob/living/carbon/human/monkey/gobbo/New()
	..()
	spawn(1)
		name = "Old Gobbo"
		real_name = name
		desc = "A gaunt, aged monkey. His coat is heavy with a particularly pungent odor: A medly of the usual simian je ne sais quoi and years of assorted lubricants."
		equip_to_slot(new /obj/item/clothing/under/gobbo(src), slot_w_uniform)
		equip_to_slot(new /obj/item/clothing/glasses/thermal/monocle(src), slot_glasses)
