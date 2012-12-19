
/turf/space
	icon = 'space.dmi'
	name = "space"
	icon_state = "placeholder"

	temperature = TCMB
	thermal_conductivity = OPEN_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 700000

/turf/space/New()
//	icon = 'space.dmi'
	icon_state = "[pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)]"

/turf/space/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(0)

/turf/space/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/turf/space/attack_hand(mob/user as mob)
	if ((user.restrained() || !( user.pulling )))
		return
	if (user.pulling.anchored)
		return
	if ((user.pulling.loc != user.loc && get_dist(user, user.pulling) > 1))
		return
	if (ismob(user.pulling))
		var/mob/M = user.pulling
		var/t = M.pulling
		M.pulling = null
		step(user.pulling, get_dir(user.pulling.loc, src))
		M.pulling = t
	else
		step(user.pulling, get_dir(user.pulling.loc, src))
	return

/turf/space/attackby(obj/item/C as obj, mob/user as mob)

	if (istype(C, /obj/item/stack/rods))
		user << "\blue Constructing support lattice ..."
		playsound(src.loc, 'Genhit.ogg', 50, 1)
		ReplaceWithLattice()
		C:use(1)
		return

	if (istype(C, /obj/item/stack/tile/steel))
		var/obj/lattice/L = locate(/obj/lattice, src)
		if(L)
			del(L)
			playsound(src.loc, 'Genhit.ogg', 50, 1)
			C:build(src)
			C:use(1)
			return
		else
			user << "\red The plating is going to need some support."
	return


// Ported from unstable r355

/turf/space/Entered(atom/movable/A as mob|obj)
	..()
	if ((!(A) || src != A.loc || istype(null, /obj/beam)))
		return

	if (!(A.last_move))
		return

//	if (locate(/obj/movable, src))
//		return 1

	if ((istype(A, /mob/) && src.x > 2 && src.x < (world.maxx - 1) && src.y > 2 && src.y < (world.maxy-1)))
		var/mob/M = A
		if ((!( M.handcuffed) && M.canmove))
			var/prob_slip = 5
			var/mag_eq = 0
			if(istype(M, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				if(istype(H.shoes, /obj/item/clothing/shoes/magboots) && H.shoes.flags&NOSLIP)
					mag_eq = 1

			if (locate(/obj/grille, oview(1, M)) || locate(/obj/lattice, oview(1, M)) )
				if(mag_eq)
					prob_slip = 0
				else
					if (!( M.l_hand ))
						prob_slip -= 2
					else if (M.l_hand.w_class <= 2)
						prob_slip -= 1

					if (!( M.r_hand ))
						prob_slip -= 2
					else if (M.r_hand.w_class <= 2)
						prob_slip -= 1
			else if (locate(/turf/unsimulated, oview(1, M)) || locate(/turf/simulated, oview(1, M)))
				if(mag_eq)
					prob_slip = 0
				else
					if (!( M.l_hand ))
						prob_slip -= 1
					else if (M.l_hand.w_class <= 2)
						prob_slip -= 0.5

					if (!( M.r_hand ))
						prob_slip -= 1
					else if (M.r_hand.w_class <= 2)
						prob_slip -= 0.5
			prob_slip = round(prob_slip)

			if (prob_slip < 5) //next to something, but they might slip off
				if (prob(prob_slip) )
					M << "\blue <B>You slipped!</B>"
					M.inertia_dir = M.last_move
					step(M, M.inertia_dir)
					return
				else
					M.inertia_dir = 0 //no inertia
			else //not by a wall or anything, they just keep going
				spawn(5)
					if ((A && !( A.anchored ) && A.loc == src))
						if(M.inertia_dir) //they keep moving the same direction
							step(M, M.inertia_dir)
						else
							M.inertia_dir = M.last_move
							step(M, M.inertia_dir)
		else //can't move, they just keep going (COPY PASTED CODE WOO)
			spawn(5)
				if ((A && !( A.anchored ) && A.loc == src))
					if(M.inertia_dir) //they keep moving the same direction
						step(M, M.inertia_dir)
					else
						M.inertia_dir = M.last_move
						step(M, M.inertia_dir) //TODO: DEFERRED
	if(ticker && ticker.mode)
		if(ticker.mode.name == "nuclear emergency")
			return

		else if(ticker.mode.name == "extended"||ticker.mode.name == "sandbox")

			var/cur_x
			var/cur_y
			var/next_x
			var/next_y
			var/target_z
			var/list/y_arr

			if(src.x <= 1)
				if(istype(A, /obj/meteor)||istype(A, /obj/space_dust))
					del(A)
					return

				var/list/cur_pos = src.get_global_map_pos()
				if(!cur_pos) return
				cur_x = cur_pos["x"]
				cur_y = cur_pos["y"]
				next_x = (--cur_x||global_map.len)
				y_arr = global_map[next_x]
				target_z = y_arr[cur_y]
/*
				//debug
				world << "Src.z = [src.z] in global map X = [cur_x], Y = [cur_y]"
				world << "Target Z = [target_z]"
				world << "Next X = [next_x]"
				//debug
*/
				if(target_z)
					A.z = target_z
					A.x = world.maxx - 2
					spawn (0)
						if ((A && A.loc))
							A.loc.Entered(A)
			else if (src.x >= world.maxx)
				if(istype(A, /obj/meteor))
					del(A)
					return

				var/list/cur_pos = src.get_global_map_pos()
				if(!cur_pos) return
				cur_x = cur_pos["x"]
				cur_y = cur_pos["y"]
				next_x = (++cur_x > global_map.len ? 1 : cur_x)
				y_arr = global_map[next_x]
				target_z = y_arr[cur_y]
/*
				//debug
				world << "Src.z = [src.z] in global map X = [cur_x], Y = [cur_y]"
				world << "Target Z = [target_z]"
				world << "Next X = [next_x]"
				//debug
*/
				if(target_z)
					A.z = target_z
					A.x = 3
					spawn (0)
						if ((A && A.loc))
							A.loc.Entered(A)
			else if (src.y <= 1)
				if(istype(A, /obj/meteor))
					del(A)
					return
				var/list/cur_pos = src.get_global_map_pos()
				if(!cur_pos) return
				cur_x = cur_pos["x"]
				cur_y = cur_pos["y"]
				y_arr = global_map[cur_x]
				next_y = (--cur_y||y_arr.len)
				target_z = y_arr[next_y]
/*
				//debug
				world << "Src.z = [src.z] in global map X = [cur_x], Y = [cur_y]"
				world << "Next Y = [next_y]"
				world << "Target Z = [target_z]"
				//debug
*/
				if(target_z)
					A.z = target_z
					A.y = world.maxy - 2
					spawn (0)
						if ((A && A.loc))
							A.loc.Entered(A)

			else if (src.y >= world.maxy)
				if(istype(A, /obj/meteor)||istype(A, /obj/space_dust))
					del(A)
					return
				var/list/cur_pos = src.get_global_map_pos()
				if(!cur_pos) return
				cur_x = cur_pos["x"]
				cur_y = cur_pos["y"]
				y_arr = global_map[cur_x]
				next_y = (++cur_y > y_arr.len ? 1 : cur_y)
				target_z = y_arr[next_y]
/*
				//debug
				world << "Src.z = [src.z] in global map X = [cur_x], Y = [cur_y]"
				world << "Next Y = [next_y]"
				world << "Target Z = [target_z]"
				//debug
*/
				if(target_z)
					A.z = target_z
					A.y = 3
					spawn (0)
						if ((A && A.loc))
							A.loc.Entered(A)
			return


		else

			if (src.x <= 2)
				if(istype(A, /obj/meteor)||istype(A, /obj/space_dust))
					del(A)
					return

				var/move_to_z_str = pickweight(accessable_z_levels)

				var/move_to_z = text2num(move_to_z_str)

				if(!move_to_z)
					return

				A.z = move_to_z
				A.x = world.maxx - 2
				spawn (0)
					if ((A && A.loc))
						A.loc.Entered(A)
			else if (A.x >= (world.maxx - 1))
				if(istype(A, /obj/meteor)||istype(A, /obj/space_dust))
					del(A)
					return

				var/move_to_z_str = pickweight(accessable_z_levels)

				var/move_to_z = text2num(move_to_z_str)

				if(!move_to_z)
					return

				A.z = move_to_z
				A.x = 3
				spawn (0)
					if ((A && A.loc))
						A.loc.Entered(A)
			else if (src.y <= 2)
				if(istype(A, /obj/meteor)||istype(A, /obj/space_dust))
					del(A)
					return

				var/move_to_z_str = pickweight(accessable_z_levels)

				var/move_to_z = text2num(move_to_z_str)

				if(!move_to_z)
					return

				A.z = move_to_z
				A.y = world.maxy - 2
				spawn (0)
					if ((A && A.loc))
						A.loc.Entered(A)

			else if (A.y >= (world.maxy - 1))
				if(istype(A, /obj/meteor)||istype(A, /obj/space_dust))
					del(A)
					return

				var/move_to_z_str = pickweight(accessable_z_levels)

				var/move_to_z = text2num(move_to_z_str)

				if(!move_to_z)
					return

				A.z = move_to_z
				A.y = 3
				spawn (0)
					if ((A && A.loc))
						A.loc.Entered(A)
