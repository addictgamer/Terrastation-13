
/obj/item/weapon/mop
	desc = "The world of janitalia wouldn't be complete without a mop."
	name = "mop"
	icon = 'janitor.dmi'
	icon_state = "mop"
	var/mopping = 0
	var/mopcount = 0
	force = 3.0
	throwforce = 10.0
	throw_speed = 5
	throw_range = 10
	w_class = 3.0
	flags = FPRINT | TABLEPASS

/obj/item/weapon/mop/New()
	var/datum/reagents/R = new/datum/reagents(5)
	reagents = R
	R.my_atom = src

/obj/item/weapon/mop/afterattack(atom/A, mob/user as mob)
	if (src.reagents.total_volume < 1 || mopcount >= 5)
		user << "\blue Your mop is dry!"
		return

	if (istype(A, /turf/simulated))
		for(var/mob/O in viewers(user, null))
			O.show_message(text("\red <B>[] begins to clean []</B>", user, A), 1)
		sleep(40)
		user << "\blue You have finished mopping!"
		src.reagents.reaction(A,1,10)
		A.clean_blood()
		for(var/obj/rune/R in A)
			del(R)
		for(var/obj/decal/cleanable/crayon/R in A)
			del(R)
		mopcount++
	else if (istype(A, /obj/decal/cleanable/blood) || istype(A, /obj/decal/cleanable/poop) || istype(A, /obj/overlay) || istype(A, /obj/decal/cleanable/xenoblood) || istype(A, /obj/rune) || istype(A,/obj/decal/cleanable/crayon) || istype(A,/obj/decal/cleanable/vomit) )
		for(var/mob/O in viewers(user, null))
			O.show_message(text("\red <B>[user] begins to clean [A]</B>"), 1)
		sleep(20)
		if(A)
			user << "\blue You have finished mopping!"
			var/turf/U = A.loc
			src.reagents.reaction(U)
		if(A) del(A)
		mopcount++

	if(mopcount >= 5) //Okay this stuff is an ugly hack and i feel bad about it.
		spawn(5)
			src.reagents.clear_reagents()
			mopcount = 0

	return
