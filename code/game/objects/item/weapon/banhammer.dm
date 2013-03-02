
/obj/item/weapon/banhammer
	desc = "ALL HAIL THE MIGHTY BANHAMMER!"
	name = "Banhammer"
	icon = 'items.dmi'
	icon_state = "toyhammer"
	flags = FPRINT | ONBELT | TABLEPASS
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15

	attack(mob/M as mob, mob/user as mob)
		M << "<font color='red'><b> You have been banned FOR NO REISIN by [user]</b></font>"
		user << "<font color='red'> You have <b>BANNED</b> [M]. I hope you feel happy about yourself.</font>"
