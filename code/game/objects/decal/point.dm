
/obj/decal/point
	name = "point"
	desc = "It is an arrow hanging in mid-air. There may be a wizard about."
	icon = 'screen1.dmi'
	icon_state = "arrow"
	layer = 16.0

	point()
		set src in oview()
		set hidden = 1
		return
