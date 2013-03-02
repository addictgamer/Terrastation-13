
/mob/living/simple_animal/cat
	name = "Cat"
	desc = "Kitty!!"
	icon = 'mob.dmi'
	icon_state = "tempcat"
	icon_living = "tempcat"
	icon_dead = "cat-dead"
	speak = list("Meow!","Esp!","Purr!","HSSSSS")
	speak_emote = list("purrs", "meows")
	emote_hear = list("meows","mews")
	emote_see = list("shakes it's head", "shivers")
	speak_chance = 1
	turns_per_move = 5
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/corgi
	meat_amount = 1
	response_help  = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"
