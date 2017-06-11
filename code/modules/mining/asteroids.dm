/* This is custom Terraform minable turfs; which I will use for spessdiving stuff and for xenoarch.
   This uses the old asteroid turfs from waaaaay back when. ATM I'm only adding the blank one and the iron one.
   The silicon and facehugger ones idgaf about right now. .....also probably not sure how to do it. --LZ*/


/turf/simulated/mineral/asteroid //Wall
	name = "asteroid"
	icon = 'icons/turf/oldwalls.dmi'
	icon_state = "asteroid"
	hidden = 0


/turf/simulated/mineral/iron/asteroid //iron wall
	name = "asteroid"
	icon = 'icons/turf/oldwalls.dmi'
	icon_state = "asteroid_i"

//this stuff below technically isn't minable what even the fuck am I thinking amirite
/turf/unsimulated/wall/fakemineral //impenetrable rock wall
	name = "solid rock"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock"
	desc = "This rock looks WAY too dense to mine through."

/turf/unsimulated/wall/fakemineral/hz_border //specifically for hazard zone border
	icon = 'icons/turf/oldwalls.dmi' //this should turn the rock red if the code handles this logically
	//because you know
	//the oldwalls.dmi file has an iconstate of the same name
	//and everything should inherit
	//why am I still typing
	//pignut