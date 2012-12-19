
/obj/item/clothing/head/helmet/hardhat
	name = "hard hat"
	desc = "A hat which appears to be very hard."
	icon_state = "hardhat0_yellow"
	flags = FPRINT | TABLEPASS | SUITSPACE
	item_state = "hardhat0_yellow"
	var/brightness_on = 4 //luminosity when on
	var/on = 0
	color = "yellow" //Determines used sprites: hardhat[on]_[color] and hardhat[on]_[color]2 (lying down sprite)
	armor = list(melee = 30, bullet = 5, laser = 20, taser = 10, bomb = 20, bio = 10, rad = 20)
