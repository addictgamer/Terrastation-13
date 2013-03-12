
/obj/effects/chem_smoke
	name = "smoke"
	opacity = 1
	anchored = 0.0
	mouse_opacity = 0
	icon = 'chemsmoke.dmi'
	pixel_x = -32
	pixel_y = -32
	var
		amount = 6.0

	New()
		..()
		var/datum/reagents/R = new/datum/reagents(500)
		reagents = R
		R.my_atom = src
		spawn (200+rand(10,30))
			del(src)
		return

	Move()
		..()
		for(var/atom/A in view(1, src))
			reagents.reaction(A)
		return

	HasEntered(mob/living/carbon/M as mob )
		..()
		reagents.reaction(M)
		return
