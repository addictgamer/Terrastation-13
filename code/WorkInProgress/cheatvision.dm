
/obj/item/clothing/glasses/hud/cheathud
	name = "Cheat Vision"
	desc = "You cheater! Grants complete vision to everything."
	icon_state = "cheathud"
	item_state = "cheathud"
	vision_flags = SEE_TURFS | SEE_OBJS | SEE_MOBS
	invisa_view = 2
	darkness_view = 3

	proc
		RoundHealth(health)
	//Yeah, I stole this from the health HUD. What you going to do about it? -Tauka

	RoundHealth(health)
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

	process_hud(var/mob/M)
		if (!M)	return
		if (!M.client)	return
		var/client/C = M.client
		var/icon/tempHud = 'hud.dmi'
		for(var/mob/living/carbon/human/player in view(M))
			var/foundVirus = 0
			for(var/datum/disease/D in player.viruses)
				if (!D.hidden[SCANNER])
					foundVirus++
			if (player.virus2)
				foundVirus++
			C.images += image(tempHud,player,"hud[RoundHealth(player.health)]")
			if (player.stat == 2)
				C.images += image(tempHud,player,"huddead")
			else if (player.alien_egg_flag)
				C.images += image(tempHud,player,"hudxeno")
			else if (foundVirus)
				C.images += image(tempHud,player,"hudill")
			else
				C.images += image(tempHud,player,"hudhealthy")
		//Mashed security HUD here
			if (player.wear_id)
				C.images += image(tempHud,player,"hud[ckey(player:wear_id:GetJobName())]")
				var/playername = "wot"
				if (istype(player.wear_id,/obj/item/weapon/card/id))
					playername = player.wear_id:registered
				else if (istype(player.wear_id,/obj/item/device/pda))
					var/obj/item/device/pda/tempPda = player.wear_id
					playername = tempPda.owner
				for (var/datum/data/record/E in data_core.general)
					if (E.fields["name"] == playername)
						for (var/datum/data/record/R in data_core.security)
							if ((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "*Arrest*"))
								C.images += image(tempHud,player,"hudwanted")
								break
							else if ((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "Incarcerated"))
								C.images += image(tempHud,player,"hudprisoner")
								break
					else
						C.images += image(tempHud,player,"hudunknown")
					for(var/obj/item/weapon/implant/I in player)
						if (I.implanted)
							if (istype(I,/obj/item/weapon/implant/tracking))
								C.images += image(tempHud,player,"hud_imp_tracking")
							if (istype(I,/obj/item/weapon/implant/loyalty))
								C.images += image(tempHud,player,"hud_imp_loyal")
/*			var/foundVirus = 0
			for(var/datum/disease/D in person.viruses)
				if (!D.hidden[SCANNER])
					foundVirus++
			if (person.virus2)
				foundVirus++
			C.images += image(tempHud,person,"hud[RoundHealth(person.health)]")
			if (person.stat == 2)
				C.images += image(tempHud,person,"huddead")
			else if (person.alien_egg_flag)
				C.images += image(tempHud,person,"hudxeno")
			else if (foundVirus)
				C.images += image(tempHud,person,"hudill")
			else
				C.images += image(tempHud,person,"hudhealthy")
*/

/*
	//From the Warthog mech. Want to try adding it in -Tauka
		zoom()
			set category = "Exosuit Interface"
			set name = "Zoom"
			set src in view(0)
			if (usr!=src.occupant && usr != src.remote_controlled)
				return
			if (src.occupant)
				if (src.occupant.client)
					src.zoom = !src.zoom
					src.log_message("Toggled zoom mode.")
					src.occupant_message("<font color='[src.zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>")
					if (zoom)
						src.occupant.client.view = 12
						src.occupant << sound('imag_enh.ogg',volume=50)
					else
						src.occupant.client.view = world.view//world.view - default mob view size
			else
				if (src.remote_controlled.client)
					src.zoom = !src.zoom
					src.log_message("Toggled zoom mode.")
					src.occupant_message("<font color='[src.zoom?"blue":"red"]'>Zoom mode [zoom?"en":"dis"]abled.</font>")
					if (zoom)
						src.remote_controlled.client.view = 12
						src.remote_controlled << sound('imag_enh.ogg',volume=50)
					else
						src.remote_controlled.client.view = world.view//world.view - default mob view size
			return
*/
