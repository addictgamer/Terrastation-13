
/obj/overlay/beam//Not actually a projectile, just an effect.
	name="beam"
	icon='beam.dmi'
	icon_state="b_beam"
	var/tmp/atom/BeamSource
	New()
		..()
		spawn(10) del src
