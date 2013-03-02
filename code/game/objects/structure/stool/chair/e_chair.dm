
/obj/structure/stool/chair/e_chair
	name = "electrified chair"
	desc = "Looks absolutely SHOCKING!"
	icon_state = "e_chair0"
	var
		atom/movable/overlay/overl = null
		on = 0.0
		obj/item/assembly/shock_kit/part1 = null
		last_time = 1.0

	New()
		src.overl = new /atom/movable/overlay( src.loc )
		src.overl.icon = 'objects.dmi'
		src.overl.icon_state = "e_chairo0"
		src.overl.layer = 5
		src.overl.name = "electrified chair"
		src.overl.master = src
		return

	Del()
		//src.overl = null
		del(src.overl)
		..()
		return

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W, /obj/item/weapon/wrench))
			var/obj/structure/stool/chair/C = new /obj/structure/stool/chair( src.loc )
			playsound(src.loc, 'Ratchet.ogg', 50, 1)
			C.dir = src.dir
			src.part1.loc = src.loc
			src.part1.master = null
			src.part1 = null
			//SN src = null
			del(src)
			return
		return

	proc
		shock()
			if (!( src.on ))
				return
			if ( (src.last_time + 50) > world.time)
				return
			src.last_time = world.time
			// special power handling
			var/area/A = get_area(src)
			if(!isarea(A))
				return
			if(!A.powered(EQUIP))
				return
			A.use_power(EQUIP, 5000)
			var/light = A.power_light
			A.updateicon()
			flick("e_chairs", src)
			flick("e_chairos", src.overl)
			var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
			s.set_up(12, 1, src)
			s.start()
			for(var/mob/living/M in src.loc)
				M.burn_skin(85)
				M << "\red <B>You feel a deep shock course through your body!</B>"
				sleep(1)
				M.burn_skin(85)
				if(M.stunned < 600)
					M.stunned = 600
			for(var/mob/M in hearers(src, null))
				M.show_message("\red The electric chair went off!.", 3, "\red You hear a deep sharp shock.", 2)
			A.power_light = light
			A.updateicon()
			return

	verb/toggle_power()
		set name = "Toggle Electric Chair"
		set category = "Object"
		set src in oview(1)

		if ((usr.stat || usr.restrained() || !( usr.canmove ) || usr.lying))
			return
		src.on = !( src.on )
		src.icon_state = text("e_chair[]", src.on)
		src.overl.icon_state = text("e_chairo[]", src.on)
		return
