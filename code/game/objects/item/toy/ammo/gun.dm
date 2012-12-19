
/obj/item/toy/ammo/gun
	name = "ammo-caps"
	desc = "There are 7 caps left! Make sure to recyle the box in an autolathe when it gets empty."
	icon = 'ammo.dmi'
	icon_state = "357-7"
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 1.0
	g_amt = 10
	m_amt = 10
	var/amount_left = 7.0

/obj/item/toy/ammo/gun/update_icon()
	src.icon_state = text("357-[]", src.amount_left)
	src.desc = text("There are [] caps\s left! Make sure to recycle the box in an autolathe when it gets empty.", src.amount_left)
	return
