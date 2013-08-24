
/obj/equip_e/human
	name = "human"
	var/mob/living/carbon/human/target = null

/obj/equip_e/human/process()
	if (item)
		item.add_fingerprint(source)
	if (!item)
		switch(place)
			if ("mask")
				if (!( target.wear_mask ))
					//SN src = null
					del(src)
					return
/*			if ("headset")
				if (!( target.w_radio ))
					//SN src = null
					del(src)
					return */
			if ("l_hand")
				if (!( target.l_hand ))
					//SN src = null
					del(src)
					return
			if ("r_hand")
				if (!( target.r_hand ))
					//SN src = null
					del(src)
					return
			if ("suit")
				if (!( target.wear_suit ))
					//SN src = null
					del(src)
					return
			if ("uniform")
				if (!( target.w_uniform ))
					//SN src = null
					del(src)
					return
			if ("back")
				if (!( target.back ))
					//SN src = null
					del(src)
					return
			if ("syringe")
				return
			if ("pill")
				return
			if ("fuel")
				return
			if ("drink")
				return
			if ("dnainjector")
				return
			if ("handcuff")
				if (!( target.handcuffed ))
					//SN src = null
					del(src)
					return
			if ("id")
				if ((!( target.wear_id ) || !( target.w_uniform )))
					//SN src = null
					del(src)
					return
			if ("internal")
				if ((!( (istype(target.wear_mask, /obj/item/clothing/mask) && istype(target.back, /obj/item/weapon/tank) && !( target.internal )) ) && !( target.internal )))
					//SN src = null
					del(src)
					return

	var/list/L = list( "syringe", "pill", "drink", "dnainjector", "fuel")
	if ((item && !( L.Find(place) )))
		if (isrobot(source) && place != "handcuff")
			del(src)
			return
		for(var/mob/O in viewers(target, null))
			O.show_message(text("\red <B>[] is trying to put \a [] on []</B>", source, item, target), 1)
	else
		if (place == "syringe")
			for(var/mob/O in viewers(target, null))
				O.show_message(text("\red <B>[] is trying to inject []!</B>", source, target), 1)
		else
			if (place == "pill")
				for(var/mob/O in viewers(target, null))
					O.show_message(text("\red <B>[] is trying to force [] to swallow []!</B>", source, target, item), 1)
			else
				if (place == "fuel")
					for(var/mob/O in viewers(target, null))
						O.show_message(text("\red [source] is trying to force [target] to eat the [item:content]!"), 1)
				else
					if (place == "drink")
						for(var/mob/O in viewers(target, null))
							O.show_message(text("\red <B>[] is trying to force [] to swallow a gulp of []!</B>", source, target, item), 1)
					else
						if (place == "dnainjector")
							for(var/mob/O in viewers(target, null))
								O.show_message(text("\red <B>[] is trying to inject [] with the []!</B>", source, target, item), 1)
						else
							var/message = null
							switch(place)
								if ("mask")
									if (istype(target.wear_mask, /obj/item/clothing)&&!target.wear_mask:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.wear_mask, target)
									else
										message = text("\red <B>[] is trying to take off \a [] from []'s head!</B>", source, target.wear_mask, target)
/*								if ("headset")
									message = text("\red <B>[] is trying to take off \a [] from []'s face!</B>", source, target.w_radio, target) */
								if ("l_hand")
									message = text("\red <B>[] is trying to take off \a [] from []'s left hand!</B>", source, target.l_hand, target)
								if ("r_hand")
									message = text("\red <B>[] is trying to take off \a [] from []'s right hand!</B>", source, target.r_hand, target)
								if ("gloves")
									if (istype(target.gloves, /obj/item/clothing)&&!target.gloves:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.gloves, target)
									else
										message = text("\red <B>[] is trying to take off the [] from []'s hands!</B>", source, target.gloves, target)
								if ("eyes")
									if (istype(target.glasses, /obj/item/clothing)&&!target.glasses:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.glasses, target)
									else
										message = text("\red <B>[] is trying to take off the [] from []'s eyes!</B>", source, target.glasses, target)
								if ("ears")
									if (istype(target.ears, /obj/item/clothing)&&!target.ears:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.ears, target)
									else
										message = text("\red <B>[] is trying to take off the [] from []'s ears!</B>", source, target.ears, target)
								if ("head")
									if (istype(target.head, /obj/item/clothing)&&!target.head:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.head, target)
									else
										message = text("\red <B>[] is trying to take off the [] from []'s head!</B>", source, target.head, target)
								if ("shoes")
									if (istype(target.shoes, /obj/item/clothing)&&!target.shoes:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.shoes, target)
									else
										message = text("\red <B>[] is trying to take off the [] from []'s feet!</B>", source, target.shoes, target)
								if ("belt")
									message = text("\red <B>[] is trying to take off the [] from []'s belt!</B>", source, target.belt, target)
								if ("suit")
									if (istype(target.wear_suit, /obj/item/clothing/suit/armor/a_i_a_ptank))//Exception for suicide vests.
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.wear_suit, target)
									else if (istype(target.wear_suit, /obj/item/clothing)&&!target.wear_suit:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.wear_suit, target)
									else
										message = text("\red <B>[] is trying to take off \a [] from []'s body!</B>", source, target.wear_suit, target)
								if ("back")
									message = text("\red <B>[] is trying to take off \a [] from []'s back!</B>", source, target.back, target)
								if ("handcuff")
									message = text("\red <B>[] is trying to unhandcuff []!</B>", source, target)
								if ("uniform")
									if (istype(target.w_uniform, /obj/item/clothing)&&!target.w_uniform:canremove)
										message = text("\red <B>[] fails to take off \a [] from []'s body!</B>", source, target.w_uniform, target)
									else
										message = text("\red <B>[] is trying to take off \a [] from []'s body!</B>", source, target.w_uniform, target)
								if ("s_store")
									message = text("\red <B>[] is trying to take off \a [] from []'s suit!</B>", source, target.s_store, target)
								if ("h_store")
									message = text("\red <B>[] is trying to empty []'s hat!</B>", source, target)
								if ("pockets")
									for(var/obj/item/weapon/mousetrap/MT in  list(target.l_store, target.r_store))
										if (MT.armed)
											for(var/mob/O in viewers(target, null))
												if (O == source)
													O.show_message(text("\red <B>You reach into the [target]'s pockets, but there was a live mousetrap in there!</B>"), 1)
												else
													O.show_message(text("\red <B>[source] reaches into [target]'s pockets and sets off a hidden mousetrap!</B>"), 1)
											target.u_equip(MT)
											if (target.client)
												target.client.screen -= MT
											MT.loc = source.loc
											MT.triggered(source, source.hand ? "l_hand" : "r_hand")
											MT.layer = OBJ_LAYER
											return
									message = text("\red <B>[] is trying to empty []'s pockets!!</B>", source, target)
								if ("CPR")
									if (target.cpr_time >= world.time + 3)
										//SN src = null
										del(src)
										return
									message = text("\red <B>[] is trying perform CPR on []!</B>", source, target)
								if ("id")
									message = text("\red <B>[] is trying to take off [] from []'s uniform!</B>", source, target.wear_id, target)
								if ("internal")
									if (target.internal)
										message = text("\red <B>[] is trying to remove []'s internals</B>", source, target)
									else
										message = text("\red <B>[] is trying to set on []'s internals.</B>", source, target)
								else
							for(var/mob/M in viewers(target, null))
								M.show_message(message, 1)
	spawn( 40 )
		done()
		return
	return

/*
This proc equips stuff (or does something else) when removing stuff manually from the character window when you click and drag.
It works in conjuction with the process() above.
This proc works for humans only. Aliens stripping humans and the like will all use this proc. Stripping monkeys or somesuch will use their version of this proc.
The first if statement for "mask" and such refers to items that are already equipped and un-equipping them.
The else statement is for equipping stuff to empty slots.
!canremove refers to variable of /obj/item/clothing which either allows or disallows that item to be removed.
It can still be worn/put on as normal.
*/
/obj/equip_e/human/done()
	if (!source || !target)						return
	if (source.loc != s_loc)						return
	if (target.loc != t_loc)						return
	if (LinkBlocked(s_loc,t_loc))				return
	if (item && source.equipped() != item)	return
	if ((source.restrained() || source.stat))	return
	switch(place)
		if ("mask")
			if (target.wear_mask)
				if (istype(target.wear_mask, /obj/item/clothing)&& !target.wear_mask:canremove)
					return
				var/obj/item/clothing/W = target.wear_mask
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/mask))
					source.drop_item()
					loc = target
					item.layer = 20
					target.wear_mask = item
					item.loc = target
/*		if ("headset")
			if (target.w_radio)
				var/obj/item/W = target.w_radio
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
			else
				if (istype(item, /obj/item/device/radio/headset))
					source.drop_item()
					loc = target
					item.layer = 20
					target.w_radio = item
					item.loc = target*/
		if ("gloves")
			if (target.gloves)
				if (istype(target.gloves, /obj/item/clothing)&& !target.gloves:canremove)
					return
				var/obj/item/clothing/W = target.gloves
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/gloves))
					source.drop_item()
					loc = target
					item.layer = 20
					target.gloves = item
					item.loc = target
		if ("eyes")
			if (target.glasses)
				if (istype(target.glasses, /obj/item/clothing)&& !target.glasses:canremove)
					return
				var/obj/item/W = target.glasses
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/glasses))
					source.drop_item()
					loc = target
					item.layer = 20
					target.glasses = item
					item.loc = target
		if ("belt")
			if (target.belt)
				var/obj/item/W = target.belt
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if ((istype(item, /obj) && item.flags & 128 && target.w_uniform))
					source.drop_item()
					loc = target
					item.layer = 20
					target.belt = item
					item.loc = target
		if ("s_store")
			if (target.s_store)
				var/obj/item/W = target.s_store
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj) && target.wear_suit)
					var/confirm
					for(var/i=1, i<=target.wear_suit.allowed.len, i++)
		//				world << "[target.wear_suit.allowed[i]] and [W.type]"
						if (findtext("[item.type]","[target.wear_suit.allowed[i]]") || istype(item, /obj/item/device/pda) || istype(item, /obj/item/weapon/pen))
							confirm = 1
							break
					if (!confirm) return
					else
						source.drop_item()
						loc = target
						item.layer = 20
						target.s_store = item
						item.loc = target
		if ("head")
			if (target.head)
				if (istype(target.head, /obj/item/clothing)&& !target.head:canremove)
					return
				var/obj/item/W = target.head
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/head))
					source.drop_item()
					loc = target
					item.layer = 20
					target.head = item
					item.loc = target
		if ("ears")
			if (target.ears)
				if (istype(target.ears, /obj/item/clothing)&& !target.ears:canremove)
					return
				var/obj/item/W = target.ears
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/ears))
					source.drop_item()
					loc = target
					item.layer = 20
					target.ears = item
					item.loc = target
				else if (istype(item, /obj/item/device/radio/headset))
					source.drop_item()
					loc = target
					item.layer = 20
					target.ears = item
					item.loc = target
		if ("shoes")
			if (target.shoes)
				if (istype(target.shoes, /obj/item/clothing)&& !target.shoes:canremove)
					return
				var/obj/item/W = target.shoes
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/shoes))
					source.drop_item()
					loc = target
					item.layer = 20
					target.shoes = item
					item.loc = target
		if ("l_hand")
			if (istype(target, /obj/item/clothing/suit/straight_jacket))
				//SN src = null
				del(src)
				return
			if (target.l_hand)
				var/obj/item/W = target.l_hand
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item))
					source.drop_item()
					loc = target
					item.layer = 20
					target.l_hand = item
					item.loc = target
					item.add_fingerprint(target)
		if ("r_hand")
			if (istype(target, /obj/item/clothing/suit/straight_jacket))
				//SN src = null
				del(src)
				return
			if (target.r_hand)
				var/obj/item/W = target.r_hand
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item))
					source.drop_item()
					loc = target
					if (item)
						item.layer = 20
						target.r_hand = item
						item.loc = target
						item.add_fingerprint(target)
		if ("uniform")
			if (target.w_uniform)
				if (istype(target.w_uniform, /obj/item/clothing)&& !target.w_uniform:canremove)
					return
				var/obj/item/W = target.w_uniform
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
				W = target.l_store
				if (W)
					target.u_equip(W)
					if (target.client)
						target.client.screen -= W
					if (W)
						W.loc = target.loc
						W.dropped(target)
						W.layer = initial(W.layer)
				W = target.r_store
				if (W)
					target.u_equip(W)
					if (target.client)
						target.client.screen -= W
					if (W)
						W.loc = target.loc
						W.dropped(target)
						W.layer = initial(W.layer)
				W = target.wear_id
				if (W)
					target.u_equip(W)
					if (target.client)
						target.client.screen -= W
					if (W)
						W.loc = target.loc
						W.dropped(target)
						W.layer = initial(W.layer)
			else
				if (istype(item, /obj/item/clothing/under))
					source.drop_item()
					loc = target
					item.layer = 20
					target.w_uniform = item
					item.loc = target
		if ("suit")
			if (target.wear_suit)
				if (istype(target.wear_suit, /obj/item/clothing/suit/armor/a_i_a_ptank))//triggers suicide vest if someone else tries to take it off/N
					var/obj/item/clothing/suit/armor/a_i_a_ptank/A = target.wear_suit//mostly a copy from death.dm code.
					bombers += "[target.key] has detonated a suicide bomb. Temp = [A.part4.air_contents.temperature-T0C]."
					if (A.status && prob(90))
						A.part4.ignite()
						return
				if (istype(target.wear_suit, /obj/item/clothing)&& !target.wear_suit:canremove)
					if (!istype(target.wear_suit, /obj/item/clothing/suit/armor/a_i_a_ptank))	return//Can remove the suicide vest if it didn't trigger.
				var/obj/item/W = target.wear_suit
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/clothing/suit))
					source.drop_item()
					loc = target
					item.layer = 20
					target.wear_suit = item
					item.loc = target
		if ("id")
			if (target.wear_id)
				var/obj/item/W = target.wear_id
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (((istype(item, /obj/item/weapon/card/id)||istype(item, /obj/item/device/pda)) && target.w_uniform))
					source.drop_item()
					loc = target
					item.layer = 20
					target.wear_id = item
					item.loc = target
		if ("back")
			if (target.back)
				var/obj/item/W = target.back
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if ((istype(item, /obj/item) && item.flags & 1))
					source.drop_item()
					loc = target
					item.layer = 20
					target.back = item
					item.loc = target
		if ("h_store")
			if (target.h_store)
				var/obj/item/W = target.h_store
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
		if ("handcuff")
			if (target.handcuffed)
				var/obj/item/W = target.handcuffed
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			else
				if (istype(item, /obj/item/weapon/handcuffs))
					target.drop_from_slot(target.r_hand)
					target.drop_from_slot(target.l_hand)
					source.drop_item()
					target.handcuffed = item
					item.loc = target
		if ("CPR")
			if (target.cpr_time >= world.time + 30)
				//SN src = null
				del(src)
				return
			if ((target.health >= -99.0 && target.health < 0))
				target.cpr_time = world.time
				var/suff = min(target.oxyloss, 7)
				target.oxyloss -= suff
				target.updatehealth()
				for(var/mob/O in viewers(source, null))
					O.show_message(text("\red [] performs CPR on []!", source, target), 1)
				target << "\blue <b>You feel a breath of fresh air enter your lungs. It feels good.</b>"
				source << "\red Repeat every 7 seconds AT LEAST."
		if ("fuel")
			var/obj/item/weapon/fuel/S = item
			if (!( istype(S, /obj/item/weapon/fuel) ))
				//SN src = null
				del(src)
				return
			if (S.s_time >= world.time + 30)
				//SN src = null
				del(src)
				return
			S.s_time = world.time
			var/a = S.content
			for(var/mob/O in viewers(source, null))
				O.show_message(text("\red [source] forced [target] to eat the [a]!"), 1)
			S.injest(target)
		if ("dnainjector")
			var/obj/item/weapon/dnainjector/S = item
			if (item)
				item.add_fingerprint(source)
				item:inject(target, null)
				if (!( istype(S, /obj/item/weapon/dnainjector) ))
					//SN src = null
					del(src)
					return
				if (S.s_time >= world.time + 30)
					//SN src = null
					del(src)
					return
				S.s_time = world.time
				for(var/mob/O in viewers(source, null))
					O.show_message(text("\red [] injects [] with the DNA Injector!", source, target), 1)
		if ("pockets")
			if (target.l_store)
				var/obj/item/W = target.l_store
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
			if (target.r_store)
				var/obj/item/W = target.r_store
				target.u_equip(W)
				if (target.client)
					target.client.screen -= W
				if (W)
					W.loc = target.loc
					W.dropped(target)
					W.layer = initial(W.layer)
				W.add_fingerprint(source)
		if ("internal")
			if (target.internal)
				target.internal.add_fingerprint(source)
				target.internal = null
				if (target.internals)
					target.internals.icon_state = "internal0"
			else
				if (!( istype(target.wear_mask, /obj/item/clothing/mask) ))
					return
				else
					if (istype(target.back, /obj/item/weapon/tank))
						target.internal = target.back
					else if (istype(target.s_store, /obj/item/weapon/tank))
						target.internal = target.s_store
					else if (istype(target.belt, /obj/item/weapon/tank))
						target.internal = target.belt
					if (target.internal)
						for(var/mob/M in viewers(target, 1))
							M.show_message(text("[] is now running on internals.", target), 1)
						target.internal.add_fingerprint(source)
						if (target.internals)
							target.internals.icon_state = "internal1"
		else
	if (source)
		source.update_clothing()
	if (target)
		target.update_clothing()
	//SN src = null
	del(src)
	return
