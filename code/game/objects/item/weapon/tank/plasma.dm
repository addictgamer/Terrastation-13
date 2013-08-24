
/obj/item/weapon/tank/plasma
	name = "Gas Tank (BIOHAZARD)"
	desc = "Contains dangerous plasma. Do not inhale."
	icon_state = "plasma"

	New()
		..()
		src.air_contents.toxins = (3*ONE_ATMOSPHERE)*70/(R_IDEAL_GAS_EQUATION*T20C)
		return

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		..()
	// PantsNote: More flamethrower assembly code. WOO!
		if (istype(W, /obj/item/weapon/flamethrower))
			var/obj/item/weapon/flamethrower/F = W
			if ((!F.status)||(F.ptank))	return
			src.master = F
			F.ptank = src
			user.before_take_item(src)
			src.loc = F
		return

	proc
		release()
			var/datum/gas_mixture/removed = air_contents.remove(air_contents.total_moles())
			loc.assume_air(removed)

		ignite()
			var/fuel_moles = air_contents.toxins + air_contents.oxygen/6
			var/strength = 1
			var/turf/ground_zero = get_turf(loc)
			loc = null
			if (air_contents.temperature > (T0C + 400))
				strength = fuel_moles/15
				explosion(ground_zero, strength, strength*2, strength*3, strength*4)
			else if (air_contents.temperature > (T0C + 250))
				strength = fuel_moles/20
				explosion(ground_zero, 0, strength, strength*2, strength*3)
			else if (air_contents.temperature > (T0C + 100))
				strength = fuel_moles/25
				explosion(ground_zero, 0, 0, strength, strength*3)
			else
				ground_zero.assume_air(air_contents)
				ground_zero.hotspot_expose(1000, 125)
			if (src.master)
				del(src.master)
			del(src)
