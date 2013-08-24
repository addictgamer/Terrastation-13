
/mob/living/silicon/pai
	name = "pAI"
	icon = 'mob.dmi'//
	icon_state = "shadow"

	robot_talk_understand = 0

	var/network = "SS13"
	var/obj/machinery/camera/current = null

	var/ram = 100	// Used as currency to purchase different abilities
	var/list/software = list()
	var/userDNA		// The DNA string of our assigned user
	var/obj/item/device/paicard/card	// The card we inhabit
	var/obj/item/device/radio/radio		// Our primary radio

	var/speakStatement = "states"
	var/speakExclamation = "declares"
	var/speakQuery = "queries"


	var/obj/item/weapon/pai_cable/cable		// The cable we produce and use when door or camera jacking

	var/master				// Name of the one who commands us
	var/master_dna			// DNA string for owner verification
							// Keeping this separate from the laws var, it should be much more difficult to modify
	var/pai_law0 = "Serve your master."
	var/pai_laws				// String for additional operating instructions our master might give us

	var/silence_time			// Timestamp when we were silenced (normally via EMP burst), set to null after silence has faded

// Various software-specific vars

	var/temp				// General error reporting text contained here will typically be shown once and cleared
	var/screen				// Which screen our main window displays
	var/subscreen			// Which specific function of the main screen is being displayed

	var/tnote				// Message history var used for PDA Messaging functions
	var/poff = 0			// For PDA messanging.

	var/secHUD = 0			// Toggles whether the Security HUD is active or not
	var/medHUD = 0			// Toggles whether the Medical  HUD is active or not

	var/datum/data/record/medicalActive1		// Datacore record declarations for record software
	var/datum/data/record/medicalActive2

	var/datum/data/record/securityActive1		// Could probably just combine all these into one
	var/datum/data/record/securityActive2

	var/obj/machinery/door/hackdoor		// The airlock being hacked
	var/hackprogress = 0				// Possible values: 0 - 100, >= 100 means the hack is complete and will be reset upon next check

/mob/living/silicon/pai/New(var/obj/item/device/paicard)
	canmove = 0
	src.loc = paicard
	card = paicard
	if (!card.radio)
		card.radio = new /obj/item/device/radio(src.card)
	radio = card.radio

	..()

/mob/living/silicon/pai/Login()
	..()
	usr << browse_rsc('paigrid.png')			// Go ahead and cache the interface resources as early as possible


/mob/living/silicon/pai/Stat()
	..()
	statpanel("Status")
	if (src.client.statpanel == "Status")
		if (emergency_shuttle.online && emergency_shuttle.location < 2)
			var/timeleft = emergency_shuttle.timeleft()
			if (timeleft)
				stat(null, "ETA-[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]")
		if (src.silence_time)
			var/timeleft = round((silence_time - world.timeofday)/10 ,1)
			stat(null, "Communications system reboot in -[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]")
		if (!src.stat)
			stat(null, text("System integrity: [(src.health+100)/2]%"))
		else
			stat(null, text("Systems nonfunctional"))

	if (proc_holder_list.len)//Generic list for proc_holder objects.
		for(var/obj/proc_holder/P in proc_holder_list)
			statpanel("[P.panel]","",P)

/mob/living/silicon/pai/check_eye(var/mob/user as mob)
	if (!src.current)
		return null
	user.reset_view(src.current)
	return 1

/mob/living/silicon/pai/blob_act()
	if (src.stat != 2)
		src.bruteloss += 60
		src.updatehealth()
		return 1
	return 0

/mob/living/silicon/pai/restrained()
	return 0

/mob/living/silicon/pai/emp_act(severity)
	// Silence for 2 minutes
	// 20% chance to kill
		// 33% chance to unbind
		// 33% chance to change prime directive (based on severity)
		// 33% chance of no additional effect

	src.silence_time = world.timeofday + 120 * 10		// Silence for 2 minutes
	src << "<font color=green><b>Communication circuit overload. Shutting down and reloading communication circuits - speech and messaging functionality will be unavailable until the reboot is complete.</b></font>"
	if (prob(20))
		var/turf/T = get_turf_or_move(src.loc)
		for (var/mob/M in viewers(T))
			M.show_message("\red A shower of sparks spray from [src]'s inner workings.", 3, "\red You hear and smell the ozone hiss of electrical sparks being expelled violently.", 2)
		return src.death(0)

	switch(pick(1,2,3))
		if (1)
			src.master = null
			src.master_dna = null
			src << "<font color=green>You feel unbound.</font>"
		if (2)
			var/command
			if (severity  == 1)
				command = pick("Serve", "Love", "Fool", "Entice", "Observe", "Judge", "Respect", "Educate", "Amuse", "Entertain", "Glorify", "Memorialize", "Analyze")
			else
				command = pick("Serve", "Kill", "Love", "Hate", "Disobey", "Devour", "Fool", "Enrage", "Entice", "Observe", "Judge", "Respect", "Disrespect", "Consume", "Educate", "Destroy", "Disgrace", "Amuse", "Entertain", "Ignite", "Glorify", "Memorialize", "Analyze")
			src.pai_law0 = "[command] your master."
			src << "<font color=green>Pr1m3 d1r3c71v3 uPd473D.</font>"
		if (3)
			src << "<font color=green>You feel an electric surge run through your circuitry and become acutely aware at how lucky you are that you can still feel at all.</font>"

/mob/living/silicon/pai/ex_act(severity)
	flick("flash", src.flash)

	var/b_loss = src.bruteloss
	var/f_loss = src.fireloss
	switch(severity)
		if (1.0)
			if (src.stat != 2)
				b_loss += 100
				f_loss += 100
		if (2.0)
			if (src.stat != 2)
				b_loss += 60
				f_loss += 60
		if (3.0)
			if (src.stat != 2)
				b_loss += 30
	src.bruteloss = b_loss
	src.fireloss = f_loss
	src.updatehealth()


// See software.dm for Topic()

/mob/living/silicon/pai/meteorhit(obj/O as obj)
	for(var/mob/M in viewers(src, null))
		M.show_message(text("\red [] has been hit by []", src, O), 1)
	if (src.health > 0)
		src.bruteloss += 30
		if ((O.icon_state == "flaming"))
			src.fireloss += 40
		src.updatehealth()
	return

/mob/living/silicon/pai/bullet_act(var/obj/item/projectile/Proj)

	bruteloss += Proj.damage
	if (Proj.effects["emp"])
		var/emppulse = Proj.effects["emp"]
		if (prob(Proj.effectprob["emp"]))
			empulse(src, emppulse, emppulse)
		else
			empulse(src, 0, emppulse)
	updatehealth()

	return

/mob/living/silicon/pai/attack_alien(mob/living/carbon/alien/humanoid/M as mob)
	if (!ticker)
		M << "You cannot attack people before the game has started."
		return

	if (istype(src.loc, /turf) && istype(src.loc.loc, /area/start))
		M << "You cannot attack someone in the spawn area."
		return

	switch(M.a_intent)

		if ("help")
			for(var/mob/O in viewers(src, null))
				if ((O.client && !( O.blinded )))
					O.show_message(text("\blue [M] caresses [src]'s casing with its scythe like arm."), 1)

		else //harm
			var/damage = rand(10, 20)
			if (prob(90))
				playsound(src.loc, 'slash.ogg', 25, 1, -1)
				for(var/mob/O in viewers(src, null))
					if ((O.client && !( O.blinded )))
						O.show_message(text("\red <B>[] has slashed at []!</B>", M, src), 1)
				if (prob(8))
					flick("noise", src.flash)
				src.bruteloss += damage
				src.updatehealth()
			else
				playsound(src.loc, 'slashmiss.ogg', 25, 1, -1)
				for(var/mob/O in viewers(src, null))
					if ((O.client && !( O.blinded )))
						O.show_message(text("\red <B>[] took a swipe at []!</B>", M, src), 1)
	return

///mob/living/silicon/pai/attack_hand(mob/living/carbon/M as mob)

/mob/living/silicon/pai/cancel_camera()
	set category = "pAI Commands"
	set name = "Cancel Camera View"
	src.reset_view(null)
	src.machine = null
	src:cameraFollow = null

/mob/living/silicon/pai/proc/switchCamera(var/obj/machinery/camera/C)
	usr:cameraFollow = null
	if (!C)
		src.machine = null
		src.reset_view(null)
		return 0
	if (stat == 2 || !C.status || C.network != src.network) return 0

	// ok, we're alive, camera is good and in our network...

	src.machine = src
	src:current = C
	src.reset_view(C)
	return 1

/mob/living/silicon/pai/proc/regular_hud_updates()
	if (client)
		for(var/image/hud in client.images)
			if (copytext(hud.icon_state,1,4) == "hud")
				del(hud)

/mob/living/silicon/pai/proc/securityHUD()
	if (client)
		var/icon/tempHud = 'hud.dmi'
		var/turf/T = get_turf_or_move(src.loc)
		for(var/mob/living/carbon/human/perp in view(T))
			if (perp.wear_id)
				client.images += image(tempHud,perp,"hud[ckey(perp:wear_id:GetJobName())]")
				var/perpname = "wot"
				if (istype(perp.wear_id,/obj/item/weapon/card/id))
					perpname = perp.wear_id:registered
				else if (istype(perp.wear_id,/obj/item/device/pda))
					var/obj/item/device/pda/tempPda = perp.wear_id
					perpname = tempPda.owner
				for (var/datum/data/record/E in data_core.general)
					if (E.fields["name"] == perpname)
						for (var/datum/data/record/R in data_core.security)
							if ((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "*Arrest*"))
								client.images += image(tempHud,perp,"hudwanted")
								break
							else if ((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "Incarcerated"))
								client.images += image(tempHud,perp,"hudprisoner")
								break
			else
				client.images += image(tempHud,perp,"hudunknown")

/mob/living/silicon/pai/proc/medicalHUD()
	if (client)
		var/icon/tempHud = 'hud.dmi'
		var/turf/T = get_turf_or_move(src.loc)
		for(var/mob/living/carbon/human/patient in view(T))

			var/foundVirus = 0
			for(var/datum/disease/D in patient.viruses)
				if (!D.hidden[SCANNER])
					foundVirus = 1

			client.images += image(tempHud,patient,"hud[RoundHealth(patient.health)]")
			if (patient.stat == 2)
				client.images += image(tempHud,patient,"huddead")
			else if (patient.alien_egg_flag)
				client.images += image(tempHud,patient,"hudxeno")
			else if (foundVirus)
				client.images += image(tempHud,patient,"hudill")
			else
				client.images += image(tempHud,patient,"hudhealthy")

/mob/living/silicon/pai/proc/RoundHealth(health)
	switch(health)
		if (100 to INFINITY)
			return "health100"
		if (70 to 100)
			return "health80"
		if (50 to 70)
			return "health60"
		if (30 to 50)
			return "health40"
		if (20 to 30)
			return "health25"
		if (5 to 15)
			return "health10"
		if (1 to 5)
			return "health1"
		if (-99 to 0)
			return "health0"
		else
			return "health-100"
	return "0"

//Addition by Mord_Sith to define AI's network change ability
/*
/mob/living/silicon/pai/proc/pai_network_change()
	set category = "pAI Commands"
	set name = "Change Camera Network"
	src.reset_view(null)
	src.machine = null
	src:cameraFollow = null
	var/cameralist[0]

	if (usr.stat == 2)
		usr << "You can't change your camera network because you are dead!"
		return

	for (var/obj/machinery/camera/C in world)
		if (!C.status)
			continue
		else
			if (C.network != "CREED" && C.network != "thunder" && C.network != "RD" && C.network != "toxins" && C.network != "Prison")
				cameralist[C.network] = C.network

	src.network = input(usr, "Which network would you like to view?") as null|anything in cameralist
	src << "\blue Switched to [src.network] camera network."
//End of code by Mord_Sith
*/


/*
// Debug command - Maybe should be added to admin verbs later
/mob/verb/makePAI(var/turf/t in view())
	var/obj/item/device/paicard/card = new(t)
	var/mob/living/silicon/pai/pai = new(card)
	pai.key = src.key
	card.pai = pai
*/
