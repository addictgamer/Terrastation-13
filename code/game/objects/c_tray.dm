
/obj/c_tray
	name = "crematorium tray"
	desc = "Apply body before burning."
	icon = 'stationobjs.dmi'
	icon_state = "cremat"
	density = 1
	layer = 2.0
	var/obj/crematorium/connected = null
	anchored = 1.0

	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if (istype(mover, /obj/item/weapon/dummy))
			return 1
		else
			return ..()

	attack_paw(mob/user as mob)
		return src.attack_hand(user)

	attack_hand(mob/user as mob)
		if (src.connected)
			for(var/atom/movable/A as mob|obj in src.loc)
				if (!( A.anchored ))
					A.loc = src.connected
				//Foreach goto(26)
			src.connected.connected = null
			src.connected.update()
			add_fingerprint(user)
			//SN src = null
			del(src)
			return
		return

	MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
		if ((!( istype(O, /atom/movable) ) || O.anchored || get_dist(user, src) > 1 || get_dist(user, O) > 1 || user.contents.Find(src)))
			return
		O.loc = src.loc
		if (user != O)
			for(var/mob/B in viewers(user, 3))
				if ((B.client && !( B.blinded )))
					B << text("\red [] stuffs [] into []!", user, O, src)
				//Foreach goto(99)
		return
