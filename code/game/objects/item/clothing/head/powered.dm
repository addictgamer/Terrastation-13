
/obj/item/clothing/head/powered
	name = "Powered armor"
	icon_state = "swat"
	desc = "Not for rookies."
	flags = FPRINT | TABLEPASS | HEADCOVERSEYES | HEADCOVERSMOUTH
	see_face = 0.0
	item_state = "swat"
	armor = list(melee = 40, bullet = 30, laser = 20, taser = 15, bomb = 25, bio = 10, rad = 10)
	var/obj/item/clothing/suit/powered/parent

	proc/atmotoggle()
		set category = "Object"
		set name = "Toggle helmet seals"

		var/mob/living/carbon/human/user = usr

		if(!istype(user))
			user << "\red This helmet is not rated for nonhuman use."
			return

		if(user.head != src)
			user << "\red Can't engage the seals without wearing the helmet."
			return

		if(!user.wear_suit || !istype(user.wear_suit,/obj/item/clothing/suit/powered))
			user << "\red This helmet can only couple with powered armor."
			return

		var/obj/item/clothing/suit/powered/armor = user.wear_suit

		if(!armor.atmoseal || !istype(armor.atmoseal, /obj/item/powerarmor/atmoseal/optional))
			user << "\red This armor's atmospheric seals are missing or incompatible."
			return

		armor.atmoseal:helmtoggle(0,1)
