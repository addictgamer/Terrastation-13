
/datum/effects/system/reagents_explosion
	var
		amount					// TNT equivalent
		turf/location
		flashing = 0			// does explosion creates flash effect?
		flashing_factor = 0		// factor of how powerful the flash effect relatively to the explosion

	proc
		set_up (amt, loc, flash = 0, flash_fact = 0)
			amount = amt
			if (istype(loc, /turf/))
				location = loc
			else
				location = get_turf(loc)
			flashing = flash
			flashing_factor = flash_fact
			return

		start()
			if (amount <= 2)
				var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
				s.set_up(2, 1, location)
				s.start()
				for(var/mob/M in viewers(5, location))
					M << "\red The solution violently explodes."
				for(var/mob/M in viewers(1, location))
					if (prob (50 * amount))
						M << "\red The explosion knocks you down."
						M.weakened += rand (1, 5)
				return
			else
				var/devastation = -1
				var/heavy = -1
				var/light = -1
				var/flash = -1
				// Clamp all values to MAX_EXPLOSION_RANGE
				if (round(amount/12) > 0)
					devastation = min (MAX_EXPLOSION_RANGE, devastation + round(amount/12))
				if (round(amount/6) > 0)
					heavy = min (MAX_EXPLOSION_RANGE, heavy + round(amount/6))
				if (round(amount/3) > 0)
					light = min (MAX_EXPLOSION_RANGE, light + round(amount/3))
				if (flash && flashing_factor)
					flash += (round(amount/4) * flashing_factor)
				for(var/mob/M in viewers(8, location))
					M << "\red The solution violently explodes."
				explosion(location, devastation, heavy, light, flash)
