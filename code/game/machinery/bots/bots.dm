// AI (i.e. game AI, not the AI player) controlled bots

/obj/machinery/bot
	icon = 'aibots.dmi'
	layer = MOB_LAYER
	var/obj/item/weapon/card/id/botcard			// the ID card that the bot "holds"
	var/on = 1
	var/health = 0 //do not forget to set health for your bot!
	var/maxhealth = 0
	var/fire_dam_coeff = 1.0
	var/brute_dam_coeff = 1.0
	var/emagged = 0 //Urist: Moving that var to the general /bot tree as it's used by most bots


/obj/machinery/bot/proc/turn_on()
	if (stat)
		return 0
	src.on = 1
	return 1

/obj/machinery/bot/proc/turn_off()
	src.on = 0

/obj/machinery/bot/proc/explode()
	del(src)

/obj/machinery/bot/proc/healthcheck()
	if (src.health <= 0)
		src.explode()

/obj/machinery/bot/proc/Emag(mob/user as mob)
	if(!emagged) emagged = 1

/obj/machinery/bot/examine()
	set src in view()
	..()
	if (src.health < maxhealth)
		if (src.health > maxhealth/3)
			usr << text("\red [src]'s parts look loose.")
		else
			usr << text("\red <B>[src]'s parts look very loose!</B>")
	return

/obj/machinery/bot/attack_alien(var/mob/living/carbon/alien/user as mob)
	/* Well, aliums dislike machines and do not want to caress them.
	if (user.a_intent == "help")
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\blue [user] caresses [src.name] with its scythe like arm."), 1)
	else
	*/
	src.health -= rand(15,30)*brute_dam_coeff
	src.visible_message("\red <B>[user] has slashed [src]!</B>")
	playsound(src.loc, 'slice.ogg', 25, 1, -1)
	if(prob(10))
		new /obj/decal/cleanable/oil(src.loc)
	healthcheck()



/obj/machinery/bot/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.health < maxhealth)
			src.health = min(maxhealth, src.health+25)
			user.visible_message(
				"\red [user] repairs [src]!",
				"\blue You repair [src]!"
			)
		else
			user << "\blue [src] does not need a repair!"
	else if (istype(W, /obj/item/weapon/card/emag) && !emagged)
		Emag(user)
	else
		switch(W.damtype)
			if("fire")
				src.health -= W.force * fire_dam_coeff
			if("brute")
				src.health -= W.force * brute_dam_coeff
		..()
		healthcheck()

/obj/machinery/bot/bullet_act(var/obj/item/projectile/Proj)
	health -= Proj.damage
	..()
	healthcheck()

/obj/machinery/bot/meteorhit()
	src.explode()
	return

/obj/machinery/bot/blob_act()
	src.health -= rand(20,40)*fire_dam_coeff
	healthcheck()
	return

/obj/machinery/bot/ex_act(severity)
	switch(severity)
		if(1.0)
			src.explode()
			return
		if(2.0)
			src.health -= rand(5,10)*fire_dam_coeff
			src.health -= rand(10,20)*brute_dam_coeff
			healthcheck()
			return
		if(3.0)
			if (prob(50))
				src.health -= rand(1,5)*fire_dam_coeff
				src.health -= rand(1,5)*brute_dam_coeff
				healthcheck()
				return
	return

/obj/machinery/bot/emp_act(severity)
	var/was_on = on
	stat |= EMPED
	var/obj/overlay/pulse2 = new/obj/overlay ( src.loc )
	pulse2.icon = 'effects.dmi'
	pulse2.icon_state = "empdisable"
	pulse2.name = "emp sparks"
	pulse2.anchored = 1
	pulse2.dir = pick(cardinal)

	spawn(10)
		del(pulse2)
	if (on)
		turn_off()
	spawn(severity*300)
		stat &= ~EMPED
		if (was_on)
			turn_on()


/obj/machinery/bot/attack_ai(mob/user as mob)
	if (src.on)
		turn_off()
	else
		turn_on()

/******************************************************************/
// Navigation procs
// Used for A-star pathfinding


