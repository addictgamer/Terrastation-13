
/obj/item/weapon/firbang
	desc = "It is set to detonate in 10 seconds."
	name = "firbang"
	icon = 'grenade.dmi'
	icon_state = "flashbang"
	w_class = 2.0
	item_state = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	var
		state = null
		det_time = 100.0

	afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
		if (user.equipped() == src)
			if ((user.mutations & CLOWN) && prob(50))
				user << "\red Huh? How does this thing work?!"
				src.state = 1
				src.icon_state = "flashbang1"
				playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
				spawn( 5 )
					prime()
					return
			else if (!( src.state ))
				user << "\red You prime the [src]! [det_time/10] seconds!"
				src.state = 1
				src.icon_state = "flashbang1"
				playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
				spawn( src.det_time )
					prime()
					return
			user.dir = get_dir(user, target)
			user.drop_item()
			var/t = (isturf(target) ? target : target.loc)
			walk_towards(src, t, 3)
			src.add_fingerprint(user)
		return

	attack_paw(mob/user as mob)
		return src.attack_hand(user)

	attack_self(mob/user as mob)
		if (!src.state)
			if (user.mutations & CLOWN)
				user << "\red Huh? How does this thing work?!"
				spawn( 5 )
					prime()
					return
			else
				user << "\red You prime the [src]! [det_time/10] seconds!"
				src.state = 1
				src.icon_state = "flashbang1"
				add_fingerprint(user)
				spawn( src.det_time )
					prime()
					return
		return

	attack_hand()
		walk(src, null, null)
		..()
		return

/obj/item/weapon/firbang/proc/prime()
	playsound(src.loc, 'bang.ogg', 25, 1)
	var/turf/T = get_turf(src)
	if (T)
		var/datum/effects/system/harmless_smoke_spread/smoke = new
		smoke.set_up(3, 0, src.loc)
		smoke.attach(src)
		smoke.start()
		var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		new /obj/new_year_tree(T)
	del(src)
	return

