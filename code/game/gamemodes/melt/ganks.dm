//shit I stole from other places that adds probably cosmetic stuff that I felt needed be separate from the 3spoopy file

//solarium shit
//aka stuff I ported/stole/wtvr because I was going to put the solarium into the game
/obj/effect/the_sun
	name = "Sol"
	desc = "It's goddamn bright. Should you even be looking at this?"
	icon = 'icons/effects/160x160goon.dmi'
	icon_state = "sun_ripple"
	//layer = EFFECTS_LAYER_UNDER_4 //ok but why tho | also wot
	//luminosity = 5 //wait do I need this
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