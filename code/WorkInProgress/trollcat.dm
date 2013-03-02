
/datum/trollcat/proc/trollcat_arrives() // -- TLE


	command_alert("<B>\red Oh FUUUUUUUUUUUUUUUU! The Trollcat is on [station_name()]!</B>", "<B>Beware the Trollcat. It's agenda is unknown and always changing. Practice EXTREME caution around her.</B>")
	//world << sound('hivebots_announcer.ogg')



	//world << sound('.ogg')
	//world << sound('siren.ogg')
	//world << sound('alarm.wav')
	//world << sound('.mid')

/datum/trollcat/proc/equip_trollcat(mob/living/carbon/human/trollcat_mob)
	if (!istype(trollcat_mob))
		return

	del(trollcat_mob.wear_suit)
	del(trollcat_mob.w_uniform)
	del(trollcat_mob.back)
	del(trollcat_mob.belt)
	del(trollcat_mob.ears)
	del(trollcat_mob.head)
	del(trollcat_mob.shoes)
	del(trollcat_mob.r_hand)
	del(trollcat_mob.l_hand)
	del(trollcat_mob.r_store)
	del(trollcat_mob.l_store)

	trollcat_mob.equip_if_possible(new /obj/item/device/radio/headset/catset(trollcat_mob), slot_ears) //need sprite
	trollcat_mob.equip_if_possible(new /obj/item/weapon/storage/backpack/catpack(trollcat_mob), slot_back) //need sprite
	trollcat_mob.equip_if_possible(new /obj/item/weapon/storage/box/survival(trollcat_mob), slot_in_backpack)
	trollcat_mob.equip_if_possible(new /obj/item/clothing/suit/		(trollcat_mob), slot_wear_suit)
	trollcat_mob.equip_if_possible(new /obj/item/clothing/under/	(trollcat_mob), slot_w_uniform)
	trollcat_mob.equip_if_possible(new /obj/item/device/pda/trollcat(trollcat_mob), slot_belt) //need sprite
	trollcat_mob.equip_if_possible(new /obj/item/clothing/shoes/white(trollcat_mob), slot_shoes)
