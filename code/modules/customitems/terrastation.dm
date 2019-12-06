//icons/mob/suit.dmi for the mob overlay
//icons/obj/clothing/suits.dmi for the item

/obj/item/clothing/suit/storage/hazardvest/lz
	name = "LZ's Hazard Vest"
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
	name = "Tauka's Hazard Vest"
	desc = "A visibility vest supposedly used in work zones. This one seems to defy the laws of spacetime as well as common fucking sense."
	icon_state = "hazardfgt"
	item_state = "hazardfgt"
	allowed = list (/obj/item/weapon/tank/emergency_oxygen, /obj/item/weapon/katana)
	//Maybe if Tauka reads the correct documentation he would understand what the fuck is going on better. Hey, since I'm not documenting I made this comment, will he even see it? Who knows?! I'm still going to call him a fucking wankass spooby fuckwit!

/obj/item/clothing/suit/storage/hazardvest/tauka/New()
	..()
	new /obj/item/weapon/katana(src.pockets) //yes, I know, wtf. Cannot resheath it in here. Yes, I know, wtf.
	new /obj/item/device/analyzer(src.pockets) //this was originally a test line but it stayed in cuz lol

/obj/item/clothing/suit/storage/hazardvest/terraform/armed/New()
	..()
	new /obj/item/weapon/gun/projectile/revolver/mateba(src.pockets)


/obj/item/clothing/suit/storage/hazardvest/terraform/addict
	name = "Addictgamer Hazard Vest"
	desc = "A high-visibility vest used in work zones. This one is colored differently and has the letters A and G embroidered on it."
	icon_state = "hazardag"
	item_state = "hazardag"
	//I still need a proper gimmick for this one.

/obj/item/clothing/suit/storage/hazardvest/bast //has no tangible gimmick (like different storage), but makes the user appear as a gravekeeper drone
	name = "Doorkeeper Hazard Vest"
	desc = "A.... vest. It's a vest. At least, it appears to be."
	icon_state = "doorkeeper"
	item_state = "doorkeeper"

/obj/item/clothing/suit/storage/hazardvest/bast/equipped(mob/living/user, slot)
	..()
	if(slot == slot_wear_suit)
		enspoob(user)

/obj/item/clothing/suit/storage/hazardvest/bast/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("bastborg")

/obj/item/clothing/suit/storage/hazardvest/bast/proc/enspoob(mob/living/QQ)
	if(istype(QQ))
		var/image/I = image(icon = 'icons/mob/robots.dmi' , icon_state = pick("drone-gravekeeper", "drone-lost"), loc = QQ)
		I.override = 1
		QQ.add_alt_appearance("bastborg", I, living_mob_list)

/obj/item/clothing/suit/storage/hazardvest/qui
	name = "Qui's Hazard Vest"
	desc = "A high-visibility vest that screams you are not to be taken seriously."
	icon_state = "hazardqp"
	item_state = "hazardqp"
	allowed = list (/obj/item/weapon)

/obj/item/clothing/suit/storage/hazardvest/qui/armed/New()
	..()
	new /obj/item/weapon/gun/throw/piecannon/qui(src.pockets)

//end haz vests, begin other spoob

/obj/item/clothing/head/helmet/space/hardsuit/mining/last
	name = "last miner standing helmet"
	icon_state = "hardsuit0-xenominer"
	item_state = "xenos_helm"
	item_color = "xenominer"

/obj/item/clothing/suit/space/hardsuit/mining/last
	name = "last miner standing suit"
	icon_state = "xenos"
	item_state = "xenos_helm"