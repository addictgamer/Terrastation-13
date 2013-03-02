
/obj/item/aiModule/safeguard
	name = "'Safeguard' AI Module"
	var/targetName = "name"
	desc = "A 'safeguard' AI module: 'Safeguard <name>, and you may overrule rules 1-3 if necessary to safeguard them.'"
	origin_tech = "programming=3;materials=4"

	attack_hand(var/mob/user as mob)
		..()
		var/targName = input(usr, "Please enter the name of the person to safeguard.", "Safeguard who?", user.name)
		targetName = sanitize(targName)
		desc = text("A 'safeguard' AI module: 'Safeguard [], and you may overrule rules 1-3 if necessary to safeguard them.'", targetName)

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = text("Safeguard [], and you may overrule rules 1-3 if necessary to safeguard them.", targetName)
		target << law
		target.add_supplied_law(4, law)
		lawchanges.Add("The law specified [targetName]")
