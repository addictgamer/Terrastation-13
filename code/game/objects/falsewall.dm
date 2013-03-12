
/obj/falsewall
	name = "wall"
	desc = "A huge chunk of metal used to seperate rooms."
	icon = 'walls.dmi'
	icon_state = ""
	density = 1
	opacity = 1
	anchored = 1

	New()
		for(var/turf/simulated/wall/W in range(src,1))
			W.relativewall()
		for(var/obj/falsewall/W in range(src,1))
			W.relativewall()
		..()

	attack_hand(mob/user as mob)
		if(density)
			// Open wall
			icon_state = "fwall_open"
			flick("fwall_opening", src)
			sleep(15)
			src.density = 0
			src.sd_SetOpacity(0)
			var/turf/T = src.loc
			T.sd_LumReset()
		else
			icon_state = "wall"
			flick("fwall_closing", src)
			sleep(15)
			src.density = 1
			src.sd_SetOpacity(1)
			var/turf/T = src.loc
			//T.sd_LumUpdate()
			src.relativewall()
			T.sd_LumReset()

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(istype(W, /obj/item/weapon/screwdriver))
			var/turf/T = get_turf(src)
			user.visible_message("[user] tightens some bolts on the wall.", "You tighten the bolts on the wall.")
			T.ReplaceWithWall()
			del(src)
	/*
		var/turf/T = get_turf(user)
		user << "\blue Now adding plating..."
		sleep(40)
		if (get_turf(user) == T)
			user << "\blue You added the plating!"
			var/turf/Tsrc = get_turf(src)
			Tsrc.ReplaceWithWall()
	*/
