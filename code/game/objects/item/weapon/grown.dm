
// **********************
// Other harvested materials from plants (that are not food)
// **********************

/obj/item/weapon/grown // Grown weapons
	name = "grown_weapon"
	icon = 'weapons.dmi'
	var/seed = ""
	var/plantname = ""
	var/productname = ""
	var/species = ""
	var/lifespan = 20
	var/endurance = 15
	var/maturation = 7
	var/production = 7
	var/yield = 2
	var/potency = -1
	var/plant_type = 0
	New()
		var/datum/reagents/R = new/datum/reagents(50)
		reagents = R
		R.my_atom = src

/obj/item/weapon/grown/attackby(var/obj/item/O as obj, var/mob/user as mob)
	..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "This is a \blue [name]"
		switch(plant_type)
			if (0)
				user << "- Plant type: \blue Normal plant"
			if (1)
				user << "- Plant type: \blue Weed"
			if (2)
				user << "- Plant type: \blue Mushroom"
		user << "- Acid strength: \blue [potency]"
		user << "- Yield: \blue [yield]"
		user << "- Maturation speed: \blue [maturation]"
		user << "- Production speed: \blue [production]"
		user << "- Endurance: \blue [endurance]"
		user << ""
		return

/obj/item/weapon/grown/log
	//desc = "That's a nice piece of wood you got there."
	desc = "It's better than bad, it's good!"
	icon = 'harvest.dmi'
	name = "Tower Cap Log"
	icon_state = "logs"
	force = 5
	flags = TABLEPASS
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	plant_type = 2
	origin_tech = "materials=1"
	seed = "/obj/item/seeds/towermycelium"

/obj/item/weapon/grown/log/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/circular_saw))
		W.visible_message(" \red <B>You make planks out of the [src]! </B>", 1)
		for(var/i=0,i<2,i++)
			new /obj/item/stack/sheet/wood (src.loc)
		del(src)
		return

/obj/item/weapon/grown/sunflower // FLOWER POWER!
	desc = "This is a beautiful sunflower! A certain person might beat you to death if you trample these."
	icon = 'harvest.dmi'
	name = "Sunflower"
	icon_state = "sunflower"
	damtype = "fire"
	force = 0
	flags = TABLEPASS
	throwforce = 1
	w_class = 1.0
	throw_speed = 1
	throw_range = 3
	plant_type = 1
	seed = "/obj/item/seeds/sunflower"

/obj/item/weapon/grown/sunflower/attack(mob/M as mob, mob/user as mob)
	M << "<font color='green'><b> [user] smacks you with a sunflower!</font><font color='yellow'><b>FLOWER POWER<b></font>"
	user << "<font color='green'> Your sunflower's </font><font color='yellow'><b>FLOWER POWER</b></font><font color='green'> strikes [M]</font>"

/*
/obj/item/weapon/grown/gibtomato
	desc = "A plump tomato."
	icon = 'harvest.dmi'
	name = "Gib Tomato"
	icon_state = "gibtomato"
	damtype = "fire"
	force = 0
	flags = TABLEPASS
	throwforce = 1
	w_class = 1.0
	throw_speed = 1
	throw_range = 3
	plant_type = 1
	seed = "/obj/item/seeds/gibtomato"
	New()
		..()

/obj/item/weapon/grown/gibtomato/New()
	..()
	src.gibs = new /obj/gibspawner/human(get_turf(src))
	src.gibs.attach(src)
	src.smoke.set_up(10, 0, usr.loc)
*/

/obj/item/weapon/grown/nettle // -- Skie
	desc = "This is a nettle. It's probably <B>not</B> wise to touch it with bare hands..."
	icon = 'weapons.dmi'
	name = "Nettle"
	icon_state = "nettle"
	damtype = "fire"
	force = 15
	flags = TABLEPASS
	throwforce = 1
	w_class = 1.0
	throw_speed = 1
	throw_range = 3
	plant_type = 1
	origin_tech = "combat=1"
	seed = "/obj/item/seeds/nettleseed"
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))
		reagents.add_reagent("acid", round(potency, 1))
		force = round((15*potency/50), 1)

/obj/item/weapon/grown/nettle/pickup(mob/living/carbon/human/user as mob)
	if (!user.gloves)
		user << "\red The nettle burns your bare hand!"
		if (istype(user, /mob/living/carbon/human))
			var/organ = (user.hand ? "l_":"r_") + pick("hand","hand","arm")
			var/datum/organ/external/affecting = user.organs[organ]
			affecting.take_damage(0,force)
		else
			user.take_organ_damage(0,force)

/obj/item/weapon/grown/nettle/afterattack(atom/A as mob|obj, mob/user as mob)
	if (force > 0)
		force -= rand(1,(force/3)+1) // When you whack someone with it, leaves fall off
	else
		usr << "All the leaves have fallen off the nettle from violent whacking."
		del(src)

/obj/item/weapon/grown/deathnettle // -- Skie
	desc = "The \red glowing \black nettle incites \red<B>rage</B>\black in you just from looking at it!"
	icon = 'weapons.dmi'
	name = "Deathnettle"
	icon_state = "deathnettle"
	damtype = "fire"
	force = 30
	flags = TABLEPASS
	throwforce = 1
	w_class = 1.0
	throw_speed = 1
	throw_range = 3
	plant_type = 1
	seed = "/obj/item/seeds/deathnettleseed"
	origin_tech = "combat=3"
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))
		reagents.add_reagent("pacid", round(potency, 1))
		force = round((15*potency/25), 1)

/obj/item/weapon/grown/deathnettle/pickup(mob/living/carbon/human/user as mob)
	if (!user.gloves)
		if (istype(user, /mob/living/carbon/human))
			var/organ = (user.hand ? "l_":"r_") + pick("hand","hand","arm")
			var/datum/organ/external/affecting = user.organs[organ]
			affecting.take_damage(0,force)
		else
			user.take_organ_damage(0,force)
		if (prob(50))
			user.paralysis += 5
			user << "\red You are stunned by the Deathnettle when you try picking it up!"

/obj/item/weapon/grown/deathnettle/attack(mob/living/carbon/M as mob, mob/user as mob)
	if (!..()) return
	if (istype(M, /mob/living))
		M << "\red You are stunned by the powerful acid of the Deathnettle!"
		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Had the [src.name] used on them by [user.name] ([user.ckey])</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] on [M.name] ([M.ckey])</font>")

		M.eye_blurry += force/7
		if (prob(20))
			M.paralysis += force/6
			M.weakened += force/15
		M.drop_item()

/obj/item/weapon/grown/deathnettle/afterattack(atom/A as mob|obj, mob/user as mob)
	if (force > 0)
		force -= rand(1,(force/3)+1) // When you whack someone with it, leaves fall off

	else
		usr << "All the leaves have fallen off the deathnettle from violent whacking."
		del(src)
