
/obj/item/weapon/tank/jetpack
	name = "Jetpack (Oxygen)"
	desc = "A pack of jets it appears."
	icon_state = "jetpack0"
	var/on = 0.0
	w_class = 4.0
	item_state = "jetpack"
	var/datum/effects/system/ion_trail_follow/ion_trail
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	//volume = 140 //jetpack sould be larger, but then it will never deplete -rastaf0

	New()
		..()
		src.ion_trail = new /datum/effects/system/ion_trail_follow()
		src.ion_trail.set_up(src)
		src.air_contents.oxygen = (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)
		return

	proc
		allow_thrust(num, mob/living/user as mob)
			if (!( src.on ))
				return 0
			if ((num < 0.01 || src.air_contents.total_moles() < num))
				src.ion_trail.stop()
				return 0
			var/datum/gas_mixture/G = src.air_contents.remove(num)
			if (G.oxygen >= 0.01)
				return 1
			if (G.toxins > 0.001)
				if (user)
					var/d = G.toxins / 2
					d = min(abs(user.health + 100), d, 25)
					user.take_organ_damage(0,d)
				return (G.oxygen >= 0.0075 ? 0.5 : 0)
			else
				if (G.oxygen >= 0.0075)
					return 0.5
				else
					return 0
			//G = null
			del(G)
			return

	verb
		toggle()
			set name = "Toggle Jetpack"
			set category = "Object"
			src.on = !( src.on )
			if(src.name == "Void Jetpack (oxygen)")         //Slight change added by me. i didn't make it an if-elseif because some of you might want to add other types of resprited packs :3 -Agouri
				src.icon_state = text("voidjetpack[]", src.on)
			else if(src.name == "Black Jetpack (oxygen)")
				src.icon_state = text("black_jetpack[]", src.on)
			else
				src.icon_state = text("jetpack[]", src.on)
			if(src.on)
				src.ion_trail.start()
			else
				src.ion_trail.stop()
			return
