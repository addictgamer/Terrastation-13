
/obj/item/clothing/gloves/space_ninja
	desc = "These nano-enhanced gloves insulate from electricity and provide fire resistance."
	name = "ninja gloves"
	icon_state = "s-ninja"
	item_state = "s-ninja"
	siemens_coefficient = 0
	protective_temperature = 1100
	heat_transfer_coefficient = 0.05
	var/draining = 0
	var/candrain = 0
	var/mindrain = 200
	var/maxdrain = 400
	armor = list(melee = 60, bullet = 50, laser = 30, taser = 15, bomb = 30, bio = 30, rad = 30)
