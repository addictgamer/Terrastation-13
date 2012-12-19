
/obj/item/weapon/mousetrap
	name = "mousetrap"
	desc = "A handy little spring-loaded trap for catching pesty rodents."
	icon = 'weapons.dmi'
	icon_state = "mousetrap"
	item_state = "mousetrap"
	w_class = 1
	force = null
	throwforce = null
	var/armed = 0
	origin_tech = "combat=1"

/obj/item/weapon/mousetrap/examine()
	set src in oview(12)
	..()
	if(armed)
		usr << "\red It looks like it's armed."

/obj/item/weapon/mousetrap/proc/triggered(mob/target as mob, var/type = "feet")
	if(!armed)
		return
	var/datum/organ/external/affecting = null
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		switch(type)
			if("feet")
				if(!H.shoes)
					affecting = H.organs[pick("l_foot", "r_foot")]
					H.weakened = max(3, H.weakened)
			if("l_hand", "r_hand")
				if(!H.gloves)
					affecting = H.organs[type]
					H.stunned = max(3, H.stunned)
		if(affecting)
			affecting.take_damage(1, 0)
			H.UpdateDamageIcon()
			H.updatehealth()
	playsound(target.loc, 'snap.ogg', 50, 1)
	icon_state = "mousetrap"
	armed = 0
/*
	else if (ismouse(target))
		target.bruteloss = 100
*/

/obj/item/weapon/mousetrap/attack_self(mob/user as mob)
	if(!armed)
		icon_state = "mousetraparmed"
		user << "\blue You arm the mousetrap."
	else
		icon_state = "mousetrap"
		if((user.brainloss >= 60 || user.mutations & CLOWN) && prob(50))
			var/which_hand = "l_hand"
			if(!user.hand)
				which_hand = "r_hand"
			src.triggered(user, which_hand)
			user << "\red <B>You accidentally trigger the mousetrap!</B>"
			for(var/mob/O in viewers(user, null))
				if(O == user)
					continue
				O.show_message(text("\red <B>[user] accidentally sets off the mousetrap, breaking their fingers.</B>"), 1)
			return
		user << "\blue You disarm the mousetrap."
	armed = !armed
	playsound(user.loc, 'handcuffs.ogg', 30, 1, -3)

/obj/item/weapon/mousetrap/attack_hand(mob/user as mob)
	if(armed)
		if((user.brainloss >= 60 || user.mutations & CLOWN) && prob(50))
			var/which_hand = "l_hand"
			if(!user.hand)
				which_hand = "r_hand"
			src.triggered(user, which_hand)
			user << "\red <B>You accidentally trigger the mousetrap!</B>"
			for(var/mob/O in viewers(user, null))
				if(O == user)
					continue
				O.show_message(text("\red <B>[user] accidentally sets off the mousetrap, breaking their fingers.</B>"), 1)
			return
	..()

/obj/item/weapon/mousetrap/HasEntered(AM as mob|obj)
	if((ishuman(AM)) && (armed))
		var/mob/living/carbon/H = AM
		if(H.m_intent == "run")
			src.triggered(H)
			H << "\red <B>You accidentally step on the mousetrap!</B>"
			for(var/mob/O in viewers(H, null))
				if(O == H)
					continue
				O.show_message(text("\red <B>[H] accidentally steps on the mousetrap.</B>"), 1)
	..()

/obj/item/weapon/mousetrap/hitby(A as mob|obj)
	if(!armed)
		return ..()
	for(var/mob/O in viewers(src, null))
		O.show_message(text("\red <B>The mousetrap is triggered by [A].</B>"), 1)
	src.triggered(null)

/obj/item/weapon/mousetrap/armed
	icon_state = "mousetraparmed"
	armed = 1
