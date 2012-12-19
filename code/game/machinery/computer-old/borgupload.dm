
/obj/machinery/computer/borgupload
	name = "Cyborg Upload"
	desc = "Used for uploading responsible laws to Cyborg. Right..."
	icon_state = "command"
	circuit = "/obj/item/weapon/circuitboard/borgupload"
	var/mob/living/silicon/robot/current = null

/obj/machinery/computer/borgupload/attackby(obj/item/weapon/aiModule/module as obj, mob/user as mob)
	if(istype(module, /obj/item/weapon/aiModule))
		module.install(src)
	else
		return ..()

/obj/machinery/computer/borgupload/attack_hand(var/mob/user as mob)
	if(src.stat & NOPOWER)
		usr << "The upload computer has no power!"
		return
	if(src.stat & BROKEN)
		usr << "The upload computer is broken!"
		return

	src.current = freeborg()

	if (!src.current)
		usr << "No free cyborgs detected."
	else
		usr << "[src.current.name] selected for law changes."
