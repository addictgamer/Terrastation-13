
/obj/item/weapon/tank/anesthetic
	name = "Gas Tank (Sleeping Agent)"
	desc = "Seriously, who uses this anymore?"
	icon_state = "anesthetic"
	item_state = "an_tank"

	New()
		..()
		src.air_contents.oxygen = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * O2STANDARD
		var/datum/gas/sleeping_agent/trace_gas = new()
		trace_gas.moles = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C) * N2STANDARD
		src.air_contents.trace_gases += trace_gas
		return
