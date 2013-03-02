
/obj/machinery/computer/aiupload
	name = "AI Upload"
	desc = "It is said that you can upload silly laws to AI's with this."
	icon_state = "command"
	circuit = "/obj/item/weapon/circuitboard/aiupload"
	var/mob/living/silicon/ai/current = null
	var/opened = 0

/obj/machinery/computer/aiupload/verb/AccessInternals()
	set category = "Object"
	set name = "Access Computer's Internals"
	set src in oview(1)
	if(get_dist(src, usr) > 1 || usr.restrained() || usr.lying || usr.stat || istype(usr, /mob/living/silicon))
		return

	opened = !opened
	if(opened)
		usr << "\blue The access panel is now open."
	else
		usr << "\blue The access panel is now closed."
	return


/obj/machinery/computer/aiupload/attackby(obj/item/weapon/O as obj, mob/user as mob)
	if(istype(O, /obj/item/aiModule))
		var/obj/item/aiModule/M = O
		M.install(src)
	else
		..()

/obj/machinery/computer/aiupload/attack_hand(var/mob/user as mob)
	if(src.stat & NOPOWER)
		usr << "The upload computer has no power!"
		return
	if(src.stat & BROKEN)
		usr << "The upload computer is broken!"
		return

	src.current = activeais()

	if (!src.current)
		usr << "No active AIs detected."
	else
		usr << "[src.current.name] selected for law changes."
