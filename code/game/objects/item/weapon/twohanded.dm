/*##################################################################
##################### TWO HANDED WEAPONS BE HERE~ -Agouri :3 ########
####################################################################*/

///General Offhand object properties///

////////////FIREAXE!//////////////

/obj/item/weapon/fireaxe  // DEM AXES MAN, marker -Agouri
	icon_state = "fireaxe0"
	name = "Fire axe"
	desc = "Truly, the tool of a madman. Who would possibly think to fight fire with an axe?"
	force = 5
	w_class = 4.0
	flags = ONBACK
	twohanded = 1
	force_unwielded = 5
	force_wielded = 30

/obj/item/weapon/fireaxe/update_icon()  //Currently only here to fuck with the on-mob icons.
	icon_state = text("fireaxe[]",wielded)
	return

/obj/item/weapon/fireaxe/pickup(mob/user)
	wielded = 0
	name = "Fire Axe (Unwielded)"

/obj/item/weapon/fireaxe/attack_self(mob/user as mob)
	if( istype(user,/mob/living/carbon/monkey) )
		user << "\red It's too heavy for you to fully wield"
		return

//welp, all is good, now to see if he's trying do twohandedly wield it or unwield it

	..()

/obj/item/weapon/offhand
	name = "Offhand"
	var/linked_weapon_name = ""
	w_class = 5.0
	icon_state = "offhand"

/obj/item/weapon/offhand/dropped(mob/user as mob)
	del(src)


/*
/obj/item/weapon/taukakatanas

*/