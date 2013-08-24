
/obj/effects/bad_smoke
	name = "smoke"
	icon_state = "smoke"
	opacity = 1
	anchored = 0.0
	mouse_opacity = 0
	//Remove this bit to use the old smoke
	icon = '96x96.dmi'
	pixel_x = -32
	pixel_y = -32
	var
		amount = 6.0

	New()
		..()
		spawn (200+rand(10,30))
			del(src)
		return

	Move()
		..()
		for(var/mob/living/carbon/M in get_turf(src))
			if (M.internal != null && M.wear_mask && (M.wear_mask.flags & MASKINTERNALS))
			else
				M.drop_item()
				M.oxyloss += 1
				if (M.coughedtime != 1)
					M.coughedtime = 1
					M.emote("cough")
					spawn ( 20 )
						M.coughedtime = 0
		return


	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if (air_group || (height==0)) return 1
		if (istype(mover, /obj/item/projectile/beam))
			var/obj/item/projectile/beam/B = mover
			B.damage = 10//testing, will just hardcode for now
			B.mobdamage = new/list(BRUTE = 0 , BURN = 10, TOX = 0, OXY = 0, CLONE = 0)
		return 1


	HasEntered(mob/living/carbon/M as mob )
		..()
		if (istype(M, /mob/living/carbon))
			if (M.internal != null && M.wear_mask && (M.wear_mask.flags & MASKINTERNALS))
				return
			else
				M.drop_item()
				M.oxyloss += 1
				if (M.coughedtime != 1)
					M.coughedtime = 1
					M.emote("cough")
					spawn ( 20 )
						M.coughedtime = 0
		return
