
/obj/crematorium
	name = "crematorium"
	desc = "A human incinerator. Works well on barbeque nights."
	icon = 'stationobjs.dmi'
	icon_state = "crema1"
	density = 1
	anchored = 1
	var
		obj/c_tray/connected = null
		cremating = 0
		id = 1
		locked = 0

	ex_act(severity)
		switch(severity)
			if(1.0)
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
				del(src)
				return
			if(2.0)
				if (prob(50))
					for(var/atom/movable/A as mob|obj in src)
						A.loc = src.loc
						ex_act(severity)
					del(src)
					return
			if(3.0)
				if (prob(5))
					for(var/atom/movable/A as mob|obj in src)
						A.loc = src.loc
						ex_act(severity)
					del(src)
					return
		return

	alter_health()
		return src.loc

	attack_paw(mob/user as mob)
		return src.attack_hand(user)

	attack_hand(mob/user as mob)
	/*
		if (cremating) //AWW MAN! THIS WOULD BE SO MUCH MORE FUN ... TO WATCH
			user.show_message("\red Uh-oh, that was a bad idea.", 1)
			//usr << "Uh-oh, that was a bad idea."
			src:loc:poison += 20000000
			src:loc:firelevel = src:loc:poison
			return
		if (cremating)
			usr << "\red It's locked."
			return
	*/
		if ((src.connected) && (src.locked == 0))
			for(var/atom/movable/A as mob|obj in src.connected.loc)
				if (!( A.anchored ))
					A.loc = src
			playsound(src.loc, 'Deconstruct.ogg', 50, 1)
			//src.connected = null
			del(src.connected)
		else if (src.locked == 0)
			playsound(src.loc, 'Deconstruct.ogg', 50, 1)
			src.connected = new /obj/c_tray( src.loc )
			step(src.connected, SOUTH)
			src.connected.layer = OBJ_LAYER
			var/turf/T = get_step(src, SOUTH)
			if (T.contents.Find(src.connected))
				src.connected.connected = src
				src.icon_state = "crema0"
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.connected.loc
				src.connected.icon_state = "cremat"
			else
				//src.connected = null
				del(src.connected)
		src.add_fingerprint(user)
		update()

	attackby(P as obj, mob/user as mob)
		if (istype(P, /obj/item/weapon/pen))
			var/t = input(user, "What would you like the label to be?", text("[]", src.name), null)  as text
			if (user.equipped() != P)
				return
			if ((!in_range(src, usr) > 1 && src.loc != user))
				return
			t = copytext(sanitize(t),1,MAX_MESSAGE_LEN)
			if (t)
				src.name = text("Crematorium- '[]'", t)
			else
				src.name = "Crematorium"
		src.add_fingerprint(user)
		return

	relaymove(mob/user as mob)
		if (user.stat || locked)
			return
		src.connected = new /obj/c_tray( src.loc )
		step(src.connected, SOUTH)
		src.connected.layer = OBJ_LAYER
		var/turf/T = get_step(src, SOUTH)
		if (T.contents.Find(src.connected))
			src.connected.connected = src
			src.icon_state = "crema0"
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.connected.loc
				//Foreach goto(106)
			src.connected.icon_state = "cremat"
		else
			//src.connected = null
			del(src.connected)
		return

	proc
		cremate(atom/A, mob/user as mob)
		/*
			for(var/obj/machinery/crema_switch/O in src) //trying to figure a way to call the switch, too drunk to sort it out atm
				if(var/on == 1)
				return
		*/
			if(cremating)
				return //don't let you cremate something twice or w/e
			if(length(contents) == 0)
				for (var/mob/M in viewers(user))
					M.show_message("\red You hear a hollow crackle.", 1)
					return
			else if(contents)
				cremating = 1
				locked = 1
				for (var/mob/living/M in contents)
					M:stunned = 100 //You really dont want to place this inside the loop.
					spawn(1)
						for(var/i=1 to 10)
							sleep(10)
							M.take_overall_damage(0,30)
							if (M.stat!=2 && prob(30))
								M.emote("scream")
						new /obj/decal/ash(src)
						for (var/obj/item/W in M)
							if (prob(10))
								W.loc = src
						M.death(1)
						M.ghostize()
						del(M)
						cremating = 0
						locked = 0
						playsound(src.loc, 'ding.ogg', 50, 1)
				for (var/mob/M in viewers(src))
					M.show_message("\red You hear a roar as the crematorium activates.", 1)
			return

		update()
			if (src.connected)
				src.icon_state = "crema0"
			else
				if (src.contents.len)
					src.icon_state = "crema2"
				else
					src.icon_state = "crema1"
			return
