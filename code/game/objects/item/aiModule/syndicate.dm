
/obj/item/aiModule/syndicate // Slightly more dynamic freeform module -- TLE
	name = "Hacked AI Module"
	var/newFreeFormLaw = "freeform"
	desc = "A hacked AI law module: '<freeform>'"
	origin_tech = "programming=3;materials=6;syndicate=7"

	attack_hand(var/mob/user as mob)
		..()
		var/newlaw = ""
		var/targName = input(usr, "Please enter a new law for the AI.", "Freeform Law Entry", newlaw)
		newFreeFormLaw = sanitize(targName)
		desc = "A hacked AI law module:  '[newFreeFormLaw]'"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		//..()    //We don't want this module reporting to the AI who dun it. --NEO
		var/time = time2text(world.realtime,"hh:mm:ss")
		lawchanges.Add("[time] <B>:</B> [sender.name]([sender.key]) used [src.name] on [target.name]([target.key])")
		lawchanges.Add("The law is '[newFreeFormLaw]'")
		target << "\red BZZZZT"
		var/law = "[newFreeFormLaw]"
		target.add_ion_law(law)
