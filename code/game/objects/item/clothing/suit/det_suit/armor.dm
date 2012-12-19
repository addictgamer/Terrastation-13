
/obj/item/clothing/suit/det_suit/armor
	name = "armor"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	item_state = "armor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	allowed = list(/obj/item/weapon/gun/projectile/detective,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/cigpacket,/obj/item/weapon/zippo,/obj/item/device/detective_scanner,/obj/item/device/taperecorder)
	armor = list(melee = 75, bullet = 25, laser = 50, taser = 10, bomb = 25, bio = 10, rad = 0)
