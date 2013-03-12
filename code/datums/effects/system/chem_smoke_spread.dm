
/datum/effects/system/chem_smoke_spread
	var/number = 3
	var/cardinals = 0
	var/turf/location
	var/atom/holder
	var/total_smoke = 0 // To stop it being spammed and lagging!
	var/direction
	var/obj/chemholder
	New()
		..()
		chemholder = new/obj()
		var/datum/reagents/R = new/datum/reagents(500)
		chemholder.reagents = R
		R.my_atom = chemholder

/datum/effects/system/chem_smoke_spread/proc/set_up(var/datum/reagents/carry = null, n = 5, c = 0, loca, direct)
	if(n > 20)
		n = 20
	number = n
	cardinals = c
	carry.copy_to(chemholder, carry.total_volume)

	if(istype(loca, /turf/))
		location = loca
	else
		location = get_turf(loca)
	if(direct)
		direction = direct


/datum/effects/system/chem_smoke_spread/proc/attach(atom/atom)
	holder = atom

/datum/effects/system/chem_smoke_spread/proc/start()
	var/i = 0

	// Calculate the smokes' color
	var/list/rgbcolor = list(0,0,0)
	var/finalcolor
	for(var/datum/reagent/re in chemholder.reagents.reagent_list)
		if(!finalcolor)
			rgbcolor = GetColors(re.color)
			finalcolor = re.color
		else
			var/newcolor[3]
			var/prergbcolor[3]
			prergbcolor = rgbcolor
			newcolor = GetColors(re.color)

			rgbcolor[1] = (prergbcolor[1]+newcolor[1])/2
			rgbcolor[2] = (prergbcolor[2]+newcolor[2])/2
			rgbcolor[3] = (prergbcolor[3]+newcolor[3])/2

			finalcolor = rgb(rgbcolor[1], rgbcolor[2], rgbcolor[3])

	if(finalcolor)
		finalcolor = rgb(rgbcolor[1], rgbcolor[2], rgbcolor[3]) // slightly darker color

	for(i=0, i<src.number, i++)
		if(src.total_smoke > 20)
			return
		spawn(0)
			if(holder)
				src.location = get_turf(holder)
			var/obj/effects/chem_smoke/smoke = new /obj/effects/chem_smoke(src.location)
			src.total_smoke++
			var/direction = src.direction
			if(!direction)
				if(src.cardinals)
					direction = pick(cardinal)
				else
					direction = pick(alldirs)

			if(chemholder.reagents.total_volume != 1) // can't split 1 very well
				chemholder.reagents.copy_to(smoke, chemholder.reagents.total_volume / number) // copy reagents to each smoke, divide evenly

			if(finalcolor)
				smoke.icon += finalcolor // give the smoke color, if it has any to begin with
			else
				// if no color, just use the old smoke icon
				smoke.icon = '96x96.dmi'
				smoke.icon_state = "smoke"

			for(i=0, i<pick(0,1,1,1,2,2,2,3), i++)
				sleep(10)
				step(smoke,direction)
			spawn(150+rand(10,30))
				del(smoke)
				src.total_smoke--
