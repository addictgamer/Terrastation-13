
/datum/effects/system/foam_spread
	var
		amount = 5				// the size of the foam spread.
		turf/location
		list/carried_reagents	// the IDs of reagents present when the foam was mixed
		metal = 0				// 0=foam, 1=metalfoam, 2=ironfoam

	proc
		set_up(amt=5, loca, var/datum/reagents/carry = null, var/metalfoam = 0)
			amount = round(amt/5, 1)
			if(istype(loca, /turf/))
				location = loca
			else
				location = get_turf(loca)
			carried_reagents = list()
			metal = metalfoam
		// bit of a hack here. Foam carries along any reagent also present in the glass it is mixed
		// with (defaults to water if none is present). Rather than actually transfer the reagents,
		// this makes a list of the reagent ids and spawns 1 unit of that reagent when the foam disolves.
			if(carry && !metal)
				for(var/datum/reagent/R in carry.reagent_list)
					carried_reagents += R.id

		start()
			spawn(0)
				var/obj/effects/foam/F = locate() in location
				if(F)
					F.amount += amount
					return

				F = new(src.location, metal)
				F.amount = amount

				if(!metal)			// don't carry other chemicals if a metal foam
					F.create_reagents(10)

					if(carried_reagents)
						for(var/id in carried_reagents)
							F.reagents.add_reagent(id,1)
					else
						F.reagents.add_reagent("water", 1)
