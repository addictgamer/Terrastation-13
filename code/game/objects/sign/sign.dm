
/obj/sign
	desc = "A sign."
	name = "SIGN"
	icon = 'decals.dmi'
	icon_state = "securearea"
	anchored = 1.0
	opacity = 0
	density = 0
	pixel_x = -1
	pixel_y = -1

	ex_act(severity)
		switch(severity)
			if(1.0)
				del(src)
				return
			if(2.0)
				del(src)
				return
			if(3.0)
				return
			else
		return

	blob_act()
		if (prob(75))
			del(src)
			return
		return
