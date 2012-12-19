
/obj/falserwall
	name = "r wall"
	desc = "A huge chunk of reinforced metal used to seperate rooms."
	icon = 'walls.dmi'
	icon_state = "r_wall"
	density = 1
	opacity = 1
	anchored = 1

/obj/falserwall/attack_hand(mob/user as mob)
	if(density)
		// Open wall
		icon_state = "frwall_open"
		flick("frwall_opening", src)
		sleep(15)
		src.density = 0
		src.sd_SetOpacity(0)
		var/turf/T = src.loc
		T.sd_LumReset()
	else
		icon_state = "r_wall"
		flick("frwall_closing", src)
		sleep(15)
		src.density = 1
		src.sd_SetOpacity(1)
		var/turf/T = src.loc
		//T.sd_LumUpdate()
		src.relativewall()
		T.sd_LumReset()

/obj/falsewall/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/screwdriver))
		var/turf/T = get_turf(src)
		user.visible_message("[user] tightens some bolts on the r wall.", "You tighten the bolts on the r wall.")
		T.ReplaceWithWall() //Intentionally makes a regular wall instead of an r-wall (no cheap r-walls for you).
		del(src)
