
var/global/BSACooldown = 0
var/global/floorIsLava = 0

/proc/message_admins(var/msg)
	msg = "<span class=\"admin\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message\">[msg]</span></span>"
	log_adminwarn(msg)
	for(var/client/C in admins)
		if(R_ADMIN & C.holder.rights)
			C << msg

/proc/msg_admin_attack(var/text)	// Toggleable Attack Messages
	log_attack(text)
	var/rendered = "<span class=\"admin\"><span class=\"prefix\">ATTACK:</span> <span class=\"message\">[text]</span></span>"
	for(var/client/C in admins)
		if(R_ADMIN & C.holder.rights)
			if(C.prefs.toggles & CHAT_ATTACKLOGS)
				var/msg = rendered
				C << msg

/client/proc/hide_most_verbs()	// Allows you to keep some functionality while hiding some verbs
	set name = "Adminverbs - Hide Most"
	set category = "Admin"

	verbs.Remove(/client/proc/hide_most_verbs, admin_verbs_hideable)
	verbs += /client/proc/show_verbs

	src << "<span class='interface'>Most of your adminverbs have been hidden.</span>"
	feedback_add_details("admin_verb","HMV")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/hide_verbs()
	set name = "Adminverbs - Hide All"
	set category = "Admin"

	remove_admin_verbs()
	verbs += /client/proc/show_verbs

	src << "<span class='interface'>Almost all of your adminverbs have been hidden.</span>"
	feedback_add_details("admin_verb","TAVVH")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/show_verbs()
	set name = "Adminverbs - Show"
	set category = "Admin"

	verbs -= /client/proc/show_verbs
	add_admin_verbs()

	src << "<span class='interface'>All of your adminverbs are now visible.</span>"
	feedback_add_details("admin_verb","TAVVS")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/admin_ghost()
	set category = "Admin"
	set name = "Aghost"
	if(!holder)	return
	if(istype(mob,/mob/dead/observer))
		//re-enter
		var/mob/dead/observer/ghost = mob
		ghost.can_reenter_corpse = 1			// just in-case.
		ghost.reenter_corpse()
		feedback_add_details("admin_verb","P")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	else if(istype(mob,/mob/new_player))
		src << "<font color='red'>Error: Aghost: Can't admin-ghost whilst in the lobby. Join or Observe first.</font>"
	else
	// ghostize
		var/mob/body = mob
		body.ghostize(1)
		if(body && !body.key)
			body.key = "@[key]"	//Haaaaaaaack. But the people have spoken. If it breaks; blame adminbus

		feedback_add_details("admin_verb","O")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/invisimin()
	set name = "Invisimin"
	set category = "Admin"
	set desc = "Toggles ghost-like invisibility (Don't abuse this)"
	if(holder && mob)
		if(mob.invisibility == INVISIBILITY_OBSERVER)
			mob.invisibility = initial(mob.invisibility)
			mob << "\red <b>Invisimin off. Invisibility reset.</b>"
			mob.icon_state = "ghost"
			mob.icon = 'icons/mob/human.dmi'
			mob.update_icons()
		else
			mob.invisibility = INVISIBILITY_OBSERVER
			mob << "\blue <b>Invisimin on. You are now as invisible as a ghost.</b>"
			mob.icon_state = "ghost"
			mob.icon = 'icons/mob/mob.dmi'

/client/proc/player_panel()
	set name = "Player Panel"
	set category = "Admin"
	if(holder)
		holder.player_panel_old()
	feedback_add_details("admin_verb","PP")
	return

/client/proc/player_panel_new()
	set name = "Player Panel New"
	set category = "Admin"
	if(holder)
		holder.player_panel_new()
	feedback_add_details("admin_verb","PPN")
	return

/client/proc/check_antagonists()
	set name = "Check Antagonists"
	set category = "Admin"
	if(holder)
		holder.check_antagonists()
		log_admin("[key_name(usr)] checked antagonists.")	// for tsar~
	feedback_add_details("admin_verb","CHA")
	return

/client/proc/jobbans()
	set name = "Display Job bans"
	set category = "Admin"
	if(holder)
		if(config.ban_legacy_system)
			holder.Jobbans()
		else
			holder.DB_ban_panel()
	feedback_add_details("admin_verb","VJB")
	return

/client/proc/unban_panel()
	set name = "Unban Panel"
	set category = "Admin"
	if(holder)
		if(config.ban_legacy_system)
			holder.unbanpanel()
		else
			holder.DB_ban_panel()
	feedback_add_details("admin_verb","UBP")
	return

/client/proc/game_panel()
	set name = "Game Panel"
	set category = "Admin"
	if(holder)
		holder.Game()
	feedback_add_details("admin_verb","GP")
	return

/client/proc/secrets()
	set name = "Secrets"
	set category = "Admin"
	if (holder)
		holder.Secrets()
	feedback_add_details("admin_verb","S")
	return

/client/proc/stealth()
	set name = "Stealth Mode"
	set category = "Admin"
	if(holder)
		if(holder.fakekey)
			holder.fakekey = null
		else
			var/new_key = ckeyEx(input("Enter your desired display name.", "Fake Key", key) as text|null)
			if(!new_key)	return
			if(length(new_key) >= 26)
				new_key = copytext(new_key, 1, 26)
			holder.fakekey = new_key
		log_admin("[key_name(usr)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]")
		message_admins("[key_name_admin(usr)] has turned stealth mode [holder.fakekey ? "ON" : "OFF"]", 1)
	feedback_add_details("admin_verb","SM")

// Panels

/datum/admins/proc/show_player_panel(var/mob/M in mob_list)
	set category = "Admin"
	set name = "Show Player Panel"
	set desc = "Edit player (respawn, ban, heal, etc)"

	if(!M)
		usr << "You seem to be selecting a mob that doesn't exist anymore."
		return
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		usr << "Error: you are not an admin!"
		return

	var/body = "<html><head><title>Options for [M.key]</title></head>"
	body += "<body>Options panel for <b>[M]</b>"
	if(M.client)
		body += " played by <b>[M.client]</b> "
		body += "\[<A href='?src=\ref[src];editrights=show'>[M.client.holder ? M.client.holder.rank : "Player"]</A>\]"

	if(istype(M, /mob/new_player))
		body += " <B>Hasn't Entered Game</B> "
	else
		body += " \[<A href='?src=\ref[src];revive=\ref[M]'>Heal</A>\] "

	body += {"
		<br><br>\[
		<a href='?_src_=vars;Vars=\ref[M]'>VV</a> -
		<a href='?src=\ref[src];traitor=\ref[M]'>TP</a> -
		<a href='?src=\ref[usr];priv_msg=\ref[M]'>PM</a> -
		<a href='?src=\ref[src];subtlemessage=\ref[M]'>SM</a> -
		<a href='?src=\ref[src];adminplayerobservejump=\ref[M]'>JMP</a>\] </b><br>
		<b>Mob type</b> = [M.type]<br><br>
		<A href='?src=\ref[src];boot2=\ref[M]'>Kick</A> |
		<A href='?_src_=holder;warn=[M.ckey]'>Warn</A> |
		<A href='?src=\ref[src];newban=\ref[M]'>Ban</A> |
		<A href='?src=\ref[src];jobban2=\ref[M]'>Jobban</A> |
		<A href='?src=\ref[src];notes=show;mob=\ref[M]'>Notes</A>
	"}

	if(M.client)
		body += "| <A HREF='?src=\ref[src];sendtoprison=\ref[M]'>Prison</A> | "
		var/muted = M.client.prefs.muted
		body += {"<br><b>Mute: </b>
			\[<A href='?src=\ref[src];mute=\ref[M];mute_type=[MUTE_IC]'><font color='[(muted & MUTE_IC)?"red":"blue"]'>IC</font></a> |
			<A href='?src=\ref[src];mute=\ref[M];mute_type=[MUTE_OOC]'><font color='[(muted & MUTE_OOC)?"red":"blue"]'>OOC</font></a> |
			<A href='?src=\ref[src];mute=\ref[M];mute_type=[MUTE_PRAY]'><font color='[(muted & MUTE_PRAY)?"red":"blue"]'>PRAY</font></a> |
			<A href='?src=\ref[src];mute=\ref[M];mute_type=[MUTE_ADMINHELP]'><font color='[(muted & MUTE_ADMINHELP)?"red":"blue"]'>ADMINHELP</font></a> |
			<A href='?src=\ref[src];mute=\ref[M];mute_type=[MUTE_DEADCHAT]'><font color='[(muted & MUTE_DEADCHAT)?"red":"blue"]'>DEADCHAT</font></a>\]
			(<A href='?src=\ref[src];mute=\ref[M];mute_type=[MUTE_ALL]'><font color='[(muted & MUTE_ALL)?"red":"blue"]'>toggle all</font></a>)
		"}

	body += {"<br><br>
		<A href='?src=\ref[src];jumpto=\ref[M]'><b>Jump to</b></A> |
		<A href='?src=\ref[src];getmob=\ref[M]'>Get</A> |
		<A href='?src=\ref[src];sendmob=\ref[M]'>Send To</A>
		<br><br>
		<A href='?src=\ref[src];traitor=\ref[M]'>Traitor panel</A> |
		<A href='?src=\ref[src];narrateto=\ref[M]'>Narrate to</A> |
		<A href='?src=\ref[src];subtlemessage=\ref[M]'>Subtle message</A>
	"}

	if (M.client)
		if(!istype(M, /mob/new_player))
			body += "<br><br>"
			body += "<b>Transformation:</b>"
			body += "<br>"

		// Monkey
			if(ismonkey(M))
				body += "<B>Monkeyized</B> | "
			else
				body += "<A href='?src=\ref[src];monkeyone=\ref[M]'>Monkeyize</A> | "

		// Corgi
			if(iscorgi(M))
				body += "<B>Corgized</B> | "
			else
				body += "<A href='?src=\ref[src];corgione=\ref[M]'>Corgize</A> | "

		// AI/Cyborg
			if(isAI(M))
				body += "<B>Is an AI</B> "
			else if(ishuman(M))
				body += {"<A href='?src=\ref[src];makeai=\ref[M]'>Make AI</A> |
					<A href='?src=\ref[src];makerobot=\ref[M]'>Make Robot</A> |
					<A href='?src=\ref[src];makealien=\ref[M]'>Make Alien</A> |
					<A href='?src=\ref[src];makeslime=\ref[M]'>Make slime</A>
				"}

		// Simple Animals
			if(isanimal(M))
				body += "<A href='?src=\ref[src];makeanimal=\ref[M]'>Re-Animalize</A> | "
			else
				body += "<A href='?src=\ref[src];makeanimal=\ref[M]'>Animalize</A> | "

			body += {"<br><br>
				<b>Rudimentary transformation:</b><font size=2><br>These transformations only create a new mob type and copy stuff over. They do not take into account MMIs and similar mob-specific things. The buttons in 'Transformations' are preferred, when possible.</font><br>
				<A href='?src=\ref[src];simplemake=observer;mob=\ref[M]'>Observer</A> |
				\[ Alien: <A href='?src=\ref[src];simplemake=drone;mob=\ref[M]'>Drone</A>,
				<A href='?src=\ref[src];simplemake=hunter;mob=\ref[M]'>Hunter</A>,
				<A href='?src=\ref[src];simplemake=queen;mob=\ref[M]'>Queen</A>,
				<A href='?src=\ref[src];simplemake=sentinel;mob=\ref[M]'>Sentinel</A>,
				<A href='?src=\ref[src];simplemake=larva;mob=\ref[M]'>Larva</A> \]
				<A href='?src=\ref[src];simplemake=human;mob=\ref[M]'>Human</A>
				\[ slime: <A href='?src=\ref[src];simplemake=slime;mob=\ref[M]'>Baby</A>,
				<A href='?src=\ref[src];simplemake=adultslime;mob=\ref[M]'>Adult</A> \]
				<A href='?src=\ref[src];simplemake=monkey;mob=\ref[M]'>Monkey</A> |
				<A href='?src=\ref[src];simplemake=robot;mob=\ref[M]'>Cyborg</A> |
				<A href='?src=\ref[src];simplemake=cat;mob=\ref[M]'>Cat</A> |
				<A href='?src=\ref[src];simplemake=runtime;mob=\ref[M]'>Runtime</A> |
				<A href='?src=\ref[src];simplemake=corgi;mob=\ref[M]'>Corgi</A> |
				<A href='?src=\ref[src];simplemake=ian;mob=\ref[M]'>Ian</A> |
				<A href='?src=\ref[src];simplemake=crab;mob=\ref[M]'>Crab</A> |
				<A href='?src=\ref[src];simplemake=coffee;mob=\ref[M]'>Coffee</A> |
				\[ Construct: <A href='?src=\ref[src];simplemake=constructarmoured;mob=\ref[M]'>Armoured</A> ,
				<A href='?src=\ref[src];simplemake=constructbuilder;mob=\ref[M]'>Builder</A> ,
				<A href='?src=\ref[src];simplemake=constructwraith;mob=\ref[M]'>Wraith</A> \]
				<A href='?src=\ref[src];simplemake=shade;mob=\ref[M]'>Shade</A>
				<br>
			"}

	if (M.client)
		body += {"<br><br>
			<b>Other actions:</b>
			<br>
			<A href='?src=\ref[src];forcespeech=\ref[M]'>Forcesay</A> |
			<A href='?src=\ref[src];tdome1=\ref[M]'>Thunderdome 1</A> |
			<A href='?src=\ref[src];tdome2=\ref[M]'>Thunderdome 2</A> |
			<A href='?src=\ref[src];tdomeadmin=\ref[M]'>Thunderdome Admin</A> |
			<A href='?src=\ref[src];tdomeobserve=\ref[M]'>Thunderdome Observer</A> |
		"}

	body += {"<br>
		</body></html>
	"}

	usr << browse(body, "window=adminplayeropts;size=550x515")
	feedback_add_details("admin_verb","SPP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/player_info/var/author // admin who authored the information
/datum/player_info/var/rank //rank of admin who made the notes
/datum/player_info/var/content // text content of the information
/datum/player_info/var/timestamp // Because this is bloody annoying

#define PLAYER_NOTES_ENTRIES_PER_PAGE 50
/datum/admins/proc/PlayerNotes()
	set category = "Admin"
	set name = "Player Notes"
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		usr << "Error: you are not an admin!"
		return
	PlayerNotesPage(1)

/datum/admins/proc/PlayerNotesPage(page)
	var/dat = "<B>Player notes</B><HR>"
	var/savefile/S=new("data/player_notes.sav")
	var/list/note_keys
	S >> note_keys
	if(!note_keys)
		dat += "No notes found."
	else
		dat += "<table>"
		note_keys = sortList(note_keys)

		// Display the notes on the current page
		var/number_pages = note_keys.len / PLAYER_NOTES_ENTRIES_PER_PAGE
		// Emulate ceil(why does BYOND not have ceil)
		if(number_pages != round(number_pages))
			number_pages = round(number_pages) + 1
		var/page_index = page - 1
		if(page_index < 0 || page_index >= number_pages)
			return

		var/lower_bound = page_index * PLAYER_NOTES_ENTRIES_PER_PAGE + 1
		var/upper_bound = (page_index + 1) * PLAYER_NOTES_ENTRIES_PER_PAGE
		upper_bound = min(upper_bound, note_keys.len)
		for(var/index = lower_bound, index <= upper_bound, index++)
			var/t = note_keys[index]
			dat += "<tr><td><a href='?src=\ref[src];notes=show;ckey=[t]'>[t]</a></td></tr>"

		dat += "</table><br>"

		// Display a footer to select different pages
		for(var/index = 1, index <= number_pages, index++)
			if(index == page)
				dat += "<b>"
			dat += "<a href='?src=\ref[src];notes=list;index=[index]'>[index]</a> "
			if(index == page)
				dat += "</b>"

	usr << browse(dat, "window=player_notes;size=400x400")


/datum/admins/proc/player_has_info(var/key as text)
	var/savefile/info = new("data/player_saves/[copytext(key, 1, 2)]/[key]/info.sav")
	var/list/infos
	info >> infos
	if(!infos || !infos.len) return 0
	else return 1


/datum/admins/proc/show_player_info(var/key as text)
	set category = "Admin"
	set name = "Show Player Info"
	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		usr << "Error: you are not an admin!"
		return
	var/dat = "<html><head><title>Info on [key]</title></head>"
	dat += "<body>"

	var/savefile/info = new("data/player_saves/[copytext(key, 1, 2)]/[key]/info.sav")
	var/list/infos
	info >> infos
	if(!infos)
		dat += "No information found on the given key.<br>"
	else
		var/update_file = 0
		var/i = 0
		for(var/datum/player_info/I in infos)
			i += 1
			if(!I.timestamp)
				I.timestamp = "Pre-4/3/2012"
				update_file = 1
			if(!I.rank)
				I.rank = "N/A"
				update_file = 1
			dat += "<font color=#008800>[I.content]</font> <i>by [I.author] ([I.rank])</i> on <i><font color=blue>[I.timestamp]</i></font> "
			if(I.author == usr.key)
				dat += "<A href='?src=\ref[src];remove_player_info=[key];remove_index=[i]'>Remove</A>"
			dat += "<br><br>"
		if(update_file) info << infos

	dat += "<br>"
	dat += "<A href='?src=\ref[src];add_player_info=[key]'>Add Comment</A><br>"

	dat += "</body></html>"
	usr << browse(dat, "window=adminplayerinfo;size=480x480")


/datum/admins/proc/Jobbans()
	if(!check_rights(R_BAN))	return

	var/dat = "<B>Job Bans!</B><HR><table>"
	for(var/t in jobban_keylist)
		var/r = t
		if( findtext(r,"##") )
			r = copytext( r, 1, findtext(r,"##") )//removes the description
		dat += text("<tr><td>[t] (<A href='?src=\ref[src];removejobban=[r]'>unban</A>)</td></tr>")
	dat += "</table>"
	usr << browse(dat, "window=ban;size=400x400")

/datum/admins/proc/Game()
	if(!check_rights(0))	return

	var/dat = {"
		<center><B>Game Panel</B></center><hr>\n
		<A href='?src=\ref[src];c_mode=1'>Change Game Mode</A><br>
		"}
	if(master_mode == "secret")
		dat += "<A href='?src=\ref[src];f_secret=1'>(Force Secret Mode)</A><br>"

	dat += {"
		<BR>
		<A href='?src=\ref[src];create_object=1'>Create Object</A><br>
		<A href='?src=\ref[src];quick_create_object=1'>Quick Create Object</A><br>
		<A href='?src=\ref[src];create_turf=1'>Create Turf</A><br>
		<A href='?src=\ref[src];create_mob=1'>Create Mob</A><br>
		<br><A href='?src=\ref[src];vsc=airflow'>Edit Airflow Settings</A><br>
		<A href='?src=\ref[src];vsc=plasma'>Edit Plasma Settings</A><br>
		<A href='?src=\ref[src];vsc=default'>Choose a default ZAS setting</A><br>
		"}

	usr << browse(dat, "window=admin2;size=210x280")
	return

/datum/admins/proc/Secrets()
	if(!check_rights(0))	return

	var/dat = "<B>The first rule of adminbuse is: you don't talk about the adminbuse.</B><HR>"

	if(check_rights(R_ADMIN,0))
		dat += {"
			<B>Admin Secrets</B><BR>
			<BR>
			<A href='?src=\ref[src];secretsadmin=clear_bombs'>Remove all bombs currently in existence</A><BR>
			<A href='?src=\ref[src];secretsadmin=list_bombers'>Bombing List</A><BR>
			<A href='?src=\ref[src];secretsadmin=check_antagonist'>Show current traitors and objectives</A><BR>
			<A href='?src=\ref[src];secretsadmin=list_signalers'>Show last [length(lastsignalers)] signalers</A><BR>
			<A href='?src=\ref[src];secretsadmin=list_lawchanges'>Show last [length(lawchanges)] law changes</A><BR>
			<A href='?src=\ref[src];secretsadmin=showailaws'>Show AI Laws</A><BR>
			<A href='?src=\ref[src];secretsadmin=showgm'>Show Game Mode</A><BR>
			<A href='?src=\ref[src];secretsadmin=manifest'>Show Crew Manifest</A><BR>
			<A href='?src=\ref[src];secretsadmin=DNA'>List DNA (Blood)</A><BR>
			<A href='?src=\ref[src];secretsadmin=fingerprints'>List Fingerprints</A><BR><BR>
			<BR>
			"}

	if(check_rights(R_FUN,0))
		dat += {"
			<B>'Random' Events</B><BR>
			<BR>
			<A href='?src=\ref[src];secretsfun=gravity'>Toggle station artificial gravity</A><BR>
			<A href='?src=\ref[src];secretsfun=wave'>Spawn a wave of meteors (aka lagocolyptic shower)</A><BR>
			<A href='?src=\ref[src];secretsfun=gravanomalies'>Spawn a gravitational anomaly (aka lagitational anomolag)</A><BR>
			<A href='?src=\ref[src];secretsfun=timeanomalies'>Spawn wormholes</A><BR>
			<A href='?src=\ref[src];secretsfun=goblob'>Spawn blob</A><BR>
			<A href='?src=\ref[src];secretsfun=aliens'>Trigger an Alien infestation</A><BR>
			<A href='?src=\ref[src];secretsfun=alien_silent'>Spawn an Alien silently</A><BR>
			<A href='?src=\ref[src];secretsfun=spiders'>Trigger a Spider infestation</A><BR>
			<A href='?src=\ref[src];secretsfun=spaceninja'>Send in a space ninja</A><BR>
			<A href='?src=\ref[src];secretsfun=striketeam'>Send in a strike team</A><BR>
			<A href='?src=\ref[src];secretsfun=carp'>Trigger an Carp migration</A><BR>
			<A href='?src=\ref[src];secretsfun=radiation'>Irradiate the station</A><BR>
			<A href='?src=\ref[src];secretsfun=prison_break'>Trigger a Prison Break</A><BR>
			<A href='?src=\ref[src];secretsfun=virus'>Trigger a Virus Outbreak</A><BR>
			<A href='?src=\ref[src];secretsfun=immovable'>Spawn an Immovable Rod</A><BR>
			<A href='?src=\ref[src];secretsfun=lightsout'>Toggle a "lights out" event</A><BR>
			<A href='?src=\ref[src];secretsfun=ionstorm'>Spawn an Ion Storm</A><BR>
			<A href='?src=\ref[src];secretsfun=spacevines'>Spawn Space-Vines</A><BR>
			<A href='?src=\ref[src];secretsfun=comms_blackout'>Trigger a communication blackout</A><BR>
			<BR>
			<B>Fun Secrets</B><BR>
			<BR>
			<A href='?src=\ref[src];secretsfun=sec_clothes'>Remove 'internal' clothing</A><BR>
			<A href='?src=\ref[src];secretsfun=sec_all_clothes'>Remove ALL clothing</A><BR>
			<A href='?src=\ref[src];secretsfun=monkey'>Turn all humans into monkeys</A><BR>
			<A href='?src=\ref[src];secretsfun=sec_classic1'>Remove firesuits, grilles, and pods</A><BR>
			<A href='?src=\ref[src];secretsfun=power'>Make all areas powered</A><BR>
			<A href='?src=\ref[src];secretsfun=unpower'>Make all areas unpowered</A><BR>
			<A href='?src=\ref[src];secretsfun=quickpower'>Power all SMES</A><BR>
			<A href='?src=\ref[src];secretsfun=toggleprisonstatus'>Toggle Prison Shuttle Status(Use with S/R)</A><BR>
			<A href='?src=\ref[src];secretsfun=activateprison'>Send Prison Shuttle</A><BR>
			<A href='?src=\ref[src];secretsfun=deactivateprison'>Return Prison Shuttle</A><BR>
			<A href='?src=\ref[src];secretsfun=prisonwarp'>Warp all Players to Prison</A><BR>
			<A href='?src=\ref[src];secretsfun=tripleAI'>Triple AI mode (needs to be used in the lobby)</A><BR>
			<A href='?src=\ref[src];secretsfun=traitor_all'>Everyone is the traitor</A><BR>
			<A href='?src=\ref[src];secretsfun=onlyone'>There can only be one!</A><BR>
			<A href='?src=\ref[src];secretsfun=flicklights'>Ghost Mode</A><BR>
			<A href='?src=\ref[src];secretsfun=retardify'>Make all players retarded</A><BR>
			<A href='?src=\ref[src];secretsfun=fakeguns'>Make all items look like guns</A><BR>
			<A href='?src=\ref[src];secretsfun=schoolgirl'>Japanese Animes Mode</A><BR>
			<A href='?src=\ref[src];secretsfun=eagles'>Egalitarian Station Mode</A><BR>
			<A href='?src=\ref[src];secretsfun=moveadminshuttle'>Move Administration Shuttle</A><BR>
			<A href='?src=\ref[src];secretsfun=moveferry'>Move Ferry</A><BR>
			<A href='?src=\ref[src];secretsfun=movealienship'>Move Alien Dinghy</A><BR>
			<A href='?src=\ref[src];secretsfun=moveminingshuttle'>Move Mining Shuttle</A><BR>
			<A href='?src=\ref[src];secretsfun=blackout'>Break all lights</A><BR>
			<A href='?src=\ref[src];secretsfun=whiteout'>Fix all lights</A><BR>
			<A href='?src=\ref[src];secretsfun=friendai'>Best Friend AI</A><BR>
			<A href='?src=\ref[src];secretsfun=floorlava'>The floor is lava! (DANGEROUS: extremely lame)</A><BR>
			"}

	if(check_rights(R_SERVER,0))
		dat += "<A href='?src=\ref[src];secretsfun=togglebombcap'>Toggle bomb cap</A><BR>"

	dat += "<BR>"

	if(check_rights(R_DEBUG,0))
		dat += {"
			<B>Security Level Elevated</B><BR>
			<BR>
			<A href='?src=\ref[src];secretscoder=maint_access_engiebrig'>Change all maintenance doors to engie/brig access only</A><BR>
			<A href='?src=\ref[src];secretscoder=maint_access_brig'>Change all maintenance doors to brig access only</A><BR>
			<A href='?src=\ref[src];secretscoder=infinite_sec'>Remove cap on security officers</A><BR>
			<BR>
			<B>Coder Secrets</B><BR>
			<BR>
			<A href='?src=\ref[src];secretsadmin=list_job_debug'>Show Job Debug</A><BR>
			<A href='?src=\ref[src];secretscoder=spawn_objects'>Admin Log</A><BR>
			<BR>
			"}

	usr << browse(dat, "window=secrets")
	return

/datum/admins/proc/unprison(var/mob/M in mob_list)
	set category = "Admin"
	set name = "Unprison"
	if (M.z == 2)
		if (config.allow_admin_jump)
			M.loc = pick(latejoin)
			message_admins("[key_name_admin(usr)] has unprisoned [key_name_admin(M)]", 1)
			log_admin("[key_name(usr)] has unprisoned [key_name(M)]")
		else
			alert("Admin jumping disabled")
	else
		alert("[M.name] is not prisoned.")
	feedback_add_details("admin_verb","UP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!



#define MAX_WARNS 3
#define AUTOBANTIME 10

/client/proc/warn(warned_ckey)
	if(!check_rights(R_ADMIN))	return

	if(!warned_ckey || !istext(warned_ckey))	return
	if(warned_ckey in admin_datums)
		usr << "<font color='red'>Error: warn(): You can't warn admins.</font>"
		return

	var/datum/preferences/D
	var/client/C = directory[warned_ckey]
	if(C)	D = C.prefs
	else	D = preferences_datums[warned_ckey]

	if(!D)
		src << "<font color='red'>Error: warn(): No such ckey found.</font>"
		return

	if(++D.warns >= MAX_WARNS)					// uh ohhhh...you'reee iiiiin trouuuubble O:)
		ban_unban_log_save("[ckey] warned [warned_ckey], resulting in a [AUTOBANTIME] minute autoban.")
		if(C)
			message_admins("[key_name_admin(src)] has warned [key_name_admin(C)] resulting in a [AUTOBANTIME] minute ban.")
			C << "<font color='red'><BIG><B>You have been autobanned due to a warning by [ckey].</B></BIG><br>This is a temporary ban, it will be removed in [AUTOBANTIME] minutes."
			del(C)
		else
			message_admins("[key_name_admin(src)] has warned [warned_ckey] resulting in a [AUTOBANTIME] minute ban.")
		AddBan(warned_ckey, D.last_id, "Autobanning due to too many formal warnings", ckey, 1, AUTOBANTIME)
		feedback_inc("ban_warn",1)
	else
		if(C)
			C << "<font color='red'><BIG><B>You have been formally warned by an administrator.</B></BIG><br>Further warnings will result in an autoban.</font>"
			message_admins("[key_name_admin(src)] has warned [key_name_admin(C)]. They have [MAX_WARNS-D.warns] strikes remaining.")
		else
			message_admins("[key_name_admin(src)] has warned [warned_ckey] (DC). They have [MAX_WARNS-D.warns] strikes remaining.")

	feedback_add_details("admin_verb","WARN") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

#undef MAX_WARNS
#undef AUTOBANTIME

/client/proc/deadmin_self()
	set name = "De-admin self"
	set category = "Admin"

	if(holder)
		if(alert("Confirm self-deadmin for the round? You can't re-admin yourself without someont promoting you.",,"Yes","No") == "Yes")
			log_admin("[src] deadmined themself.")
			message_admins("[src] deadmined themself.", 1)
			deadmin()
			src << "<span class='interface'>You are now a normal player.</span>"
	feedback_add_details("admin_verb","DAS") // If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/deadmin()
	admin_datums -= ckey
	if(holder)
		holder.disassociate()
		del(holder)
	return 1

/client/proc/check_ai_laws()
	set name = "Check AI Laws"
	set category = "Admin"
	if(holder)
		src.holder.output_ai_laws()


/client/proc/mod_panel()
	set name = "Moderator Panel"
	set category = "Admin"
/*
	if(holder)
		holder.mod_panel()
*/
	//feedback_add_details("admin_verb","MP")	// If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/client/proc/playernotes()
	set name = "Show Player Info"
	set category = "Admin"
	if(holder)
		holder.PlayerNotes()
	return

/client/proc/free_slot()
	set name = "Free Job Slot"
	set category = "Admin"
	if(holder)
		var/list/jobs = list()
		for (var/datum/job/J in job_master.occupations)
			if (J.current_positions >= J.total_positions && J.total_positions != -1)
				jobs += J.title
		if (!jobs.len)
			usr << "There are no fully staffed jobs."
			return
		var/job = input("Please select job slot to free", "Free job slot")  as null|anything in jobs
		if (job)
			job_master.FreeRole(job)
	return


// ADMIN HELPER PROCS

/proc/is_special_character(mob/M as mob) // returns 1 for specail characters and 2 for heroes of gamemode
	if(!ticker || !ticker.mode)
		return 0
	if (!istype(M))
		return 0
	if((M.mind in ticker.mode.head_revolutionaries) || (M.mind in ticker.mode.revolutionaries))
		if (ticker.mode.config_tag == "revolution")
			return 2
		return 1
	if(M.mind in ticker.mode.cult)
		if (ticker.mode.config_tag == "cult")
			return 2
		return 1
	if(M.mind in ticker.mode.malf_ai)
		if (ticker.mode.config_tag == "malfunction")
			return 2
		return 1
	if(M.mind in ticker.mode.syndicates)
		if (ticker.mode.config_tag == "nuclear")
			return 2
		return 1
	if(M.mind in ticker.mode.wizards)
		if (ticker.mode.config_tag == "wizard")
			return 2
		return 1
	if(M.mind in ticker.mode.changelings)
		if (ticker.mode.config_tag == "changeling")
			return 2
		return 1

	for(var/datum/disease/D in M.viruses)
		if(istype(D, /datum/disease/jungle_fever))
			if (ticker.mode.config_tag == "monkey")
				return 2
			return 1
	if(isrobot(M))
		var/mob/living/silicon/robot/R = M
		if(R.emagged)
			return 1
	if(M.mind&&M.mind.special_role)	// If they have a mind and special role, they are some type of traitor or antagonist.
		return 1

	return 0

/*
/datum/admins/proc/get_sab_desc(var/target)
	switch(target)
		if(1)
			return "Destroy at least 70% of the plasma canisters on the station"
		if(2)
			return "Destroy the AI"
		if(3)
			var/count = 0
			for(var/mob/living/carbon/monkey/Monkey in world)
				if(Monkey.z == 1)
					count++
			return "Kill all [count] of the monkeys on the station"
		if(4)
			return "Cut power to at least 80% of the station"
		else
			return "Error: Invalid sabotage target: [target]"
*/

/datum/admins/proc/show_traitor_panel(var/mob/M in mob_list)
	set category = "Admin"
	set desc = "Edit mobs's memory and role"
	set name = "Show Traitor Panel"

	if(!istype(M))
		usr << "This can only be used on instances of type /mob"
		return
	if(!M.mind)
		usr << "This mob has no mind!"
		return

	M.mind.edit_memory()
	feedback_add_details("admin_verb","STP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/unjobban_panel()
	set name = "Unjobban Panel"
	set category = "Admin"
	if (src.holder)
		src.holder.unjobbanpanel()
	feedback_add_details("admin_verb","UJBP") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

/datum/admins/proc/output_ai_laws()
	var/ai_number = 0
	for(var/mob/living/silicon/S in mob_list)
		ai_number++
		if(isAI(S))
			usr << "<b>AI [key_name(S, usr)]'s laws:</b>"
		else if(isrobot(S))
			var/mob/living/silicon/robot/R = S
			usr << "<b>CYBORG [key_name(S, usr)] [R.connected_ai?"(Slaved to: [R.connected_ai])":"(Independant)"]: laws:</b>"
		else if (ispAI(S))
			usr << "<b>pAI [key_name(S, usr)]'s laws:</b>"
		else
			usr << "<b>SOMETHING SILICON [key_name(S, usr)]'s laws:</b>"

		if (S.laws == null)
			usr << "[key_name(S, usr)]'s laws are null?? Contact a coder."
		else
			S.laws.show_laws(usr)
	if(!ai_number)
		usr << "<b>No AIs located</b>" //Just so you know the thing is actually working and not just ignoring you.

/datum/admins/proc/show_skills(var/mob/living/carbon/human/M as mob in world)
	set category = "Admin"
	set name = "Show Skills"

	if (!istype(src,/datum/admins))
		src = usr.client.holder
	if (!istype(src,/datum/admins))
		usr << "Error: you are not an admin!"
		return

	show_skill_window(usr, M)

	return

/client/proc/update_mob_sprite(mob/living/carbon/human/H as mob)
	set category = "Admin"
	set name = "Update Mob Sprite"
	set desc = "Should fix any mob sprite update errors."

	if (!holder)
		src << "Only administrators may use this command."
		return

	if(istype(H))
		H.regenerate_icons()


// TODO:

// Administration Shuttle

var/admin_shuttle_location = 0 // 0 = centcom 13, 1 = station

proc/move_admin_shuttle()
	var/area/fromArea
	var/area/toArea
	if (admin_shuttle_location == 1)
		fromArea = locate(/area/shuttle/administration/station)
		toArea = locate(/area/shuttle/administration/centcom)
	else
		fromArea = locate(/area/shuttle/administration/centcom)
		toArea = locate(/area/shuttle/administration/station)
	fromArea.move_contents_to(toArea)
	if (admin_shuttle_location)
		admin_shuttle_location = 0
	else
		admin_shuttle_location = 1
	return

//Centcom Ferry

var/ferry_location = 0 // 0 = centcom , 1 = station

proc/move_ferry()
	var/area/fromArea
	var/area/toArea
	if (ferry_location == 1)
		fromArea = locate(/area/shuttle/transport1/station)
		toArea = locate(/area/shuttle/transport1/centcom)
	else
		fromArea = locate(/area/shuttle/transport1/centcom)
		toArea = locate(/area/shuttle/transport1/station)
	fromArea.move_contents_to(toArea)
	if (ferry_location)
		ferry_location = 0
	else
		ferry_location = 1
	return

//Alien ship

var/alien_ship_location = 1 // 0 = base , 1 = mine

proc/move_alien_ship()
	var/area/fromArea
	var/area/toArea
	if (alien_ship_location == 1)
		fromArea = locate(/area/shuttle/alien/mine)
		toArea = locate(/area/shuttle/alien/base)
	else
		fromArea = locate(/area/shuttle/alien/base)
		toArea = locate(/area/shuttle/alien/mine)
	fromArea.move_contents_to(toArea)
	if (alien_ship_location)
		alien_ship_location = 0
	else
		alien_ship_location = 1
	return
