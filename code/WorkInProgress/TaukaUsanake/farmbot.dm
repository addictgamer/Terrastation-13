
/obj/machinery/bot/farmbot
	name = "Farmbot"
	desc = "A robot that is able to do most hydroponic farming tasks."
	icon = 'aibots.dmi'
	icon_state = "farmbot0"
	layer = 5.0
	density = 1
	anchored = 0
	//weight = 1.0E7
	health = 50
	maxhealth = 50
	var
		locked = 1
		screwloose = 0
		oddbutton = 0
		panelopen = 0

	New()
		..()
		src.get_targets()
		src.icon_state = "farmbot[src.on]"

	turn_on()
		. = ..()
		src.icon_state = "farmbot[src.on]"
		src.updateUsrDialog()

	turn_off()
		..()
		src.target = null
		src.oldtarget = null
		src.oldloc = null
		src.icon_state = "farmbot[src.on]"
		src.path = new()
		src.updateUsrDialog()

	Emag(mob/user as mob)
		..()
		if(user) user << "The [src] buzzes and beeps."
		src.oddbutton = 1
		src.screwloose = 1
		src.panelopen = 0
		src.locked = 1
