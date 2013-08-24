// this toggle doesn't save across rounds
/mob/verb/musictoggle()
	set name = "Music Toggle"
	if (!client)
		return //NEEDS CLIENT.
	if (src.client.be_music == 0)
		src.client.be_music = 1
		src << "\blue Music toggled on!"
		return
	src.client.be_music = 0
	src << "\blue Music toggled off!"

// This checks a var on each area and plays that var
/area/Entered(var/A)
	if (istype(A, /mob))
		if (A && src.music != "" && A:client && A:client.be_music != 0 && (A:client.music_lastplayed != src.music))
			A:client.music_lastplayed = src.music
			if (A:client.music)
				A:client.playing_lobby_music = 0
				A:client.music.status = SOUND_PAUSED | SOUND_UPDATE
				A:client << A:client.music //Stop the music.
				del A:client.music
				A:client.music = null
			A:client.music = sound(src.music, 1, wait = 0, volume = 20, channel = 1)
			A << sound(A:client.music, 1, wait = 0, volume = 20, channel = 1)
			//A << sound(src.music, repeat = 1, wait = 0, volume = 20, channel = 1)
		else if (A && src.music == "" && A:client)
			A:client.music_lastplayed = src.music
			if (A:client.music)
				A:client.playing_lobby_music = 0
				A:client.music.status = SOUND_PAUSED | SOUND_UPDATE
				A:client << A:client.music //Stop the music.
				del A:client.music
				A:client.music = null