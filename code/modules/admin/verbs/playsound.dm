
/client/proc/play_sound(S as sound)
	set name = "Play Global Sound"
	set category = "Sound Board"
	if(!check_rights(R_SOUNDS))	return

	var/sound/uploaded_sound = sound(S, repeat = 0, wait = 1, channel = 777)
	uploaded_sound.priority = 250

	log_admin("[key_name(src)] played sound [S]")
	message_admins("[key_name_admin(src)] played sound [S]", 1)
	for(var/mob/M in player_list)
		if(M.client.prefs.toggles & SOUND_MIDI)
			M << uploaded_sound

	feedback_add_details("admin_verb","PGS")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/play_local_sound(S as sound)
	set name = "Play Local Sound"
	set category = "Sound Board"
	if(!check_rights(R_SOUNDS))	return

	log_admin("[key_name(src)] played a local sound [S]")
	message_admins("[key_name_admin(src)] played a local sound [S]", 1)
	playsound(get_turf_loc(src.mob), S, 50, 0, 0)
	feedback_add_details("admin_verb","PLS")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


<<<<<<< HEAD
/client/proc/clownmusic()
	set name = "Clownmusic"
	set desc = "Honk"
	set category = "Sound Board"

	//for(var/mob/m in world)
		//if (m.client) //If has client.
			//m.music <<
=======
/client/proc/peel()
	set name = "Damn banana peel!"
	set category = "Sound Board"

	world << sound('sound/board/06 peel.ogg')

/client/proc/clownmusic()
	set name = "Clownmusic"
	set category = "Sound Board"

	//for(var/mob/m in world)
	//	if (m.client)	// If has client.
	//		m.music <<
>>>>>>> origin/master
	world << sound('sound/music/clown_station_redux.ogg')

/client/proc/hawly_shet()
	set name = "HAWLY SHET!"
	set category = "Sound Board"

	world << sound('sound/board/HAWLY SHET.ogg')

/client/proc/heyaheyamusic()
	set name = "Heyaheyaheya"
<<<<<<< HEAD
	set desc = "HEYYEYAAEYAAAEYAEYAA"
	set category = "Sound Board"

	world << sound('sound/music/heman-heya-full.ogg')
=======
	set category = "Sound Board"

	world << sound('sound/board/heman-heya-full.ogg')
>>>>>>> origin/master

/client/proc/fag()
	set name = "FAG!"
	set category = "Sound Board"

	world << sound('sound/board/FAG.ogg')

/client/proc/ic_in_ooc()
	set name = "IC in OOC"
	set category = "Sound Board"

	world << sound('sound/board/IC in OOC.ogg')
/*
/client/proc/ooc_in_ic()
<<<<<<< HEAD
	set name = "OOC IN IC"
=======
	set name = "OOC in IC"
>>>>>>> origin/master
	set category = "Sound Board"

	world << sound('OOC in IC.ogg')
*/

/*
/client/proc/cuban_pete()
	set name = "Cuban Pete Time"
	set category = "Fun"

	message_admins("[key_name_admin(usr)] has declared Cuban Pete Time!", 1)
	for(var/mob/M in world)
		if(M.client)
			if(M.client.midis)
				M << 'cubanpetetime.ogg'

	for(var/mob/living/carbon/human/CP in world)
		if(CP.real_name=="Cuban Pete" && CP.key!="Rosham")
			CP << "Your body can't contain the rhumba beat"
			CP.gib()


/client/proc/bananaphone()
	set name = "Banana Phone"
	set category = "Fun"

	message_admins("[key_name_admin(usr)] has activated Banana Phone!", 1)
	for(var/mob/M in world)
		if(M.client)
			if(M.client.midis)
				M << 'bananaphone.ogg'


client/proc/space_asshole()
	set name = "Space Asshole"
	set category = "Fun"

	message_admins("[key_name_admin(usr)] has played the Space Asshole Hymn.", 1)
	for(var/mob/M in world)
		if(M.client)
			if(M.client.midis)
				M << 'sound/music/space_asshole.ogg'


client/proc/honk_theme()
	set name = "Honk"
	set category = "Fun"

	message_admins("[key_name_admin(usr)] has creeped everyone out with Blackest Honks.", 1)
	for(var/mob/M in world)
		if(M.client)
			if(M.client.midis)
				M << 'honk_theme.ogg'
*/
