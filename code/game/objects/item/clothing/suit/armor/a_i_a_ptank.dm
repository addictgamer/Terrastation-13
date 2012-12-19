
/obj/item/clothing/suit/armor/a_i_a_ptank
	desc = "A wearable bomb with a health analyzer attached"
	name = "Analyzer/Igniter/Armor/Plasmatank Assembly"
	icon_state = "bomb"
	item_state = "bombvest"
	var/obj/item/device/healthanalyzer/part1 = null
	var/obj/item/device/igniter/part2 = null
	var/obj/item/clothing/suit/armor/vest/part3 = null
	var/obj/item/weapon/tank/plasma/part4 = null
	var/status = 0
	flags = FPRINT | TABLEPASS | CONDUCT | ONESIZEFITSALL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	canremove = 0
	armor = list(melee = 50, bullet = 15, laser = 50, taser = 10, bomb = 25, bio = 10, rad = 0)
