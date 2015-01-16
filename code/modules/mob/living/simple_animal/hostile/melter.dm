/mob/living/simple_animal/melterling
	name = "melterling"
	desc = "You have very, VERY bad feeling about this."
	icon = 'icons/mob/critter.dmi'
	icon_state = "melter"
	icon_living = "melter"
	icon_dead = "melter"
	speak_emote = list("makes some ugly gargling nosie")
	health = 1
	maxHealth = 1
	attacktext = "slaps"
	melee_damage_lower = 1
	melee_damage_upper = 2

	death()
		src.visible_message("<b>[src]</b> ruptures and explodes!")
		var/turf/T = get_turf(src.loc)
		if(T)
			T.hotspot_expose(700,125)
			explosion(T, -1, -1, 2, 3)
		src.gib()