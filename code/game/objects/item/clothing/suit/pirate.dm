
/obj/item/clothing/suit/pirate
	name = "pirate coat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	flags = FPRINT | TABLEPASS
	allowed = list(/obj/item) //Allow all items.
	armor = list(melee = 10, bullet = 5, laser = 5, taser = 20, bomb = 5, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
