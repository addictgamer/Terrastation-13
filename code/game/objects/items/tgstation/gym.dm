/obj/structure/punching_bag
	name = "punching bag"
	desc = "A punching bag. Can you get to speed level 4???"
	icon = 'icons/tgstation/obj/fitness.dmi'
	icon_state = "punchingbag"
	anchored = 1
	layer = 4.25
	var/list/hit_sounds = list('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg',\
	'sound/weapons/punch1.ogg', 'sound/weapons/punch2.ogg', 'sound/weapons/punch3.ogg', 'sound/weapons/punch4.ogg')

/obj/structure/punching_bag/attack_hand(mob/user as mob)
		flick("[icon_state]2", src)
		playsound(src.loc, pick(src.hit_sounds), 25, 1, -1)
