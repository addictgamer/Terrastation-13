
/obj/item/toy/crossbow
	name = "foam dart crossbow"
	desc = "A weapon favored by many overactive children. Ages 8 and up."
	icon = 'gun.dmi'
	icon_state = "crossbow"
	item_state = "crossbow"
	flags = FPRINT | TABLEPASS | USEDELAY
	w_class = 2.0
	var/bullets = 5

	examine()
		set src in view(2)
		..()
		if (bullets)
			usr << "\blue It is loaded with [bullets] foam darts!"

	attackby(obj/item/I as obj, mob/user as mob)
		if (istype(I, /obj/item/toy/ammo/crossbow))
			if (bullets <= 4)
				user.drop_item()
				del(I)
				bullets++
				user << "\blue You load the foam dart into the crossbow."
			else
				usr << "\red It's already fully loaded."


	afterattack(atom/target as mob|obj|turf|area, mob/user as mob, flag)
		if (!isturf(target.loc) || target == user) return
		if (flag) return

		if (locate (/obj/table, src.loc))
			return
		else if (bullets)
			var/turf/trg = get_turf(target)
			var/obj/foam_dart_dummy/D = new/obj/foam_dart_dummy(get_turf(src))
			bullets--
			D.icon_state = "foamdart"
			D.name = "foam dart"
			playsound(user.loc, 'syringeproj.ogg', 50, 1)

			for(var/i=0, i<6, i++)
				if (D)
					if (D.loc == trg) break
					step_towards(D,trg)

					for(var/mob/living/M in D.loc)
						if (!istype(M,/mob/living)) continue
						if (M == user) continue
						for(var/mob/O in viewers(world.view, D))
							O.show_message(text("\red [] was hit by the foam dart!", M), 1)
						new /obj/item/toy/ammo/crossbow(M.loc)
						del(D)
						return

					for(var/atom/A in D.loc)
						if (A == user) continue
						if (A.density)
							new /obj/item/toy/ammo/crossbow(A.loc)
							del(D)

				sleep(1)

			spawn(10)
				if (D)
					new /obj/item/toy/ammo/crossbow(D.loc)
					del(D)

			return
		else if (bullets == 0)
			user.weakened += 5
			for(var/mob/O in viewers(world.view, user))
				O.show_message(text("\red [] realized they were out of ammo and starting scrounging for some!", user), 1)


	attack(mob/M as mob, mob/user as mob)
		src.add_fingerprint(user)

// ******* Check

		if (src.bullets > 0 && M.lying)

			for(var/mob/O in viewers(M, null))
				if (O.client)
					O.show_message(text("\red <B>[] casually lines up a shot with []'s head and pulls the trigger!</B>", user, M), 1, "\red You hear the sound of foam against skull", 2)
					O.show_message(text("\red [] was hit in the head by the foam dart!", M), 1)

			playsound(user.loc, 'syringeproj.ogg', 50, 1)
			new /obj/item/toy/ammo/crossbow(M.loc)
			src.bullets--
		else if (M.lying && src.bullets == 0)
			for(var/mob/O in viewers(M, null))
				if (O.client)	O.show_message(text("\red <B>[] casually lines up a shot with []'s head, pulls the trigger, then realizes they are out of ammo and drops to the floor in search of some!</B>", user, M), 1, "\red You hear someone fall", 2)
			user.weakened += 5
		return
