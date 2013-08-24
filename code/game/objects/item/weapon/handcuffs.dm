
/obj/item/weapon/handcuffs
	name = "handcuffs"
	desc = "Use this to keep prisoners in line."
	icon = 'items.dmi'
	icon_state = "handcuff"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	throwforce = 5
	w_class = 2.0
	throw_speed = 2
	throw_range = 5
	m_amt = 500
	origin_tech = "materials=1"
	var/dispenser = 0

/obj/item/weapon/handcuffs/attack(mob/M as mob, mob/user as mob)
	if (istype(src, /obj/item/weapon/handcuffs/cyborg) && isrobot(user))
		if (!M.handcuffed)
			var/turf/p_loc = user.loc
			var/turf/p_loc_m = M.loc
			playsound(src.loc, 'handcuffs.ogg', 30, 1, -2)
			for(var/mob/O in viewers(user, null))
				O.show_message("\red <B>[user] is trying to put handcuffs on [M]!</B>", 1)
			spawn(30)
				if (p_loc == user.loc && p_loc_m == M.loc)
					M.handcuffed = new /obj/item/weapon/handcuffs(M)

	else
		if ((usr.mutations & CLOWN) && prob(50))
			usr << "\red Uh ... how do those things work?!"
			if (istype(M, /mob/living/carbon/human))
				var/obj/equip_e/human/O = new /obj/equip_e/human(  )
				O.source = user
				O.target = user
				O.item = user.equipped()
				O.s_loc = user.loc
				O.t_loc = user.loc
				O.place = "handcuff"
				M.requests += O
				spawn( 0 )
					O.process()
					return
			return
		if (!(istype(usr, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
			usr << "\red You don't have the dexterity to do this!"
			return
		if (istype(M, /mob/living/carbon/human))
			M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been handcuffed (attempt) by [user.name] ([user.ckey])</font>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Attempted to handcuff [M.name] ([M.ckey])</font>")
			var/obj/equip_e/human/O = new /obj/equip_e/human(  )
			O.source = user
			O.target = M
			O.item = user.equipped()
			O.s_loc = user.loc
			O.t_loc = M.loc
			O.place = "handcuff"
			M.requests += O
			spawn( 0 )
				playsound(src.loc, 'handcuffs.ogg', 30, 1, -2)
				O.process()
				return
		else
			var/obj/equip_e/monkey/O = new /obj/equip_e/monkey(  )
			O.source = user
			O.target = M
			O.item = user.equipped()
			O.s_loc = user.loc
			O.t_loc = M.loc
			O.place = "handcuff"
			M.requests += O
			spawn( 0 )
				playsound(src.loc, 'handcuffs.ogg', 30, 1, -2)
				O.process()
				return
	return

/obj/item/weapon/handcuffs/cyborg
	dispenser = 1
