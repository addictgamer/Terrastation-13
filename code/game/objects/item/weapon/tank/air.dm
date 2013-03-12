
/obj/item/weapon/tank/air
	name = "Gas Tank (Air Mix)"
	desc = "Mixed anyone?"
	icon_state = "oxygen"

	New()
		..()
		src.air_contents.oxygen = (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
		src.air_contents.nitrogen = (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
		return

	examine()
		set src in usr
		..()
		if(air_contents.oxygen < 1)
			usr << text("\red <B>The meter on the tank indicates you are almost out of air!</B>")
			playsound(usr, 'alert.ogg', 50, 1)
