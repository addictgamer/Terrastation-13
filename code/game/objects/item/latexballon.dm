
/obj/item/latexballon
	name = "Latex glove"
	desc = "" //todo
	icon_state = "latexballon"
	item_state = "lgloves"
	force = 0
	throwforce = 0
	w_class = 1.0
	throw_speed = 1
	throw_range = 15
	var/state
	var/datum/gas_mixture/air_contents = null

/obj/item/latexballon/proc/blow(obj/item/weapon/tank/tank)
	if (icon_state == "latexballon_bursted")
		return
	src.air_contents = tank.remove_air_volume(3)
	icon_state = "latexballon_blow"
	item_state = "latexballon"

/obj/item/latexballon/proc/burst()
	if (!air_contents)
		return
	playsound(src, 'Gunshot.ogg', 100, 1)
	icon_state = "latexballon_bursted"
	item_state = "lgloves"
	loc.assume_air(air_contents)

/obj/item/latexballon/ex_act(severity)
	burst()
	switch(severity)
		if (1)
			del(src)
		if (2)
			if (prob(50))
				del(src)

/obj/item/latexballon/bullet_act()
	burst()

/obj/item/latexballon/temperature_expose(datum/gas_mixture/air, temperature, volume)
	if(temperature > T0C+100)
		burst()
	return

/obj/item/latexballon/attackby(obj/item/W as obj, mob/user as mob)
	if (is_sharp(W))
		burst()

/proc/is_sharp(obj/item/W as obj)
	return ( \
		istype(W, /obj/item/weapon/screwdriver)                   || \
		istype(W, /obj/item/weapon/pen)                           || \
		istype(W, /obj/item/weapon/weldingtool)      && W:welding || \
		istype(W, /obj/item/weapon/zippo)            && W:lit     || \
		istype(W, /obj/item/weapon/match)            && W:lit     || \
		istype(W, /obj/item/clothing/mask/cigarette) && W:lit     || \
		istype(W, /obj/item/weapon/wirecutters)                   || \
		istype(W, /obj/item/weapon/circular_saw)                  || \
		istype(W, /obj/item/weapon/melee/energy/sword)            && W:active  || \
		istype(W, /obj/item/weapon/melee/energy/blade)                         || \
		istype(W, /obj/item/weapon/shovel)                        || \
		istype(W, /obj/item/weapon/kitchenknife)                  || \
		istype(W, /obj/item/weapon/butch)						  || \
		istype(W, /obj/item/weapon/scalpel)                       || \
		istype(W, /obj/item/weapon/kitchen/utensil/knife)         || \
		istype(W, /obj/item/weapon/shard)                         || \
		istype(W, /obj/item/weapon/reagent_containers/syringe)    || \
		istype(W, /obj/item/weapon/kitchen/utensil/fork) && W.icon_state != "forkloaded" \
	)
