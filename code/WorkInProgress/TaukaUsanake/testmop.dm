
/obj/item/weapon/twohanded/mop
	desc = "The world of janitalia wouldn't be complete without a mop."
	name = "mop"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "mop"
	force = 3.0
	throwforce = 10.0
	throw_speed = 5
	throw_range = 10
	w_class = 3.0
	flags = FPRINT | TABLEPASS
	force_unwielded = 10
	force_wielded = 20
	attack_verb = list("mopped", "bashed", "slapped", "bludgeoned", "whacked")
	var
		mopping = 0
		mopcount = 0

/obj/item/weapon/twohanded/mop/New()
	var/datum/reagents/R = new/datum/reagents(5)
	reagents = R
	R.my_atom = src

obj/item/weapon/twohanded/mop/proc/clean(turf/simulated/A as turf)
	reagents.reaction(A,1,10)
	A.clean_blood()
	for(var/obj/effect/O in A)
		if( istype(O,/obj/effect/rune) || istype(O,/obj/effect/decal/cleanable) || istype(O,/obj/effect/overlay) )
			del(O)

/obj/effect/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/mop))
		return
	..()

/obj/item/weapon/twohanded/mop/afterattack(atom/A, mob/user as mob)
	if(reagents.total_volume < 1 || mopcount >= 5)
		user << "<span class='notice'>Your mop is dry!</span>"
		return
	if(istype(A, /turf/simulated) || istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/overlay) || istype(A, /obj/effect/rune))
		user.visible_message("<span class='warning'>[user] begins to clean \the [get_turf(A)].</span>")
		if(do_after(user, 40))
			if(A)
				clean(get_turf(A))
			user << "<span class='notice'>You have finished mopping!</span>"
			mopcount++
	if(mopcount >= 5) //Okay this stuff is an ugly hack and i feel bad about it.
		spawn(5)
			reagents.clear_reagents()
			mopcount = 0
	return

// fighting edit, rip from twohanded things

/obj/item/weapon/twohanded/mop/update_icon()  //Currently only here to fuck with the on-mob icons.
	icon_state = "mop[wielded]"
	return

/obj/item/weapon/twohanded/mop/attack(target as mob, mob/living/user as mob)
	..()
	if((CLUMSY in user.mutations) && (wielded) &&prob(40))
		user << "\red You lose your focus for a second and slap yourself with the [src]."
		user.take_organ_damage(5,10)
		return
	if((wielded) && prob(50))
		spawn(0)
			for(var/i in list(1,2,4,8,4,2,1,2,4,8,4,2))
				user.dir = i
				sleep(1)

/obj/item/weapon/twohanded/mop/IsShield()
	if(wielded)
		return 1
	else
		return 0


// Stopsign for clown because Tricky is awesome

/obj/item/weapon/twohanded/stopsign
	name = "stop sign"
	desc = "You can only be madness to use this."
	icon_state = "stopsign0"
	force = 3
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	force_unwielded = 3
	force_wielded = 30
	flags = FPRINT | TABLEPASS | NOSHIELD
	origin_tech = "magnets=3;syndicate=4"
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/twohanded/stopsign/update_icon()
	icon_state = "stopsign[wielded]"
	return

/obj/item/weapon/twohanded/stopsign/attack(target as mob, mob/living/user as mob)
	..()
/*	// Clown is ACTUALLY proficient with this!
	if((CLUMSY in user.mutations) && (wielded) &&prob(40))
		user << "\red You twirl around a bit before losing your balance and impaling yourself on the [src]."
		user.take_organ_damage(20,25)
		return
*/
	if((wielded) && prob(50))
		spawn(0)
			for(var/i in list(1,2,4,8,4,2,1,2,4,8,4,2))
				user.dir = i
				sleep(1)

/obj/item/weapon/twohanded/stopsign/IsShield()
	if(wielded)
		return 1
	else
		return 0
