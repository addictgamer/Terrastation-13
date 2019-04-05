/*
This file contains any and all energy weapons implemented by a Terraform contributor.
Each gun will have a brief description alluding to either who made it, concieved it, or is based on.
It will also define any proprietary ammunition it needs, if any. This will remain unless this file gets too damn big.
Any non-energy weapon (aka slugthrower guns or wtvr) will be defined in a separate file.
*/


//The Shiper: a signature weapon of Zjean Dragonus

//Gun

/obj/item/weapon/gun/energy/laser/shiper
	name = "Shiper"
	icon = 'icons/obj/terra/gunzor.dmi'
	icon_state = "shiper"
	desc = "A collapsible shotgun that fires... energy? Who the hell designed this thing?"
	//projectile_type = /obj/item/projectile/beam/shiper
//above is old and might be removable
	ammo_type = list(/obj/item/ammo_casing/energy/laser/shiper)
	origin_tech = null
	fire_sound = 'sound/weapons/shiperfire.ogg'
	update_icon()
		return

/obj/item/weapon/gun/energy/laser/shiper/chrome
	name = "Chrome Shiper"
	icon_state = "cshiper"
	desc = "A more rifle-like variant of the shotgun-sniper-thing. This one has a chrome finish."

//Beam

/obj/item/projectile/beam/shiper
	name = "shiper blast"
	icon = 'icons/obj/terra/bulletz.dmi'
	icon_state = "shipe"
	damage = 45

/obj/item/ammo_casing/energy/laser/shiper
	name = "shiper lens"
	desc = "ho ree fuk"
	e_cost = 0
	fire_sound = 'sound/weapons/shiperfire.ogg'



//HERE BE METEORGUNS!!
//===================
//The fuck cannon/the 322: A meteorgun that actually does damage, per Bast's specifications

/obj/item/ammo_casing/energy/meteor/fuck
	projectile_type = /obj/item/projectile/meteor/fuck

/obj/item/projectile/meteor/fuck
	damage = 132.2
	var/stoppls = 0

/obj/item/weapon/gun/energy/meteorgun/fuck
	ammo_type = list(/obj/item/ammo_casing/energy/meteor/fuck)

/obj/item/weapon/gun/energy/meteorgun/fuck/pen
	name = "Pen 322"
	desc = "322 322 322 322 322 322 are you pissed the fuck off yet"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/projectile/meteor/fuck/Bump(atom/A, yes)
	..()
	if(isliving(A))
		var/mob/living/M = A
		if(stoppls == 0)
			M.adjustBruteLoss(damage)
			stoppls++//please game stop making this thing hit three fucking times please I'm going to cry
//so, uh.... as alluded, this gun does wonky shit as a result of the fucking thing not doing damage on hit as normal. Why, I am too incompetent to figure out.
//An odd property this weapon currently has is it will deal 1.5x damage on monkeys, but normal on humans. or is that normal behaviour?
//anywho, it will also steamroll simple_animals like renault and do the impact bump on the next solid object it hits. Which makes no sense, the fucking qdel code happens before the damage why the fuck is this happening I don't even
//it will also pass through like above on any simple animal on death, but only if it died from the offending hit
//if you target a dead or prone mob the bullet will attempt to damage said mob if it is alive but do the bump animation on the next solid thing it hits, and will deal no damage to it
//this makes no seeeennnnse uuuugnh


//The Spam Cannon: made as a result of amusing behavior in failed code
/obj/item/weapon/gun/energy/meteorgun/pen/spam
	name = "The Spam Cannon"
	desc = "Annoy/scare all the people!"
	ammo_type = list(/obj/item/ammo_casing/energy/meteor/spam)

/obj/item/ammo_casing/energy/meteor/spam
	projectile_type = /obj/item/projectile/meteor/spam

/obj/item/projectile/meteor/spam/Bump(atom/A, yes)
	if(yes)
		return
	if(A == firer)
		loc = A.loc
		return
	playsound(loc, 'sound/effects/meteorimpact.ogg', 40, 1)
	for(var/mob/M in urange(10, src))
		if(!M.stat)
			shake_camera(M, 3, 1)
			//The qdel line that was here is removed, this causes an infinite ramming effect with no damage until the TTL expires.
			//This was discovered when testing the above m-gun for damage issues, and I near fell out of my chair laughing.

//The Banlance Cannon, LZ's fabled fuck-you gunnon.

/obj/item/weapon/gun/energy/meteorgun/banlance
	ammo_type = list(/obj/item/ammo_casing/energy/meteor/ban)
	name = "Banlance Cannon"
	desc = "If this exists, LZ is terribly angry."
	cell_type = /obj/item/weapon/stock_parts/cell/super

/obj/item/ammo_casing/energy/meteor/ban
	projectile_type = /obj/item/projectile/meteor/banlance

/obj/item/projectile/meteor/banlance
	name = "Ban Lance"
	desc = "fuuuck."
	icon = 'icons/obj/terra/bulletz.dmi'
	icon_state = "banlance"

/obj/item/projectile/meteor/banlance/proc/ban(mob/living/target as mob) //direct copypaste from the Avatar of Meltion. Arguably, this item conceptually came first (it's attack verb is 'banlance', after all!)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, 200, 4)

/obj/item/projectile/meteor/banlance/Bump(atom/A, yes)
	..()
	if(isliving(A))
		ban(A)
	explosion(A, -1, 0, 1)