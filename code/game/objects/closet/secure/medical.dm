
/obj/secure_closet/medical_wall
	anchored = 1
	name = "First Aid Closet"
	desc = "A wall mounted closet which --should-- contain medical supplies."
	icon_state = "medical_wall_locked"
	icon_closed = "medical_wall_unlocked"
	icon_locked = "medical_wall_locked"
	icon_opened = "medical_wall_open"
	icon_broken = "medical_wall_spark"
	icon_off = "medical_wall_off"
	req_access = list(access_medical)
	wall_mounted = 1
	req_access = list(access_tox_storage)

/obj/secure_closet/medical1
	name = "Medicine Closet"
	desc = "Filled with medical junk."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_broken = "medicalbroken"
	icon_off = "medical1"
	req_access = list(access_medical)

/obj/secure_closet/medical1/New()
	..()
	sleep(2)
	//new /obj/item/weapon/storage/gl_kit( src )
	//new /obj/item/weapon/reagent_containers/glass/bottle/antitoxin( src )
	new /obj/item/weapon/reagent_containers/glass/bottle/antitoxin( src )
	new /obj/item/weapon/reagent_containers/glass/bottle/antitoxin( src )
	//new /obj/item/weapon/reagent_containers/glass/bottle/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/glass/bottle/inaprovaline( src )
	new /obj/item/weapon/reagent_containers/glass/bottle/inaprovaline( src )
	//new /obj/item/weapon/reagent_containers/glass/bottle/stoxin( src )
	//new /obj/item/weapon/reagent_containers/glass/bottle/stoxin( src )
	//new /obj/item/weapon/reagent_containers/glass/bottle/toxin( src )
	new /obj/item/weapon/storage/syringes( src )
	new /obj/item/weapon/reagent_containers/dropper( src )
	new /obj/item/weapon/reagent_containers/dropper( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	new /obj/item/weapon/reagent_containers/glass/beaker( src )
	return

/obj/secure_closet/medical2
	name = "Anesthetic"
	desc = "Used to knock people out, but who uses this trash?"
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_broken = "medicalbroken"
	icon_off = "medical1"
	req_access = list(access_medical)

/obj/secure_closet/medical2/New()
	..()
	sleep(2)
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/clothing/mask/medical( src )
	new /obj/item/clothing/mask/medical( src )
	new /obj/item/clothing/mask/medical( src )
	return

/obj/secure_closet/medical3
	name = "Medical Doctor's Locker"
	req_access = list(access_medical)

/obj/secure_closet/medical3/New()
	..()
	sleep(2)
	new /obj/item/clothing/under/rank/medical( src )
	new /obj/item/clothing/suit/labcoat( src )
	new /obj/item/clothing/shoes/white( src )
	new /obj/item/weapon/storage/backpack/medic( src )
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/weapon/cartridge/medical( src )
	new /obj/item/device/radio/headset/headset_med( src )
	new /obj/item/weapon/storage/utilitybelt/medical( src )
	new /obj/item/clothing/under/rank/nursesuit ( src )
	new /obj/item/clothing/head/nursehat ( src )
	return

/obj/secure_closet/CMO
	name = "Chief Medical Officer"
	req_access = list(access_cmo)

/obj/secure_closet/CMO/New()
	..()
	sleep(2)
	new /obj/item/clothing/suit/labcoat/cmo( src )
	new /obj/item/clothing/under/rank/chief_medical_officer( src )
	new /obj/item/clothing/suit/bio_suit/cmo( src )
	new /obj/item/clothing/shoes/brown	( src )
	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/head/bio_hood/general( src )
	new /obj/item/clothing/suit/labcoat(src)
	new /obj/item/clothing/mask/gas( src )
	new /obj/item/device/radio/headset/heads/cmo( src )
	new /obj/item/clothing/under/rank/nursesuit ( src )
	new /obj/item/clothing/head/nursehat ( src )
	return
