
/obj/rift
	icon = 'biomass.dmi'
	icon_state = "rift"
	var
		list/obj/biomass/linkedBiomass = list() //all the biomass patches that have spread from it
		newicon = 1 //DEBUG

	New()
		set background = 1
		..()
		for(var/turf/T in orange(1,src))
			if(!IsValidBiomassLoc(T))
				continue
			var/obj/biomass/starting = new /obj/biomass(T)
			starting.dir = get_dir(src,starting)
			starting.originalRift = src
			linkedBiomass += starting
			spawn(1) //DEBUG
				starting.icon_state = "[newicon]"

	Del()
		for(var/obj/biomass/biomass in linkedBiomass)
			del(biomass)
		..()
