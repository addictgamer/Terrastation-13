/datum/job/salvage_captain
	title = "Salvage Captain"
	flag = SALVAGE
	department_flag = KARMA
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#dddddd"
	req_admin_notify = 1
	access = list(access_salvage_captain, access_external_airlocks, access_maint_tunnels)
	minimal_access = list(access_salvage_captain, access_external_airlocks, access_maint_tunnels)

	minimal_player_age = 21

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/alt(H), slot_l_ear)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/industrial(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_eng(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new /obj/item/clothing/under/rank/security/pod_pilot(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
		H.equip_or_collect(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
		H.equip_or_collect(new /obj/item/device/pda(H), slot_wear_pda)
		H.equip_or_collect(new /obj/item/weapon/storage/box/engineer(H), slot_in_backpack)
		return 1
