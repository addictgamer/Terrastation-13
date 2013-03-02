
/obj/item/aiModule/freeformcore // Slightly more dynamic freeform module -- TLE
	name = "'Freeform' Core AI Module"
	var/newFreeFormLaw = "freeform"
	desc = "A 'freeform' Core AI module: '<freeform>'"
	origin_tech = "programming=3;materials=6"

	attack_hand(var/mob/user as mob)
		..()
		var/newlaw = ""
		var/targName = input(usr, "Please enter a new core law for the AI.", "Freeform Law Entry", newlaw)
		newFreeFormLaw = sanitize(targName)
		desc = "A 'freeform' Core AI module:  '[newFreeFormLaw]'"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = "[newFreeFormLaw]"
		target.add_inherent_law(law)
		lawchanges.Add("The law is '[newFreeFormLaw]'")
