
/obj/item/clothing/head/kitty
	name = "Kitty Ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	flags = FPRINT | TABLEPASS | HEADSPACE
	var/icon/mob
	var/icon/mob2

	update_icon(var/mob/living/carbon/human/user)
		if (!istype(user)) return
		mob = new/icon("icon" = 'head.dmi', "icon_state" = "kitty")
		mob2 = new/icon("icon" = 'head.dmi', "icon_state" = "kitty2")
		mob.Blend(rgb(user.r_hair, user.g_hair, user.b_hair), ICON_ADD)
		mob2.Blend(rgb(user.r_hair, user.g_hair, user.b_hair), ICON_ADD)

		var/icon/earbit = new/icon("icon" = 'head.dmi', "icon_state" = "kittyinner")
		var/icon/earbit2 = new/icon("icon" = 'head.dmi', "icon_state" = "kittyinner2")
		mob.Blend(earbit, ICON_OVERLAY)
		mob2.Blend(earbit2, ICON_OVERLAY)
