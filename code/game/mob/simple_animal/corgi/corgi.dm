
/mob/living/simple_animal/corgi
	name = "Corgi"
	desc = "Puppy!!"
	icon = 'mob.dmi'
	icon_state = "corgi"
	icon_living = "corgi"
	icon_dead = "corgi_dead"
	speak = list("YAP","Woof!","Bark!","AUUUUUU")
	speak_emote = list("barks", "woofs")
	emote_hear = list("barks","woofs","yaps")
	emote_see = list("shakes it's head", "shivers")
	speak_chance = 1
	turns_per_move = 5
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/corgi
	meat_amount = 3
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"
