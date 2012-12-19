
/obj/machinery/computer/crew
	name = "Crew monitoring computer"
	icon_state = "crew"
	use_power = 1
	idle_power_usage = 250
	active_power_usage = 500
	circuit = "/obj/item/weapon/circuitboard/crew"
	tracked =	list(  )

/obj/machinery/computer/crew/New()
	tracked = list()
	..()
