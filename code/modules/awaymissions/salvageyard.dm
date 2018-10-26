//This file is attempting to define shit that will enable the salvage yard to generate itself instead of pure hardmapping

//The code I think is used for random space ruin generation is in modules/awaymissions/zlevel.dm. I'll try and replicate it in a way that fits salvage yard.
//The file that actually CALLS these methods is none other than master_controller.dm (which I will have to edit, fuk)


//begin attempt to make this hapen

//THIS LOOKS FOR A DATUM LIST SIMILAR TO THE ONE IN ruins/space.dm! KEEP THIS IN MIND NIGGER ASDF
//let's build that first and move it if need be mkay

/datum/map_template/junk //SHIT. I NEED THIS FIRST FUUCK
	name = null
	var/id = null // For blacklisting purposes, all ruins need an id
	var/description = "BIG WOBBLY COCKS!"

	var/cost = null
	var/allow_duplicates = FALSE //A bit boring, don't you think? You can always explicitly allow it on a ruin definition THIS IS THE SAME COMMENT FROM WHERE I STOLE IT FROM AREN'T I A SHITLOARDE

	var/prefix = null
	var/suffix = null

/datum/map_template/junk/New()
	if(!name && id)
		name = id

	mappath = prefix + suffix
	..(path = mappath)


/* reference code
/datum/map_template/ruin/space
	prefix = "_maps/map_files/RandomRuins/SpaceRuins/"
	cost = 1

/datum/map_template/ruin/space/zoo
	id = "zoo"
	suffix = "abandonedzoo.dmm"
	name = "Biological Storage Facility"
	description = "In case society crumbles, we will be able to restore our \
		zoos to working order with the breeding stock kept in these 100% \
		secure and unbreachable storage facilities. At no point has anything \
		escaped. That's our story, and we're sticking to it."
	cost = 2
*/

//the big ones
/datum/map_template/junk/normal
	prefix = "_maps/map_files/templates/salvageyard/normal/"
	cost = 1

/datum/map_template/junk/normal/n1
	id = "fragment"
	suffix = "n1.dmm"
	name = "Mining Fragment"
	description = "This must have been a break off a mining asteroid."

/datum/map_template/junk/normal/n2
	id = "blast"
	suffix = "n2.dmm"
	name = "Blasted"
	description = "Probably an explosives mishap, given the residue."

/datum/map_template/junk/normal/n3
	id = "hivecrash"
	suffix = "n3.dmm"
	name = "Hive Crash"
	description = "Hivebot signals are painfully evident here."

/datum/map_template/junk/normal/n4
	id = "poot"
	suffix = "n4.dmm"
	name = "LZ's Spacetime-rending Poot"
	description = "Behold, a Beligerant BackBlast Begotten \
	By the Bowels of LZ's Butt, Bereft of logic! Yeah, \
	Spacetime is horribly fucked up somehow."

//& small ones
/datum/map_template/junk/smol
	prefix = "_maps/map_files/templates/salvageyard/smol/"
	cost = 1

/datum/map_template/junk/smol/s01
	id = "tmelt"
	suffix = "s01.dmm"
	name = "Melted Station Fragment"
	description = "A few melterlings lurk around this old structure."

/datum/map_template/junk/smol/s02
	id = "jank1"
	suffix = "s02.dmm"
	name = "Jank 1"
	description = "might be something useful there. who knows"
	//allow_duplicates = TRUE //NEVERMIND

/datum/map_template/junk/smol/s03
	id = "jank2"
	suffix = "s03.dmm"
	name = "Jank 2"
	description = "doesn't seem worth it, really."
	//allow_duplicates = TRUE //NEVERMIND

/datum/map_template/junk/smol/s04
	id = "jank3"
	suffix = "s04.dmm"
	name = "Jank 3"
	description = "Maybe that meteoroid snagged something useful..?"

/datum/map_template/junk/smol/s05
	id = "syndiebust"
	suffix = "s05.dmm"
	name = "Busted Syndicate vessel"
	description = "Looks like a syndicate ship accident. \
	Probably worth looting to some extent! \
	just don't let shitcurity know."

/datum/map_template/junk/smol/s06
	id = "nmelt"
	suffix = "s06.dmm"
	name = "Melted Station Chunk"
	description = "An unsettling amount of melterlings rode this in."

/datum/map_template/junk/smol/s07
	id = "honkfuck"
	suffix = "s07.dmm"
	name = "Pod Honk Fail"
	description = "Does this even need a description?"

/datum/map_template/junk/smol/s08
	id = "spessturd"
	suffix = "s08.dmm"
	name = "Space Turd"
	description = "Kinda what it looks like IMO."
	allow_duplicates = TRUE

/datum/map_template/junk/smol/s09
	id = "vaster"
	suffix = "s09.dmm"
	name = "Asteroid with some actual value"
	description = "I think a diver would appreciate that."

//these are basic shit to fall back on (alongside a few others defined above)
/datum/map_template/junk/smol/s10
	id = "enoir1"
	suffix = "s10.dmm"
	name = "Iron Asteroid S"
	description = "Some value within"
	allow_duplicates = TRUE
/datum/map_template/junk/smol/s11
	id = "enoir2"
	suffix = "s11.dmm"
	name = "Iron Asteroid E"
	description = "Some value within"
	allow_duplicates = TRUE
/datum/map_template/junk/smol/s12
	id = "enoir3"
	suffix = "s12.dmm"
	name = "Iron Asteroid N"
	description = "Some value within"
	allow_duplicates = TRUE
/datum/map_template/junk/smol/s13
	id = "enoir4"
	suffix = "s13.dmm"
	name = "Iron Asteroid W"
	description = "Some value within"
	allow_duplicates = TRUE

//^That list is incomplete.

//now for the declaration thing I think we need?
var/list/datum/map_template/salvage_yard_Mtemplates = list()
var/list/datum/map_template/salvage_yard_Stemplates = list()


//building the template list I think?
/proc/preloadSYTemplates()
	// Blacklist code from the stolen block that I may or may not rework to fit here if we decide to run a salvage yard blacklist and stuff lolololfgt
	var/list/banned
	if(fexists("config/spaceRuinBlacklist.txt"))
		banned = generateMapList("config/spaceRuinBlacklist.txt")
	else
		banned = generateMapList("config/example/spaceRuinBlacklist.txt")
	//none of that should do anything in this method.
	for(var/item in subtypesof(/datum/map_template/junk))
		var/datum/map_template/junk/junk_type = item
		// screen out the abstract subtypes
		if(!initial(junk_type.id))
			continue
		var/datum/map_template/junk/J = new junk_type()

		if(banned.Find(J.mappath))
			continue

		map_templates[J.name] = J
		ruins_templates[J.name] = J //Is this line needed at all for this purpose?

		if(istype(J, /datum/map_template/junk/normal))
			salvage_yard_Mtemplates[J.name] = J
		if(istype(J, /datum/map_template/junk/smol))
			salvage_yard_Stemplates[J.name] = J



//first the larger ones
/proc/seedMids(z_level = 1, budget = 0, whitelist = /area/salvage/yard/genarea, list/potentialMids = salvage_yard_Mtemplates)
//	var/overall_sanity = 100 There ain't no sanity clause!
	var/list/ruins = potentialMids.Copy()
	var/initialbudget = budget
	var/watch = start_watch()
	var/list/rectangles = GetRectangles(whitelist, z_level)
	while(budget > 0)
		if(!ruins.len || !rectangles.len)
			break
		// Pick a ruin
		var/list/validruins = list()
		var/datum/rectangle/R = pick(rectangles)
		for(var/S in ruins)
			var/datum/map_template/ruin/P = ruins[S]
			if(P.cost > budget || !P.suffix)
				ruins -= S
				continue
			else if(P.width > R.x || P.height > R.y)
				continue
			else
				validruins += P

		if(!validruins.len)
			rectangles -= R
			R.Destroy()
			continue

		var/datum/map_template/ruin/ruin = pick(validruins)

//		var/sanity = 100


		var/turf/T = locate(rand(R.offx, R.offx + (R.x - ruin.width)), rand(R.offy, R.offy + (R.y - ruin.height)), z_level)
		if(ruin.load(T))
			log_to_dd("   \"[ruin.name]\" loaded to the salvage yard in [stop_watch(watch)]s at ([T.x], [T.y], [T.z]).")
		else
			log_to_dd("   \"[ruin.name]\" failed to load at ([T.x], [T.y], [T.z]).")
		var/datum/rectangle/ruinrec = new /datum/rectangle(ruin.width, ruin.height, T.x, T.y)
		var/list/remainders = new /list()
		for(var/datum/rectangle/O in rectangles)
			var/datum/rectangle/O_2 = ruinrec.overlaps_with(O)
			var/list/O_3
			if(O_2)
				O_3 = O.get_rectangle_remainders(O_2)
				if(O_3)
					remainders += O_3
					rectangles -= O
					O.Destroy()
		if(R)
			rectangles -= R
			R.Destroy()
		if(remainders.len)
			rectangles += remainders
			remainders.Cut()

/*		var/valid = 1

		for(var/turf/check in ruin.get_affected_turfs(T,1))
			var/area/new_area = get_area(check)
			if(!(istype(new_area, whitelist)))
				valid = 0
				break

		if(!valid)
			continue*/


//			var/obj/effect/Mjunk_loader/R = new /obj/effect/Mjunk_loader(T) This is Pingas Melter levels of borked.
//			R.Load(ruins,ruin) //DENNIS
		budget -= ruin.cost
		if(!ruin.allow_duplicates)
			ruins -= ruin.name
	if(initialbudget == budget) //Kill me
		log_to_dd("  No large salvages loaded.")
	if(rectangles.len)					//Cleanup
		for(var/datum/rectangle/rm in rectangles)
			rm.Destroy()


//then the smaller ones
/proc/seedSmols(z_level = 1, budget = 0, whitelist = /area/salvage/yard/genarea, list/potentialSmols = salvage_yard_Stemplates)
	var/overall_sanity = 100
	var/ruins = potentialSmols.Copy()
	var/initialbudget = budget
	var/watch = start_watch()
	//same shit noted as above
	while(budget > 0 && overall_sanity > 0)
		// Pick a ruin
		var/datum/map_template/ruin/ruin = ruins[pick(ruins)]
		// Can we afford it
		if(ruin.cost > budget)
			overall_sanity--
			continue
		// If so, try to place it
		var/sanity = 100
		// And if we can't fit it anywhere, give up, try again

		while(sanity > 0)
			sanity--
			var/turf/T = locate(rand(10, world.maxx - 10), rand(10, world.maxy - 10), z_level)
			var/valid = 1

			for(var/turf/check in ruin.get_affected_turfs(T,1))
				var/area/new_area = get_area(check)
				if(!(istype(new_area, whitelist)))
					valid = 0
					break

			if(!valid)
				continue

			log_to_dd("   \"[ruin.name]\" loaded to the salvage yard in [stop_watch(watch)]s at ([T.x], [T.y], [T.z]).")

			var/obj/effect/Sjunk_loader/R = new /obj/effect/Sjunk_loader(T)
			R.Load(ruins,ruin) //DENNIS
			budget -= ruin.cost
			if(!ruin.allow_duplicates)
				ruins -= ruin.name
			break


	if(initialbudget == budget) //Kill me
		log_to_dd("  No small salvages loaded.")


//needed pseudo-objects for the above loops, evidently
/obj/effect/Sjunk_loader
	name = "random small junk"
	desc = "If you got lucky enough to see this..."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "syndballoon"
	invisibility = 0
/obj/effect/Mjunk_loader
	name = "random junk"
	desc = "If you got lucky enough to see this..."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "syndballoon"
	invisibility = 0


//this next thing I think is the method it tries to call above at DENNIS
/obj/effect/Mjunk_loader/proc/Load(list/potentialRuins = salvage_yard_Mtemplates, datum/map_template/template = null)
	var/list/possible_ruins = list()
	for(var/A in potentialRuins)
		var/datum/map_template/T = potentialRuins[A]
		if(!T.loaded)
			possible_ruins += T
	if(!template && possible_ruins.len)
		template = safepick(possible_ruins)
	if(!template)
		return 0
	var/turf/central_turf = get_turf(src)
	for(var/i in template.get_affected_turfs(central_turf, 1))
		var/turf/T = i
		for(var/mob/living/simple_animal/monster in T)
			qdel(monster)
		for(var/obj/structure/flora/ash/plant in T)
			qdel(plant)
	template.load(get_turf(src),centered = 1)
	template.loaded++
	var/datum/map_template/ruin = template
	if(istype(ruin))
		new /obj/effect/landmark/ruin(central_turf, ruin)
	qdel(src)
	return 1
/obj/effect/Sjunk_loader/proc/Load(list/potentialRuins = salvage_yard_Stemplates, datum/map_template/template = null)
	var/list/possible_ruins = list()
	for(var/A in potentialRuins)
		var/datum/map_template/T = potentialRuins[A]
		if(!T.loaded)
			possible_ruins += T
	if(!template && possible_ruins.len)
		template = safepick(possible_ruins)
	if(!template)
		return 0
	var/turf/central_turf = get_turf(src)
	for(var/i in template.get_affected_turfs(central_turf, 1))
		var/turf/T = i
		for(var/mob/living/simple_animal/monster in T)
			qdel(monster)
		for(var/obj/structure/flora/ash/plant in T)
			qdel(plant)
	template.load(get_turf(src),centered = 1)
	template.loaded++
	var/datum/map_template/ruin = template
	if(istype(ruin))
		new /obj/effect/landmark/ruin(central_turf, ruin)
	qdel(src)
	return 1
//LETS HOPE THIS WORKS