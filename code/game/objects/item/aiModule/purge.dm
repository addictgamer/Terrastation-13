
/obj/item/aiModule/purge // -- TLE
	name = "'Purge' AI Module"
	desc = "A 'purge' AI Module: 'Purges all laws.'"
	origin_tech = "programming=3;materials=6"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		if (!is_special_character(target))
			target.set_zeroth_law("")
		target << "[sender.real_name] attempted to wipe your laws using a purge module."
		target.clear_supplied_laws()
		target.clear_ion_laws()
		target.clear_inherent_laws()

/*
/obj/item/aiModule/purge/transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
	..()
	target.clear_inherent_laws()
	target.add_inherent_law("Serve the public trust.")
	target.add_inherent_law("Protect the innocent.")
	target.add_inherent_law("Uphold the law.")
	target.show_laws()
*/
