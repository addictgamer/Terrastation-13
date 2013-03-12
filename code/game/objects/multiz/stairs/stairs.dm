
//Stairs.  var/dir on all four component objects should be the dir you'd walk from top to bottom

/obj/multiz/stairs
	name = "Stairs"
	desc = "Stairs.  You walk up and down them."
	icon_state = "ramptop"

	New()
		icon_state = istop ^ istype(src, /obj/multiz/stairs/active) ? "ramptop" : "rampbottom"
