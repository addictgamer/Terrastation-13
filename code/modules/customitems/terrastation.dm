/obj/item/clothing/suit/storage/hazardvest/lz
	name = "LZ's Hazard vest"
	desc = "A somewhat-high-visibility vest used in work zones. This one appears to have been modified to carry something specific."
	allowed = list (/obj/item/device/flashlight, /obj/item/weapon/tank/emergency_oxygen, /obj/item/weapon/crowbar/large)
	icon_state = "hazardlz"
	item_state = "hazardlz"


/obj/item/clothing/suit/storage/hazardvest/terraform
	desc = "A high-visibility vest used in work zones. This one is colored differently and has the word \"Terraform\" embroidered on it."
	icon_state = "hazardts"
	item_state = "hazardts"
	allowed = list (/obj/item/device/flashlight, /obj/item/weapon/tank/emergency_oxygen, /obj/item/device/t_scanner, /obj/item/weapon/gun/projectile/revolver/mateba)

/obj/item/clothing/suit/storage/hazardvest/tauka
	name = "Tauka's Hazard vest"
	desc = "A visibility vest supposedly used in work zones. This one seems to defy the laws of spacetime as well as common fucking sense."
	icon_state = "hazardfgt"
	item_state = "hazardfgt"
	allowed = list (/obj/item/weapon/tank/emergency_oxygen, /obj/item/weapon/katana)

/obj/item/clothing/suit/storage/hazardvest/tauka/New()
	..()
	new /obj/item/weapon/katana(src.pockets) //yes, I know, wtf. Cannot resheath it in here. Yes, I know, wtf.
	new /obj/item/device/analyzer(src.pockets) //this was originally a test line but it stayed in cuz lol

/*
/obj/item/clothing/suit/storage/hazardvest/terraform/addict
	desc = "A high-visibility vest used in work zones. This one is colored differently and has the letters A and G embroidered on it."
	icon_state = "hazardag"
	//I still need a proper gimmick for this one.
*/