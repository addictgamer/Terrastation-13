
/obj/item/weapon/tank/emergency_oxygen
	name = "Emergency Oxygen Tank"
	desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actualy need it."
	icon_state = "emergency"
	flags = FPRINT | TABLEPASS | ONBELT | CONDUCT
	w_class = 2.0
	force = 4.0
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 3 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)

	New()
		..()
		src.air_contents.oxygen = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
		return

	examine()
		set src in usr
		..()
		if(air_contents.oxygen < 0.4)
			usr << text("\red <B>The meter on the tank indicates you are almost out of air!</B>")
			playsound(usr, 'alert.ogg', 50, 1)
