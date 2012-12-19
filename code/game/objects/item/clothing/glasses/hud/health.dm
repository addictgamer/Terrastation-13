
/obj/item/clothing/glasses/hud/health
	name = "Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	proc
		RoundHealth(health)


	RoundHealth(health)
		switch(health)
			if(100 to INFINITY)
				return "health100"
			if(70 to 100)
				return "health80"
			if(50 to 70)
				return "health60"
			if(30 to 50)
				return "health40"
			if(20 to 30)
				return "health25"
			if(5 to 15)
				return "health10"
			if(1 to 5)
				return "health1"
			if(-99 to 0)
				return "health0"
			else
				return "health-100"
		return "0"


	process_hud(var/mob/M)
		if(!M)	return
		if(!M.client)	return
		var/client/C = M.client
		var/icon/tempHud = 'hud.dmi'
		for(var/mob/living/carbon/human/patient in view(M))
			var/foundVirus = 0
			for(var/datum/disease/D in patient.viruses)
				if(!D.hidden[SCANNER])
					foundVirus++
			if(patient.virus2)
				foundVirus++
			C.images += image(tempHud,patient,"hud[RoundHealth(patient.health)]")
			if(patient.stat == 2)
				C.images += image(tempHud,patient,"huddead")
			else if(patient.alien_egg_flag)
				C.images += image(tempHud,patient,"hudxeno")
			else if(foundVirus)
				C.images += image(tempHud,patient,"hudill")
			else
				C.images += image(tempHud,patient,"hudhealthy")
