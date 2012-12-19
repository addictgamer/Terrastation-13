
/obj/item/weapon/reagent_containers/glass/large
	name = "large reagent glass"
	desc = "A large reagent glass. Can hold up to 100 units."
	icon = 'chemical.dmi'
	icon_state = "beakerlarge"
	item_state = "beaker"
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,30,50)
	flags = FPRINT | TABLEPASS | OPENCONTAINER


	pickup(mob/user)
		on_reagent_change(user)

	dropped(mob/user)
		on_reagent_change()

	on_reagent_change(var/mob/user)
		overlays = null

		if(reagents.total_volume)

			var/obj/overlay = new/obj
			overlay.icon = 'beaker2.dmi'
			var/percent = round((reagents.total_volume / volume) * 100)
			switch(percent)
				if(0 to 9)		overlay.icon_state = "-10"
				if(10 to 24) 	overlay.icon_state = "10"
				if(25 to 49)	overlay.icon_state = "25"
				if(50 to 74)	overlay.icon_state = "50"
				if(75 to 79)	overlay.icon_state = "75"
				if(80 to 90)	overlay.icon_state = "80"
				if(91 to 100)	overlay.icon_state = "100"

			var/list/rgbcolor = list(0,0,0)
			var/finalcolor
			for(var/datum/reagent/re in reagents.reagent_list) // natural color mixing bullshit/algorithm
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
					// This isn't a perfect color mixing system, the more reagents that are inside,
					// the darker it gets until it becomes absolutely pitch black! I dunno, maybe
					// that's pretty realistic? I don't do a whole lot of color-mixing anyway.
					// If you add brighter colors to it it'll eventually get lighter, though.

			overlay.icon += finalcolor
			if(user || !istype(src.loc, /turf))
				overlay.layer = 30
			overlays += overlay
