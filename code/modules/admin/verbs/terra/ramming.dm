//use this on greytide or players who just really piss you off. A salvage captain might be able to retrieve anything they stole.
//assuming the LZ's Poot salvage ruin got loaded, of course.

/client/proc/RamUpAss()
	set category = "Admin"
	set name = "Ram"
	set desc = "Key to Ram"

	if(!check_rights(R_ADMIN))
		return

	var/list/keys = list()
	for(var/mob/M in player_list)
		keys += M.client
	var/selection = input("Who just pissed you off?", "Admin Ramming", null, null) as null|anything in sortKey(keys)
	if(!selection)
		return
	var/mob/M = selection:mob

	if(!M)
		return
	log_admin("[key_name(usr)] rammed [key_name(M)] up LZ's ass!")
	message_admins("[key_name_admin(usr)] rammed [key_name(M)] up LZ's ass!", 1)
	var/area/A = /area/timewarp/ship/rectum/tacticalanalinsertion
	if(M)
		playsound(M.loc, 'sound/effects/fart2rev.ogg', 400, 0)//wish I could make this louder natively. Looks like I just have to micboot it or some shit.
		admin_forcemove(M, pick(get_area_turfs(A)))
//		admin_forcemove(usr, M.loc) //this was in getKey. Is this even necessary?
		feedback_add_details("admin_verb","RUA") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc! (I totally did btw.  --LZ)
		to_chat(M, "<span class='danger'><b><font size=4>You suddenly get rammed up LZ's ass!!</font></b></span>")
		playsound(M.loc, 'sound/effects/fart2revBOOST.ogg', 400, 0)//Again, I wish I could make this louder natively.
		shake_camera(M, 4, 4)
		M.emote("scream")
		var/list/polyps = list()
		for(var/obj/effect/landmark/L in landmarks_list)
			if(L.name != "polypspawn")
				continue
			polyps.Add(L.loc)
		polyps = shuffle(polyps)
		var/polypamt = rand(3,6)
		while(polypamt > 1)
			new /mob/living/simple_animal/hostile/creature/polyp(polyps[polypamt])
			polypamt--

