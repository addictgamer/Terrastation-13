
/obj/item/clothing/suit
	icon = 'suits.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	flags = FPRINT | TABLEPASS
	var/list/allowed = list(/obj/item/weapon/tank/emergency_oxygen)
	armor = list(melee = 0, bullet = 0, laser = 0, taser = 2, bomb = 0, bio = 0, rad = 0)
	var/allow_poop_to_pass = 0 //Allow poop to pass? Default false.
