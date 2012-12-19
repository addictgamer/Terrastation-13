
////////////
////Sign////
////////////

/obj/sign
	desc = "A sign."
	name = "SIGN"
	icon = 'decals.dmi'
	icon_state = "securearea"
	anchored = 1.0
	opacity = 0
	density = 0
	pixel_x = -1
	pixel_y = -1

/obj/sign/ex_act(severity)
	switch(severity)
		if(1.0)
			del(src)
			return
		if(2.0)
			del(src)
			return
		if(3.0)
			return
		else
	return

/obj/sign/blob_act()
	if (prob(75))
		del(src)
		return
	return

/obj/sign/securearea
	desc = "A warning sign which reads 'SECURE AREA'. This obviously applies to a nun-Clown."
	name = "SECURE AREA"
	icon = 'decals.dmi'
	icon_state = "securearea"

/obj/sign/biohazard
	desc = "A warning sign which reads 'BIOHAZARD'"
	name = "BIOHAZARD"
	icon = 'decals.dmi'
	icon_state = "bio"

/obj/sign/electricshock
	desc = "A warning sign which reads 'HIGH VOLTAGE'"
	name = "HIGH VOLTAGE"
	icon = 'decals.dmi'
	icon_state = "shock"

/obj/sign/examroom
	desc = "A guidance sign which reads 'EXAM ROOM'"
	name = "EXAM"
	icon = 'decals.dmi'
	icon_state = "examroom"

/obj/sign/vacuum
	desc = "A warning sign which reads 'HARD VACUUM AHEAD'"
	name = "HARD VACUUM AHEAD"
	icon = 'decals.dmi'
	icon_state = "space"

/obj/sign/fire
	desc = "A warning sign which reads 'HOT! HOT! AAAH! I'M BURNING!'"
	name = "HOT! HOT! AAAH! I'M BURNING!"
	icon = 'decals.dmi'
	icon_state = "fire"

/obj/sign/nosmoking_1
	desc = "A warning sign which reads 'NO SMOKING'"
	name = "NO SMOKING"
	icon = 'decals.dmi'
	icon_state = "nosmoking"

/obj/sign/nosmoking_2
	desc = "A warning sign which reads 'NO SMOKING'"
	name = "NO SMOKING"
	icon = 'decals.dmi'
	icon_state = "nosmoking2"

/obj/sign/redcross
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	name = "Med-Bay"
	icon = 'decals.dmi'
	icon_state = "redcross"

/obj/sign/goldenplaque
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	name = "The Most Robust Men Award for Robustness"
	icon = 'decals.dmi'
	icon_state = "goldenplaque"

/obj/sign/doors
	desc = "This way be doors."
	name = "Doors Sign"
	icon = 'decals.dmi'
	icon_state = "doors"

/obj/sign/radioactive
	desc = "Make sure you wear protective gear in this area."
	name = "Radiation Warning"
	icon = 'decals.dmi'
	icon_state = "radiation"

/obj/sign/star
	desc = "Oh, lookit. You found something interesting."
	name = "Elder Sign"
	icon = 'decals.dmi'
	icon_state = "eldersign"

/obj/sign/maltesefalcon1         //The sign is 64x32, so it needs two tiles. ;3
	desc = "The Maltese Falcon, Space Bar and Grill. Now with added monkey."
	name = "The Maltese Falcon"
	icon = 'decals.dmi'
	icon_state = "maltesefalcon1"

/obj/sign/maltesefalcon2
	desc = "The Maltese Falcon, Space Bar and Grill. Now with added monkey."
	name = "The Maltese Falcon"
	icon = 'decals.dmi'
	icon_state = "maltesefalcon2"
