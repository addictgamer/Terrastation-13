
/obj/structure/ship_landing_beacon
	icon = 'craft.dmi'
	icon_state = "beacon"
	name = "Beacon"
	var
		active = 0

	proc
		deploy()
			if (active)
				return
			src.active = 1
			src.anchored = 1
		deactivate()
			if (!active)
				return
			src.active = 0
			src.anchored = 0
