//This file is Dragon Toast-related stuff for backstory whathaveyou

/*
Insert a quick way to deliver these spells to DT here, as the Give Spell option is kind of slow
Also insert actual attacks, such as the one with the same name
*/

/*temporarily putting here for reference
/obj/effect/proc_holder/spell/proc/invocation(mob/user = usr) //spelling the spell out and setting it on recharge/reducing charges amount
	switch(invocation_type)
		if("shout")
			if(prob(50))//Auto-mute? Fuck that noise
				user.say(invocation)
			else
				user.say(replacetext(invocation," ","`"))
		if("whisper")
			if(prob(50))
				user.whisper(invocation)
			else
				user.whisper(replacetext(invocation," ","`"))
		if("emote")
			user.visible_message(invocation, invocation_emote_self) //same style as in mob/living/emote.dm
*/


//YOU FUCKING WANKER
/obj/effect/proc_holder/spell/targeted/call_wanker
	name = "Call someone a wanker"
	desc = "Calls someone a wanker, because they obviously deserve it."

	school = "DT"
	charge_max = 300
	clothes_req = 0
	invocation = "YOU FUKKEN WANKAH!"
	invocation_type = "shout"
	range = -1
	include_user = 1
	cooldown_min = 300 //what does this do?

/obj/effect/proc_holder/spell/targeted/call_wanker/invocation(mob/user = usr) //I don't want those damn backticks in here
	user.say(invocation)

/obj/effect/proc_holder/spell/targeted/call_wanker/cast(list/targets, mob/user = usr)
	playsound(usr.loc, 'sound/voice/LZ/ufuknwanka.ogg', 30, 1)
	return

//end wanker



//fart verb that is functionally identical to smoke except makes a fart noise			cuz he has a farting problem right
/obj/effect/proc_holder/spell/targeted/fart
	name = "Fart"
	desc = "Kinda self-explanatory."

	school = "conjuration"
	charge_max = 120
	clothes_req = 0
	invocation = ""
	invocation_type = "emote"
	range = -1
	include_user = 1
	cooldown_min = 20 //25 deciseconds reduction per rank

	smoke_spread = 2
	smoke_amt = 10

	action_icon_state = "smoke"

/obj/effect/proc_holder/spell/targeted/fart/cast(list/targets, mob/user = usr)
	if(isliving(usr))
		usr.emote("fart")
	else
		visible_message("Somebody farts like the nasty bastard they are.")
		playsound(usr.loc, 'sound/effects/fart2.ogg', 40, 0)
	return