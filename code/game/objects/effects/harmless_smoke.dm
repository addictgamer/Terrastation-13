
/////////////////////////////////////////////
//// SMOKE SYSTEMS
// direct can be optinally added when set_up, to make the smoke always travel in one direction
// in case you wanted a vent to always smoke north for example
/////////////////////////////////////////////

/obj/effects/harmless_smoke
	name = "smoke"
	icon_state = "smoke"
	icon = '96x96.dmi'
	opacity = 1
	anchored = 0.0
	mouse_opacity = 0
	//Remove this bit to use the old smoke
	pixel_x = -32
	pixel_y = -32
	var
		amount = 6.0

	New()
		..()
		spawn (100)
			del(src)
		return

	Move()
		..()
		return
