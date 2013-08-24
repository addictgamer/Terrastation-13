
/obj/screen
	name = "screen"
	icon = 'screen1.dmi'
	layer = 20.0
	unacidable = 1
	var
		id = 0.0
		obj/master

	Click(location, control, params)
		var/list/pa = params2list(params)
		switch(name)
			if ("map")
				usr.clearmap()
			if ("maprefresh")
				var/obj/machinery/computer/security/seccomp = usr.machine
				if (seccomp!=null)
					seccomp.drawmap(usr)
				else
					usr.clearmap()
			if ("other")
				if (usr.hud_used.show_otherinventory)
					usr.hud_used.show_otherinventory = 0
					usr.client.screen -= usr.hud_used.other
				else
					usr.hud_used.show_otherinventory = 1
					usr.client.screen += usr.hud_used.other
				usr.hud_used.other_update()
			if ("act_intent")
				if (pa.Find("left"))
					switch(usr.a_intent)
						if ("help")
							usr.a_intent = "disarm"
							usr.hud_used.action_intent.icon_state = "disarm"
						if ("disarm")
							usr.a_intent = "hurt"
							usr.hud_used.action_intent.icon_state = "harm"
						if ("hurt")
							usr.a_intent = "grab"
							usr.hud_used.action_intent.icon_state = "grab"
						if ("grab")
							usr.a_intent = "help"
							usr.hud_used.action_intent.icon_state = "help"
				else
					switch(usr.a_intent)
						if ("help")
							usr.a_intent = "grab"
							usr.hud_used.action_intent.icon_state = "grab"
						if ("disarm")
							usr.a_intent = "help"
							usr.hud_used.action_intent.icon_state = "help"
						if ("hurt")
							usr.a_intent = "disarm"
							usr.hud_used.action_intent.icon_state = "disarm"
						if ("grab")
							usr.a_intent = "hurt"
							usr.hud_used.action_intent.icon_state = "harm"
			if ("arrowleft")
				switch(usr.a_intent)
					if ("help")
						if (issilicon(usr))
							usr.a_intent = "hurt"
							usr.hud_used.action_intent.icon_state = "harm"
						else
							usr.a_intent = "grab"
							usr.hud_used.action_intent.icon_state = "grab"
					if ("disarm")
						usr.a_intent = "help"
						usr.hud_used.action_intent.icon_state = "help"
					if ("hurt")
						if (issilicon(usr))
							usr.a_intent = "help"
							usr.hud_used.action_intent.icon_state = "help"
						else
							usr.a_intent = "disarm"
							usr.hud_used.action_intent.icon_state = "disarm"
					if ("grab")
						usr.a_intent = "hurt"
						usr.hud_used.action_intent.icon_state = "harm"
			if ("arrowright")
				switch(usr.a_intent)
					if ("help")
						if (issilicon(usr))
							usr.a_intent = "hurt"
							usr.hud_used.action_intent.icon_state = "harm"
						else
							usr.a_intent = "disarm"
							usr.hud_used.action_intent.icon_state = "disarm"
					if ("disarm")
						usr.a_intent = "hurt"
						usr.hud_used.action_intent.icon_state = "harm"
					if ("hurt")
						if (issilicon(usr))
							usr.a_intent = "help"
							usr.hud_used.action_intent.icon_state = "help"
						else
							usr.a_intent = "grab"
							usr.hud_used.action_intent.icon_state = "grab"
					if ("grab")
						usr.a_intent = "help"
						usr.hud_used.action_intent.icon_state = "help"
			if ("mov_intent")
				switch(usr.m_intent)
					if ("run")
						usr.m_intent = "walk"
						usr.hud_used.move_intent.icon_state = "walking"
					if ("walk")
						usr.m_intent = "run"
						usr.hud_used.move_intent.icon_state = "running"
			if ("intent")
				if (!( usr.intent ))
					switch(usr.a_intent)
						if ("help")
							usr.intent = "13,15"
						if ("disarm")
							usr.intent = "14,15"
						if ("hurt")
							usr.intent = "15,15"
						if ("grab")
							usr.intent = "12,15"
				else
					usr.intent = null
			if ("m_intent")
				if (!( usr.m_int ))
					switch(usr.m_intent)
						if ("run")
							usr.m_int = "13,14"
						if ("walk")
							usr.m_int = "14,14"
						if ("face")
							usr.m_int = "15,14"
				else
					usr.m_int = null
			if ("walk")
				usr.m_intent = "walk"
				usr.m_int = "14,14"
			if ("face")
				usr.m_intent = "face"
				usr.m_int = "15,14"
			if ("run")
				usr.m_intent = "run"
				usr.m_int = "13,14"
			if ("hurt")
				usr.a_intent = "hurt"
				usr.intent = "15,15"
			if ("grab")
				usr.a_intent = "grab"
				usr.intent = "12,15"
			if ("disarm")
				if (istype(usr, /mob/living/carbon/human))
					var/mob/M = usr
					M.a_intent = "disarm"
					M.intent = "14,15"
			if ("help")
				usr.a_intent = "help"
				usr.intent = "13,15"
			if ("Reset Machine")
				usr.machine = null
			if ("internal")
				if ((!( usr.stat ) && usr.canmove && !( usr.restrained() )))
					if (usr.internal)
						usr.internal = null
						if (usr.internals)
							usr.internals.icon_state = "internal0"
					else
						if (!( istype(usr.wear_mask, /obj/item/clothing/mask) ))
							return
						else
							if (istype(usr.back, /obj/item/weapon/tank))
								usr.internal = usr.back
							else if (ishuman(usr) && istype(usr:s_store, /obj/item/weapon/tank))
								usr.internal = usr:s_store
							else if (ishuman(usr) && istype(usr:belt, /obj/item/weapon/tank))
								usr.internal = usr:belt
							else if (istype(usr.l_hand, /obj/item/weapon/tank))
								usr.internal = usr.l_hand
							else if (istype(usr.r_hand, /obj/item/weapon/tank))
								usr.internal = usr.r_hand
							if (usr.internal)
								//for(var/mob/M in viewers(usr, 1))
								//	M.show_message(text("[] is now running on internals.", usr), 1)
								usr << "You are now running on internals."
								if (usr.internals)
									usr.internals.icon_state = "internal1"
			if ("pull")
				usr.pulling = null
			if ("sleep")
				usr.sleeping = !( usr.sleeping )
			if ("rest")
				usr.resting = !( usr.resting )
			if ("throw")
				if (!usr.stat && isturf(usr.loc) && !usr.restrained())
					usr:toggle_throw_mode()
			if ("drop")
				usr.drop_item_v()
			if ("swap")
				usr:swap_hand()
			if ("hand")
				usr:swap_hand()
			if ("resist")
				if (usr.next_move < world.time)
					return
				usr.next_move = world.time + 20
				if ((!( usr.stat ) && usr.canmove && !( usr.restrained() )))
					for(var/obj/O in usr.requests)
						del(O)
					for(var/obj/item/weapon/grab/G in usr.grabbed_by)
						if (G.state == 1)
							del(G)
						else
							if (G.state == 2)
								if (prob(25))
									for(var/mob/O in viewers(usr, null))
										O.show_message(text("\red [] has broken free of []'s grip!", usr, G.assailant), 1)
									del(G)
							else
								if (G.state == 3)
									if (prob(5))
										for(var/mob/O in viewers(usr, null))
											O.show_message(text("\red [] has broken free of []'s headlock!", usr, G.assailant), 1)
										del(G)
					for(var/mob/O in viewers(usr, null))
						O.show_message(text("\red <B>[] resists!</B>", usr), 1)
				if (usr:handcuffed && usr:canmove && (usr.last_special <= world.time))
					usr.next_move = world.time + 100
					usr.last_special = world.time + 100
					if (isalienadult(usr) || usr.mutations & HULK)//Don't want to do a lot of logic gating here.
						usr << "\green You attempt to break your handcuffs. (This will take around 5 seconds and you need to stand still)"
						for(var/mob/O in viewers(usr))
							O.show_message(text("\red <B>[] is trying to break the handcuffs!</B>", usr), 1)
						spawn(0)
							if (do_after(usr, 50))
								if (!usr:handcuffed) return
								for(var/mob/O in viewers(usr))
									O.show_message(text("\red <B>[] manages to break the handcuffs!</B>", usr), 1)
								usr << "\green You successfully break your handcuffs."
								del(usr:handcuffed)
								usr:handcuffed = null
					else
						usr << "\red You attempt to remove your handcuffs. (This will take around 2 minutes and you need to stand still)"
						for(var/mob/O in viewers(usr))
							O.show_message(text("\red <B>[] attempts to remove the handcuffs!</B>", usr), 1)
						spawn(0)
							if (do_after(usr, 1200))
								if (!usr:handcuffed) return
								for(var/mob/O in viewers(usr))
									O.show_message(text("\red <B>[] manages to remove the handcuffs!</B>", usr), 1)
								usr << "\blue You successfully remove your handcuffs."
								usr:handcuffed:loc = usr:loc
								usr:handcuffed = null
				if (usr:handcuffed && (usr.last_special <= world.time) && usr:buckled)
					usr.next_move = world.time + 100
					usr.last_special = world.time + 100
					usr << "\red You attempt to unbuckle yourself. (This will take around 2 minutes and you need to stand still)"
					for(var/mob/O in viewers(usr))
						O.show_message(text("\red <B>[] attempts to unbuckle themself!</B>", usr), 1)
					spawn(0)
						if (do_after(usr, 1200))
							if (!usr:buckled) return
							for(var/mob/O in viewers(usr))
								O.show_message(text("\red <B>[] manages to unbuckle themself!</B>", usr), 1)
							usr << "\blue You successfully unbuckle yourself."
							usr:buckled.manual_unbuckle_all(usr)
			if ("module")
				if (istype(usr, /mob/living/silicon/robot))
					if (usr:module)
						return
					usr:pick_module()
			if ("radio")
				if (istype(usr, /mob/living/silicon/robot))
					usr:radio_menu()
			if ("panel")
				if (istype(usr, /mob/living/silicon/robot))
					usr:installed_modules()
			if ("store")
				if (istype(usr, /mob/living/silicon/robot))
					usr:uneq_active()
			if ("module1")
				if (usr:module_state_1)
					if (usr:module_active != usr:module_state_1)
						usr:inv1.icon_state = "inv1 +a"
						usr:inv2.icon_state = "inv2"
						usr:inv3.icon_state = "inv3"
						usr:module_active = usr:module_state_1
					else
						usr:inv1.icon_state = "inv1"
						usr:module_active = null
			if ("module2")
				if (usr:module_state_2)
					if (usr:module_active != usr:module_state_2)
						usr:inv1.icon_state = "inv1"
						usr:inv2.icon_state = "inv2 +a"
						usr:inv3.icon_state = "inv3"
						usr:module_active = usr:module_state_2
					else
						usr:inv2.icon_state = "inv2"
						usr:module_active = null
			if ("module3")
				if (usr:module_state_3)
					if (usr:module_active != usr:module_state_3)
						usr:inv1.icon_state = "inv1"
						usr:inv2.icon_state = "inv2"
						usr:inv3.icon_state = "inv3 +a"
						usr:module_active = usr:module_state_3
					else
						usr:inv3.icon_state = "inv3"
						usr:module_active = null
			else
				DblClick()
		return

	attack_hand(mob/user as mob, using)
		user.db_click(name, using)
		return

	attack_paw(mob/user as mob, using)
		user.db_click(name, using)
		return
