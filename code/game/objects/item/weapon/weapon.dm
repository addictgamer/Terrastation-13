
/obj/item/weapon
	name = "weapon"
	icon = 'weapons.dmi'

/obj/item/weapon/Bump(mob/M as mob)
	spawn( 0 )
		..()
	return

/atom/proc/ex_act()
	return

/atom/proc/blob_act()
	return

// bullet_act called when anything is hit buy a projectile (bullet, tazer shot, laser, etc.)
// flag is projectile type, can be:
//PROJECTILE_TASER = 1   		taser gun
//PROJECTILE_LASER = 2			laser gun
//PROJECTILE_BULLET = 3			traitor pistol
//PROJECTILE_PULSE = 4			pulse rifle
//PROJECTILE_BOLT = 5			crossbow
//PROJECTILE_WEAKBULLET = 6		detective's revolver

/turf/Entered(atom/A as mob|obj)
	..()
	if ((A && A.density && !( istype(A, /obj/beam) )))
		for(var/obj/beam/i_beam/I in src)
			spawn( 0 )
				if (I)
					I.hit()
				return
	return

/*
 *  Hope it's okay to stick this shit here: it basically just turns a hexadecimal color into rgb
 */

proc/GetColors(hex)
    hex = uppertext(hex)
    var
        hi1 = text2ascii(hex, 2)
        lo1 = text2ascii(hex, 3)
        hi2 = text2ascii(hex, 4)
        lo2 = text2ascii(hex, 5)
        hi3 = text2ascii(hex, 6)
        lo3 = text2ascii(hex, 7)
    return list(((hi1>= 65 ? hi1-55 : hi1-48)<<4) | (lo1 >= 65 ? lo1-55 : lo1-48),
        ((hi2 >= 65 ? hi2-55 : hi2-48)<<4) | (lo2 >= 65 ? lo2-55 : lo2-48),
        ((hi3 >= 65 ? hi3-55 : hi3-48)<<4) | (lo3 >= 65 ? lo3-55 : lo3-48))

/*
/obj/item/weapon/cigarpacket
	name = "Pete's Cuban Cigars"
	desc = "The most robust cigars on the planet."
	icon = 'cigarettes.dmi'
	icon_state = "cigarpacket"
	item_state = "cigarpacket"
	w_class = 1
	throwforce = 2
	var/cigarcount = 6
	flags = ONBELT | TABLEPASS
*/
