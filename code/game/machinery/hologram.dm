/*
Revised. Original based on space ninja hologram code. Which is also mine. /N
How it works:
AI clicks on holopad in camera view. View centers on holopad.
AI clicks again on the holopad to display a hologram. Hologram stays as long as AI is looking at the pad and it (the hologram) is in range of the pad.
AI can use the directional keys to move the hologram around, provided the above conditions are met and the AI in question is the holopad's master.
Only one AI may project from a holopad at any given time.
AI may cancel the hologram at any time by clicking on the holopad once more.

Possible to do for anyone motivated enough:
	Give an AI variable for different hologram icons.
	Itegrate EMP effects to disable the unit.
*/
/obj/machinery/hologram/holopad/attack_ai(mob/living/silicon/ai/user)
	if (!istype(user))
		return
	/*There are pretty much only three ways to interact here.
	I don't need to check for client since they're clicking on an object.
	This may change in the future but for now will suffice.*/
	if(user.client.eye!=src)//Set client eye on the object if it's not already.
		user.current = src
		user.reset_view(src)
	else if(!hologram)//If there is no hologram, possibly make one.
		activate_holo(user)
	else if(master==user)//If there is a hologram, remove it. But only if the user is the master. Otherwise do nothing.
		clear_holo()
	return

/obj/machinery/hologram/holopad/proc/activate_holo(mob/living/silicon/ai/user)
	if(!(stat & NOPOWER)&&user.client.eye==src)//If the projector has power and client eye is on it.
		if(!hologram)//If there is not already a hologram.
			create_holo(user)//Create one.
			for(var/mob/M in viewers())
				M.show_message("A holographic image of [user] flicks to life right before your eyes!",1)
		else
			user << "\red ERROR: \black Image feed in progress."
	else
		user << "\red ERROR: \black Unable to project hologram."
	return

/*This is the proc for special two-way communication between AI and holopad/people talking near holopad.
For the other part of the code, check silicon say.dm. Particularly robot talk.*/
/obj/machinery/hologram/holopad/hear_talk(mob/M, text)
	if(M&&hologram&&master)//Master is mostly a safety in case lag hits or something.
		if(!master.say_understands(M))//The AI will be able to understand most mobs talking through the holopad.
			text = stars(text)
		var/name_used = M.name
		if(istype(M.wear_mask, /obj/item/clothing/mask/gas/voice)&&M.wear_mask:vchange)//Can't forget the ninjas.
			name_used = M.wear_mask:voice
		//This communication is imperfect because the holopad "filters" voices and is only designed to connect to the master only.
		var/rendered = "<i><span class='game say'>Holopad received, <span class='name'>[name_used]</span> <span class='message'>[M.say_quote(text)]</span></span></i>"
		master.show_message(rendered, 2)
	return

/obj/machinery/hologram/holopad/proc/create_holo(mob/living/silicon/ai/A, turf/T = loc)
	hologram = new(T)//Spawn a blank effect at the location.
	hologram.icon = A.holo_icon
	hologram.mouse_opacity = 0//So you can't click on it.
	hologram.layer = FLY_LAYER//Above all the other objects/mobs. Or the vast majority of them.
	hologram.sd_SetLuminosity(1)//To make it glowy.
	hologram.anchored = 1//So space wind cannot drag it.
	hologram.name = "AI hologram"//If someone decides to right click.
	sd_SetLuminosity(1)//To make the pad glowy.
	icon_state = "holopad1"
	master = A//AI is the master.
	use_power = 2//Active power usage.
	return 1

/obj/machinery/hologram/holopad/proc/clear_holo()
	hologram.sd_SetLuminosity(0)//Clear lighting.
	del(hologram)//Get rid of hologram.
	master = null//Null the master, since no-one is using it now.
	sd_SetLuminosity(0)//Clear lighting for the parent.
	icon_state = "holopad0"
	use_power = 1//Passive power usage.
	return 1

/obj/machinery/hologram/holopad/process()
	if(hologram)//If there is a hologram.
		if(master&&!master.stat&&master.client&&master.client.eye==src)//If there is an AI attached, it's not incapacitated, it has a client, and the client eye is centered on the projector.
			if( !(get_dist(src,hologram.loc)>3||stat & NOPOWER) )//If the hologram is not out of bounds and the machine has power.
				return 1
		clear_holo()//If not, we want to get rid of the hologram.
	return 1

/obj/machinery/hologram/power_change()
	if (powered())
		stat &= ~NOPOWER
	else
		stat |= ~NOPOWER

//Destruction procs.
/obj/machinery/hologram/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
		if(2.0)
			if (prob(50))
				del(src)
		if(3.0)
			if (prob(5))
				del(src)
	return

/obj/machinery/hologram/blob_act()
	del(src)
	return

/obj/machinery/hologram/meteorhit()
	del(src)
	return

/obj/machinery/hologram/Del()
	if(hologram)
		src:clear_holo()
	..()

/*
Holographic project of everything else.

/mob/verb/hologram_test()
	set name = "Hologram Debug New"
	set category = "CURRENT DEBUG"

	var/obj/overlay/hologram = new(loc)//Spawn a blank effect at the location.
	var/icon/flat_icon = icon(getFlatIcon(src,0))//Need to make sure it's a new icon so the old one is not reused.
	flat_icon.ColorTone(rgb(125,180,225))//Let's make it bluish.
	flat_icon.ChangeOpacity(0.5)//Make it half transparent.
	var/input = input("Select what icon state to use in effects.",,"")
	if(input)
		var/icon/alpha_mask = new('effects.dmi', "[input]")
		flat_icon.AddAlphaMask(alpha_mask)//Finally, let's mix in a distortion effect.
		hologram.icon = flat_icon

		world << "Your icon should appear now."
	return
*/

/obj/machinery/hologram_ai
	name = "Hologram Projector Platform"
	icon = 'stationobjs.dmi'
	icon_state = "hologram0"
	var/atom/projection = null
	var/temp = null
	var/lumens = 0.0
	var/h_r = 245.0
	var/h_g = 245.0
	var/h_b = 245.0
	anchored = 1.0

/obj/machinery/hologram_ai/wall_projector
	name = "Hologram Wall Projector"
	icon_state = "wall_hologram0"

/obj/machinery/hologram_ai/New()
	..()

/obj/machinery/hologram_ai/attack_ai(user as mob)
	src.show_console(user)
	return

/obj/machinery/hologram_ai/proc/render()
	var/icon/I = new /icon('human.dmi', "body_m_s")

	if (src.lumens >= 0)
		I.Blend(rgb(src.lumens, src.lumens, src.lumens), ICON_ADD)
	else
		I.Blend(rgb(- src.lumens,  -src.lumens,  -src.lumens), ICON_SUBTRACT)

	I.Blend(new /icon('human.dmi', "mouth_m_s"), ICON_OVERLAY)
	I.Blend(new /icon('human.dmi', "underwear1_m_s"), ICON_OVERLAY)

	var/icon/U = new /icon('human_face.dmi', "hair_a_s")
	U.Blend(rgb(src.h_r, src.h_g, src.h_b), ICON_ADD)

	I.Blend(U, ICON_OVERLAY)

	I.Blend(new /icon('uniform.dmi', "aqua_s"), ICON_OVERLAY)

	src.projection.icon = I

/obj/machinery/hologram_ai/proc/show_console(var/mob/user as mob)
	var/dat
	user.machine = src
	if (src.temp)
		dat = text("[]<BR><BR><A href='?src=\ref[];temp=1'>Clear</A>", src.temp, src)
	else
		dat = text("<B>Hologram Status:</B><HR>\nPower: <A href='?src=\ref[];power=1'>[]</A><HR>\n<B>Hologram Control:</B><BR>\nColor Luminosity: []/220 <A href='?src=\ref[];reset=1'>\[Reset\]</A><BR>\nLighten: <A href='?src=\ref[];light=1'>1</A> <A href='?src=\ref[];light=10'>10</A><BR>\nDarken: <A href='?src=\ref[];light=-1'>1</A> <A href='?src=\ref[];light=-10'>10</A><BR>\n<BR>\nHair Color: ([],[],[]) <A href='?src=\ref[];h_reset=1'>\[Reset\]</A><BR>\nRed (0-255): <A href='?src=\ref[];h_r=-300'>\[0\]</A> <A href='?src=\ref[];h_r=-10'>-10</A> <A href='?src=\ref[];h_r=-1'>-1</A> [] <A href='?src=\ref[];h_r=1'>1</A> <A href='?src=\ref[];h_r=10'>10</A> <A href='?src=\ref[];h_r=300'>\[255\]</A><BR>\nGreen (0-255): <A href='?src=\ref[];h_g=-300'>\[0\]</A> <A href='?src=\ref[];h_g=-10'>-10</A> <A href='?src=\ref[];h_g=-1'>-1</A> [] <A href='?src=\ref[];h_g=1'>1</A> <A href='?src=\ref[];h_g=10'>10</A> <A href='?src=\ref[];h_g=300'>\[255\]</A><BR>\nBlue (0-255): <A href='?src=\ref[];h_b=-300'>\[0\]</A> <A href='?src=\ref[];h_b=-10'>-10</A> <A href='?src=\ref[];h_b=-1'>-1</A> [] <A href='?src=\ref[];h_b=1'>1</A> <A href='?src=\ref[];h_b=10'>10</A> <A href='?src=\ref[];h_b=300'>\[255\]</A><BR>", src, (src.projection ? "On" : "Off"),  -src.lumens + 35, src, src, src, src, src, src.h_r, src.h_g, src.h_b, src, src, src, src, src.h_r, src, src, src, src, src, src, src.h_g, src, src, src, src, src, src, src.h_b, src, src, src)
	user << browse(dat, "window=hologram_console")
	onclose(user, "hologram_console")
	return

/obj/machinery/hologram_ai/Topic(href, href_list)
	..()
	if (!istype(usr, /mob/living/silicon/ai))
		return

	if (href_list["power"])
		if (src.projection)
			if(istype(src, /obj/machinery/hologram_ai/wall_projector))
				src.icon_state = "wall_hologram0"
			else
				src.icon_state = "hologram0"

			//src.projector.projection = null
			del(src.projection)
		else
			src.projection = new /obj/projection( src.loc )
			src.projection.icon = 'human.dmi'
			src.projection.icon_state = "male"
			if(istype(src, /obj/machinery/hologram_ai/wall_projector))
				src.icon_state = "wall_hologram1"
			else
				src.icon_state = "hologram1"
			src.render()
	else if (href_list["h_r"])
		if (src.projection)
			src.h_r += text2num(href_list["h_r"])
			src.h_r = min(max(src.h_r, 0), 255)
			render()
	else if (href_list["h_g"])
		if (src.projection)
			src.h_g += text2num(href_list["h_g"])
			src.h_g = min(max(src.h_g, 0), 255)
			render()
	else if (href_list["h_b"])
		if (src.projection)
			src.h_b += text2num(href_list["h_b"])
			src.h_b = min(max(src.h_b, 0), 255)
			render()
	else if (href_list["light"])
		if (src.projection)
			src.lumens += text2num(href_list["light"])
			src.lumens = min(max(src.lumens, -185.0), 35)
			render()
	else if (href_list["reset"])
		if (src.projection)
			src.lumens = 0
			render()
	else if (href_list["temp"])
		src.temp = null
	src.show_console(usr)