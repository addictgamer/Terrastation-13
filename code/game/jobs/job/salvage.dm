/datum/job/salvage_captain
	title = "Salvage Captain"
	flag = SALVAGE
	department_flag = SUPPORT
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#dddddd"
	req_admin_notify = 1
	access = list(access_salvage_captain, access_external_airlocks, access_maint_tunnels)
	minimal_access = list(access_salvage_captain, access_external_airlocks, access_maint_tunnels)

	minimal_player_age = 21
	outfit = /datum/outfit/job/salvage_captain
/*	equip(var/mob/living/carbon/human/H)
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
*/
/datum/outfit/job/salvage_captain
	name = "Salvage Captain"
	jobtype = /datum/job/salvage_captain

	uniform = /obj/item/clothing/under/rank/security/pod_pilot
	shoes = /obj/item/clothing/shoes/workboots
	l_ear = /obj/item/device/radio/headset/alt
	id = /obj/item/weapon/card/id/salvage_captain
	pda = /obj/item/device/pda
	belt = /obj/item/weapon/storage/belt/utility/full
	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel = /obj/item/weapon/storage/backpack/satchel_eng
	dufflebag = /obj/item/weapon/storage/backpack/duffel
	box = /obj/item/weapon/storage/box/engineer

//this is so the salvage captain can fukken maintain his shit without faggot atmos techs being needed
/obj/machinery/alarm/sc
	req_one_access = list(access_salvage_captain, access_atmospherics, access_engine_equip)
	aidisabled = 1

//this is to dissuade space fgts from breaking the main salvage station
//the altered instance on the station is going to stay there cuz it's a different name and totally not because I'm lazy no sir
/obj/machinery/porta_turret/syndicate/exterior/countermeasure
	name = "Xeno Countermeasure System (7.62)"
	desc = "A gun turret manufactured by the Terraform subdivision of Nanotrasen, modeled after a syndicate device. Designed to keep hostile space life away from outposts."
	faction = "neutral"