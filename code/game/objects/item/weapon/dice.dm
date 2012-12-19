
/obj/item/weapon/dice // -- TLE
	name = "d6"
	desc = "A dice with six sides."
	var/sides = 6
	icon_state = "dice"
	item_state = "dice"

/obj/item/weapon/dice/attack_self(mob/user as mob) // Roll the dice -- TLE
	var/temp_sides
	if(src.sides < 1)
		temp_sides = 2
	else
		temp_sides = src.sides
	var/result = rand(1,temp_sides)
	var/comment = ""
	if(temp_sides == 20 && result == 20)
		comment = "Nat 20!"
	else if(temp_sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	user << text("\red You throw a [src]. It lands on a [result]. [comment]")
	for(var/mob/O in viewers(user, null))
		if(O == (user))
			continue
		else
			O.show_message(text("\red [user] has thrown a [src]. It lands on [result]. [comment]"), 1)

/obj/item/weapon/dice/d20 // -- TLE
	name = "d20"
	desc = "A dice with...hell that is many sides."
	sides = 20
	icon_state = "d20"
	item_state = "dice"
