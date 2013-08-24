
/obj/item/weapon/gun/rapidsyringe
	name = "rapid syringe gun"
	icon = 'gun.dmi'
	icon_state = "syringegun"
	item_state = "syringegun"
	w_class = 3.0
	throw_speed = 4
	throw_range = 10
	force = 8.0
	var/list/syringes = new/list()
	var/max_syringes = 40

	examine()
		set src in view()
		..()
		if (!(usr in view(2)) && usr!=src.loc) return
		usr << "\icon [src] Rapid Syringe gun:"
		usr << "\blue [syringes] / [max_syringes] Syringes."

	attackby(obj/item/I as obj, mob/user as mob)
		if (istype(I, /obj/item/weapon/reagent_containers/syringe))
			if (syringes.len < max_syringes)
				user.drop_item()
				I.loc = src
				syringes += I
				user << "\blue You put the syringe in the rapid syringe gun."
				user << "\blue [syringes.len] / [max_syringes] Syringes."
			else
				usr << "\red The rapid syringe gun cannot hold more syringes."

	afterattack(obj/target, mob/user , flag)
		if (!isturf(target.loc) || target == user) return

		if (syringes.len)
			spawn(0) fire_syringe(target,user)
		else
			usr << "\red rapid The syringe gun is empty."

	proc
		fire_syringe(atom/target, mob/user)
			if (locate (/obj/table, src.loc))
				return
			else
				var/turf/trg = get_turf(target)
				var/obj/syringe_gun_dummy/D = new/obj/syringe_gun_dummy(get_turf(src))
				var/obj/item/weapon/reagent_containers/syringe/S = syringes[1]
				S.reagents.trans_to(D, S.reagents.total_volume)
				syringes -= S
				del(S)
				D.icon_state = "syringeproj"
				D.name = "syringe"
				playsound(user.loc, 'syringeproj.ogg', 50, 1)

				for(var/i=0, i<6, i++)
					if (!D) break
					if (D.loc == trg) break
					step_towards(D,trg)

					for(var/mob/living/carbon/M in D.loc)
						if (!istype(M,/mob/living/carbon)) continue
						if (M == user) continue
						D.reagents.trans_to(M, 15)
						M.take_organ_damage(5)
						for(var/mob/O in viewers(world.view, D))
							O.show_message(text("\red [] was hit by the syringe!", M), 1)

						del(D)
					if (D)
						for(var/atom/A in D.loc)
							if (A == user) continue
							if (A.density) del(D)

					sleep(1)

				if (D) spawn(10) del(D)

				return
