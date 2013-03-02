
/obj/decal/cleanable/greenglow
	name = "green glow"
	desc = "Eerie. This makes you feel creepy."
	layer = 2
	icon = 'effects.dmi'
	icon_state = "greenglow"

	New()
		..()
		sd_SetLuminosity(1)
		spawn(1200)		// 2 minutes
			del(src)
