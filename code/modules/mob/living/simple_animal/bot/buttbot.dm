// I stole from goon, reeee   --LZ

/mob/living/simple_animal/bot/buttbot
	name = "buttbot"
	desc = "Well I... uh... huh."
	icon = 'icons/obj/aibots_goon.dmi'
	icon_state = "buttbot"
//	layer = 5.0 // Todo layer | Copypasta, not sure if this is needed
	density = 0
	anchored = 0
	on = 1
	health = 5
	maxHealth = 5
	var/probuttility = 10
//	no_camera = 1  //again, copypasta.

/mob/living/simple_animal/bot/buttbot/cyber
	name = "robuttbot"
	icon_state = "cyberbuttbot"

/mob/living/simple_animal/bot/buttbot/emag_act(mob/user)
	..()
	if(emagged == 2)
		if(user)
			to_chat(user, "<span class='danger'>[src] buzzes and beeps.</span>")
		playsound(src.loc, "sound/effects/fart2.ogg", 50, 1)

/mob/living/simple_animal/bot/buttbot/handle_automated_action()
	if(!..())
		return

	if(prob(probuttility))
		if(emagged < 2)
			var/message = pick("butts", "butt")
			speak(message)
		else
			var/message = pick("BuTTS", "buTt", "b##t", "bztBUTT", "b^%t", "BUTT", "buott", "bats", "bates", "bouuts", "buttH", "b&/t", "beats", "boats", "booots", "BAAAAATS&/", "//t/%/")
			playsound(src.loc, "sound/voice/poo-vox.ogg", 50, 1) //Do we want this? I think we might want this.
			speak(message)

/mob/living/simple_animal/bot/buttbot/update_icon()
	return