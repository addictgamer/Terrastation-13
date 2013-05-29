/mob/living/carbon/human/death(gibbed)
	if(src.stat == 2)
		return
	if(src.healths)
		src.healths.icon_state = "health5"
	src.stat = 2
	src.dizziness = 0
	src.jitteriness = 0

	if (!gibbed)
		if (gaylord)
			for(var/mob/O in viewers(src, null))
				O.show_message("<b>[src.name]</b>'s corpse compacts into a ball and explodes in an outburst of divine energy!...", 1) //THE GOD IS DEAD. Or so the foolish mortals think.
			world << "\red THINK YOU CAN GET RID OF ME, FOOLISH MORTALS? I'LL BE BACK!\nGay."
			explosion(src.loc, rand(1,2),rand(1,5),rand(1,7),rand(1,10)) //Corpse explodes on death.
			var/i = 0
			var/meteorcount = rand(1,5)
			while (i < meteorcount)
				//world << "Sent meteor wave."
				meteor_wave()
				i++
			command_alert("Meteors have been detected on collision course with the station.", "Meteor Alert")
			world << sound('meteors.ogg')
			empulse(src.loc, rand(50,150), rand(100,200)) //EM Pulse on death.
		else
			emote("deathgasp") //let the world KNOW WE ARE DEAD

			take_a_dump(1)
			canmove = 0
			lying = 1
			var/h = src.hand
			hand = 0
			drop_item()
			hand = 1
			drop_item()
			hand = h

		//For ninjas exploding when they die./N
		if (istype(wear_suit, /obj/item/clothing/suit/space/space_ninja)&&wear_suit:s_initialized)
			src << browse(null, "window=spideros")//Just in case.
			var/location = loc
			explosion(location, 1, 2, 3, 4)

		if(src.client)
			src.blind.layer = 0
		//This is where the suicide assemblies checks would go

		if (client)
			spawn(10)
				if(client && src.stat == 2)
					verbs += /mob/proc/ghost

	var/tod = time2text(world.realtime,"hh:mm:ss") //weasellos time of death patch
	if(mind)
		mind.store_memory("Time of death: [tod]", 0)
	sql_report_death(src)

	//Calls the rounds wincheck, mainly for wizard, malf, and changeling now
	ticker.mode.check_win()
	//Traitor's dead! Oh no!
	if (ticker.mode.name == "traitor" && src.mind && src.mind.special_role == "traitor")
		message_admins("\red Traitor [key_name_admin(src)] has died.")
		log_game("Traitor [key_name(src)] has died.")

	var/cancel
	for (var/mob/M in world)
		if (M.client && !M.stat)
			cancel = 1
			break

	if (!cancel && !abandon_allowed)
		spawn (50)
			cancel = 0
			for (var/mob/M in world)
				if (M.client && !M.stat)
					cancel = 1
					break

			if (!cancel && !abandon_allowed)
				world << "<B>Everyone is dead! Resetting in 30 seconds!</B>"

				spawn (300)
					log_game("Rebooting because of no live players")
					world.Reboot()

	return ..(gibbed)
