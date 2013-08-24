/mob/living/carbon/human/death(gibbed)
	if (src.stat == 2)
		return
	if (src.healths)
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
			//RESPAWN GAYLORD
			//world << "THIS IS UBBER TEST."
			//spawn(50) respawn_gaylord()
			//world << "This is test 2."
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

		if (src.client)
			src.blind.layer = 0
		//This is where the suicide assemblies checks would go

		if (client)
			spawn(10)
				if (client && src.stat == 2)
					verbs += /mob/proc/ghost

	var/tod = time2text(world.realtime,"hh:mm:ss") //weasellos time of death patch
	if (mind)
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

	if (gaylord)
		respawn_gaylord()

	return ..(gibbed)


/proc/respawn_gaylord()
	//world << "Respawning gaylord."
	var/mob/dead/observer/G_found
	for(var/mob/dead/observer/G in world)
		if (G.client)
			if (ckey(G.key) == ckey("addictgamer") || ckey(G.key) == ckey("Addictgamer"))
				G_found = G
				break

	if (!G_found)//If a ghost was not found.
		world << "There is no active key addictgamer in the game or the person is not currently a ghost. Aborting resurrection."
		return

	//First we spawn a dude.
	var/mob/living/carbon/human/new_character = new(src)//The mob being spawned.


	/*Third, we try and locate a record for the person being respawned through data_core.
	This isn't an exact science but it does the trick more often than not.*/
	var/datum/data/record/record_found//Referenced to later to either randomize or not randomize the character.
	if (G_found.mind)//They must have a mind to reference the record. Here we also double check for aliens.
		var/id = md5("[G_found.real_name][G_found.mind.assigned_role]")
		for(var/datum/data/record/t in data_core.locked)
			if (t.fields["id"]==id)
				record_found = t//We shall now reference the record.
				break

		//Now we do some mind locating to see how to set up the rest of the character.
	if (G_found.mind)//If they had a previous mind.
		new_character.mind = G_found.mind
		new_character.mind.special_verbs = list()//New list because they will receive them again.
	else
		new_character.mind = new()
		ticker.minds += new_character.mind//And we'll add it to the minds database.
		new_character.mind.original = new_character//If they are respawning with a new character.
	if (!record_found)//We have to pick their role if they have no record.
		if (G_found.mind&&G_found.mind.assigned_role)//But they may have an assigned role already.
			new_character.mind.assigned_role = G_found.mind.assigned_role//Also makes sure our MODE people are equipped right later on.
		else
			var/assigned_role = input("Please specify which job the character will be respawned as.", "Assigned role") as null|anything in get_all_jobs()
			if (!assigned_role)	new_character.mind.assigned_role = "Assistant"//Defaults to assistant.
			else	new_character.mind.assigned_role = assigned_role

	if (!new_character.mind.assigned_role)	new_character.mind.assigned_role = "Assistant"//If they somehow got a null assigned role.
	new_character.mind.key = G_found.key//In case it's someone else playing as that character.
	new_character.mind.current = new_character//So that it can properly reference later if needed.
	new_character.mind.memory = ""//Memory erased so it doesn't get clunkered up with useless info. This means they may forget their previous mission--this is usually handled through objective code and recalling memory.

	//Here we either load their saved appearance or randomize it.
	var/datum/preferences/A = new()
	if (A.savefile_load(G_found))//If they have a save file. This will automatically load their parameters.
	//Note: savefile appearances are overwritten later on if the character has a data_core entry. By appearance, I mean the physical appearance.
		var/name_safety = G_found.real_name//Their saved parameters may include a random name. Also a safety in case they are playing a character that got their name after round start.
		A.copy_to(new_character)
		new_character.real_name = name_safety
		new_character.name = name_safety
	else
		if (record_found)//If they have a record we can determine a few things.
			new_character.real_name = record_found.fields["name"]//Not necessary to reference the record but I like to keep things uniform.
			new_character.name = record_found.fields["name"]
			new_character.gender = record_found.fields["sex"]//Sex
			new_character.age = record_found.fields["age"]//Age
			new_character.b_type = record_found.fields["b_type"]//Blood type
			//We will update their appearance when determining DNA.
		else
			new_character.gender = MALE
			if (alert("Save file not detected. Record data not detected. Please specify [G_found.real_name]'s gender.",,"Male","Female")=="Female")
				new_character.gender = FEMALE
			var/name_safety = G_found.real_name//Default is a random name so we want to save this.
			A.randomize_appearance_for(new_character)//Now we will randomize their appearance since we have no way of knowing what they look/looked like.
			new_character.real_name = name_safety
			new_character.name = name_safety

	//After everything above, it's time to initialize their DNA.
	if (record_found)//Pull up their name from database records if they did have a mind.
		new_character.dna = new()//Let's first give them a new DNA.
		new_character.dna.unique_enzymes = record_found.fields["b_dna"]//Enzymes are based on real name but we'll use the record for conformity.
		new_character.dna.struc_enzymes = record_found.fields["enzymes"]//This is the default of enzymes so I think it's safe to go with.
		new_character.dna.uni_identity = record_found.fields["identity"]//DNA identity is carried over.
		updateappearance(new_character,new_character.dna.uni_identity)//Now we configure their appearance based on their unique identity, same as with a DNA machine or somesuch.
	else//If they have no records, we just do a random DNA for them, based on their random appearance/savefile.
		new_character.dna.ready_dna(new_character)

	//Here we need to find where to spawn them.
	var/spawn_here = pick(latejoin)//"JoinLate" is a landmark which is deleted on round start. So, latejoin has to be used instead.
	new_character.loc = spawn_here
	//If they need to spawn elsewhere, they will be transferred there momentarily.

	/*
	The code below functions with the assumption that the mob is already a traitor if they have a special role.
	So all it does is re-equip the mob with powers and/or items. Or not, if they have no special role.
	If they don't have a mind, they obviously don't have a special role.
	*/

	//Two variables to properly announce later on.
	var/admin = key_name_admin(src)
	var/player_key = G_found.key

	new_character.key = player_key//Throw them into the mob.

	//Now for special roles and equipment.
	switch(new_character.mind.special_role)
		if ("Changeling")
			new_character.Equip_Rank(new_character.mind.assigned_role, joined_late=1)
			new_character.make_changeling()
		if ("traitor")
			new_character.Equip_Rank(new_character.mind.assigned_role, joined_late=1)
			ticker.mode.equip_traitor(new_character)
		if ("Wizard")
			new_character.loc = pick(wizardstart)
			ticker.mode.learn_basic_spells(new_character)
			ticker.mode.equip_wizard(new_character)
		if ("Syndicate")
			var/obj/landmark/synd_spawn = locate("landmark*Syndicate-Spawn")
			if (synd_spawn)
				new_character.loc = get_turf(synd_spawn)
			call(/datum/game_mode/proc/equip_syndicate)(new_character)
		if ("Space Ninja")
			var/ninja_spawn[] = list()
			for(var/obj/landmark/L in world)
				if (L.name=="carpspawn")
					ninja_spawn += L
			new_character.equip_space_ninja()
			new_character.internal = new_character.s_store
			new_character.internals.icon_state = "internal1"
			if (ninja_spawn.len)
				var/obj/landmark/ninja_spawn_here = pick(ninja_spawn)
				new_character.loc = ninja_spawn_here.loc
		if ("Death Commando")//Leaves them at late-join spawn.
			new_character.equip_death_commando()
			new_character.internal = new_character.s_store
			new_character.internals.icon_state = "internal1"
		else//They may also be a cyborg or AI.
			switch(new_character.mind.assigned_role)
				if ("Cyborg")//More rigging to make em' work and check if they're traitor.
					new_character = new_character.Robotize()
					if (new_character.mind.special_role=="traitor")
						call(/datum/game_mode/proc/add_law_zero)(new_character)
				if ("AI")
					new_character = new_character.AIize()
					if (new_character.mind.special_role=="traitor")
						call(/datum/game_mode/proc/add_law_zero)(new_character)
				//Add aliens.
				else
					new_character.Equip_Rank(new_character.mind.assigned_role, joined_late=1)//Or we simply equip them.

	//Announces the character on all the systems, based on the record.
	if (!issilicon(new_character))//If they are not a cyborg/AI.
		if (!record_found&&new_character.mind.assigned_role!="MODE")//If there are no records for them. If they have a record, this info is already in there. MODE people are not announced anyway.
			//Power to the user!
			if (alert(new_character,"Warning: No data core entry detected. Would you like to announce the arrival of this character by adding them to various databases, such as medical records?",,"No","Yes")=="Yes")
				call(/mob/new_player/proc/ManifestLateSpawn)(new_character)

			if (alert(new_character,"Would you like an active AI to announce this character?",,"No","Yes")=="Yes")
				call(/mob/new_player/proc/AnnounceArrival)(new_character, new_character.mind.assigned_role)

	message_admins("\blue [admin] has respawned [player_key] as [new_character.real_name].", 1)

	new_character << "You have been fully respawned. Enjoy the game."

	del(G_found)//Don't want to leave ghosts around.
	return new_character
