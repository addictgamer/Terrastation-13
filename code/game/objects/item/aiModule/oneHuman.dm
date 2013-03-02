
/obj/item/aiModule/oneHuman
	name = "'OneHuman' AI Module"
	var/targetName = "name"
	desc = "A 'one human' AI module: 'Only <name> is human.'"
	origin_tech = "programming=3;materials=6" //made with diamonds!

	attack_hand(var/mob/user as mob)
		..()
		var/targName = input(usr, "Please enter the name of the person who is the only human.", "Who?", user.real_name)
		targetName = sanitize(targName)
		desc = text("A 'one human' AI module: 'Only [] is human.'", targetName)

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = "Only [targetName] is human."
		if (!is_special_character(target)) // Makes sure the AI isn't a traitor before changing their law 0. --NeoFite
			target << law
			target.set_zeroth_law(law)
			lawchanges.Add("The law specified [targetName]")
		else
			target << "[sender.real_name] attempted to modify your zeroth law." // And lets them know that someone tried. --NeoFite
			target << "It would be in your best interest to play along with [sender.real_name] that [law]"
			lawchanges.Add("The law specified [targetName], but the AI's existing law 0 cannot be overriden.")
