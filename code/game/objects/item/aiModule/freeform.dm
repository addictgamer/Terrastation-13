
/obj/item/aiModule/freeform // Slightly more dynamic freeform module -- TLE
	name = "'Freeform' AI Module"
	desc = "A 'freeform' AI module: '<freeform>'"
	origin_tech = "programming=4;materials=4"
	var
		newFreeFormLaw = "freeform"
		lawpos = 15

	attack_hand(var/mob/user as mob)
		..()
		lawpos = 0
		while(lawpos < 15)
			lawpos = input("Please enter the priority for your new law. Can only write to law sectors 15 and above.", "Law Priority (15+)", lawpos) as num
		lawpos = min(lawpos, 50)
		var/newlaw = ""
		var/targName = input(usr, "Please enter a new law for the AI.", "Freeform Law Entry", newlaw)
		newFreeFormLaw = sanitize(targName)
		desc = "A 'freeform' AI module: ([lawpos]) '[newFreeFormLaw]'"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = "[newFreeFormLaw]"
		target << law
		if(!lawpos || lawpos < 15)
			lawpos = 15
		target.add_supplied_law(lawpos, law)
		lawchanges.Add("The law was '[newFreeFormLaw]'")

// Removed in favor of a more dynamic freeform law system. -- TLE
/*
/obj/item/aiModule/freeform
	name = "'Freeform' AI Module"
	var/newFreeFormLaw = "freeform"
	desc = "A 'freeform' AI module: '<freeform>'"

/obj/item/aiModule/freeform/attack_hand(var/mob/user as mob)
	..()
	var/eatShit = "Eat shit and die"
	var/targName = input(usr, "Please enter anything you want the AI to do. Anything. Serious.", "What?", eatShit)
	newFreeFormLaw = targName
	desc = text("A 'freeform' AI module: '[]'", newFreeFormLaw)

/obj/item/aiModule/freeform/transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
	..()
	var/law = "[newFreeFormLaw]"
	target << law
	target.add_supplied_law(10, law)
*/
