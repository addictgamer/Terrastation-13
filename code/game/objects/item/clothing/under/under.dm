// UNDERS AND BY THAT, NATURALLY I MEAN UNIFORMS/JUMPSUITS

/obj/item/clothing/under
	icon = 'uniforms.dmi'
	name = "under"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	protective_temperature = T0C + 50
	heat_transfer_coefficient = 0.30
	permeability_coefficient = 0.90
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL
	var/has_sensor = 1//For the crew computer 2 = unable to change mode
	var/sensor_mode = 0
		/*
		1 = Report living/dead
		2 = Report detailed damages
		3 = Report location
		*/

	armor = list(melee = 0, bullet = 0, laser = 2, taser = 2, bomb = 0, bio = 0, rad = 0)
	var/allow_poop_to_pass = 0 //Allow poop to pass? Default false.

/*
/obj/item/clothing/under/nazi1
	name = "Nazi uniform"
	desc = "SIEG HEIL!"
	icon_state = "nazi"
	color = "nazi1"
*/ //no direction sprites

/*
/obj/item/clothing/under/yay
	name = "yay"
	desc = "Yay!"
	icon_state = "yay"
	color = "yay"
*/ // no sprite --errorage

/*
/obj/item/clothing/under/maroon
	name = "maroon"
	desc = "maroon"
	icon_state = "maroon"
	color = "maroon"
*/ // no sprite -- errorage

/* no left/right sprites
/obj/item/clothing/under/mario
	name = "Mario costume"
	desc = "Worn by Italian plumbers everywhere.  Probably."
	icon_state = "mario"
	item_state = "mario"
	color = "mario"

/obj/item/clothing/under/luigi
	name = "Mario costume"
	desc = "Player two.  Couldn't you get the first controller?"
	icon_state = "luigi"
	item_state = "luigi"
	color = "luigi"
*/
