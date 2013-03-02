
/mob/living/carbon/alien
	name = "alien"
	voice_name = "alien"
	voice_message = "hisses"
	say_message = "hisses"
	icon = 'alien.dmi'
	gender = NEUTER
	alien_talk_understand = 1
	toxloss = 250
	var
		alien_invis = 0.0
		max_plasma = 500
		obj/item/weapon/card/id/wear_id = null // Fix for station bounced radios -- Skie
		has_fine_manipulation = 0
