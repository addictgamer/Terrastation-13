//shit I stole from other places that adds probably cosmetic stuff that I felt needed be separate from the 3spoopy file

//glow effects - idea taken from goon
//implemented via niggerriggery and not how they did. Well, obviously not how they did; this codebase is different and shit. It's not the equivalent in our codebase is what I mean.
/obj/effect/decal/glow
	name = "glowy shit"
	desc = "It's glowy."
	light_color = "#111111"
	light_range = 5
	anchored = 1
	opacity = 0
	density = 0
/obj/effect/decal/glow/time //'timewarp' effect - Solid white; the light blue I originally used caused aesthetic issues. >:C
	light_color = "#FFFFFF"
/obj/effect/decal/glow/void //'void' effect - purple as fuk
	light_color = "#8000BA"
/obj/effect/decal/glow/sun //Sol effect: the pre-existing niggerriggery with the Sol object emitting its own light will remain because why not
	light_color = "#FF9933"


//solarium shit - obviously from goon
//aka stuff I ported/stole/wtvr because I was going to put the solarium into the game
//doesn't do anything yet
/obj/effect/the_sun
	name = "Sol"
	desc = "It's goddamn bright. Should you even be looking at this?"
	icon = 'icons/effects/160x160goon.dmi'
	icon_state = "sun_ripple"
	//layer = EFFECTS_LAYER_UNDER_4 //ok but why tho | also wot
	//luminosity = 5 //wait do I need this | just checked; it doesn't appear I do so fuck it
	light_color = "#FF9933"
	light_range = 10

/turf/unsimulated/wall/setpieces
	icon = 'icons/turf/oldwalls.dmi'

/*	bloodwall
		name = "Bloody Wall"
		desc = "Gross."
		icon = 'icons/misc/meatland.dmi'
		icon_state = "bloodwall_1"*/ //don't want this yet

/turf/unsimulated/wall/setpieces/leadwall
	name = "Shielded Wall"
	desc = "Seems pretty sturdy."
	icon_state = "leadwall"

/turf/unsimulated/wall/setpieces/leadwall/gray //unused
	icon_state = "leadwall_gray"

/turf/unsimulated/wall/setpieces/leadwall/white //unused
	name = "Microwave Power Transmitter"
	desc = "The outer shell of some large microwave array thing."
	icon_state = "leadwall_white"

/turf/unsimulated/wall/setpieces/leadwindow
	name = "Shielded Window"
	desc = "Seems pretty sturdy."
	icon_state = "leadwindow_1"
	opacity = 0

/turf/unsimulated/wall/setpieces/leadwindow/gray //unused
	icon_state = "leadwindow_gray_1"

/area/solarium
	name = "Solarium"
	icon_state = "yellow"
	requires_power = 0


////Martian Turf stuff that I stole from goon//////////////
//Full functionality not included; this isn't meant to be destroyed and have a health tracker like it is in goon.
//Not for what I'm gonna use it for, anyway.
/turf/simulated/martian
	name = "martian"
	icon = 'icons/turf/martian.dmi'
	//thermal_conductivity = 0.05 //yeah not using this
	//heat_capacity = 0 //or this

/turf/simulated/martian/floor
	name = "organic floor"
	icon_state = "floor1"

/turf/simulated/martian/wall
	name = "organic wall"
	icon_state = "wall1"
	opacity = 1
	density = 1
	blocks_air = 1
/turf/simulated/martian/wall/angle
	icon_state = "diagonalWall"

//trees - goon gank again
/obj/structure/flora/tree/reg
	icon = 'icons/effects/96x96.dmi'
	icon_state = "tree_1"
	icon_prefix = "tree_"
	wood_yield = 5
	chops_needed = 8