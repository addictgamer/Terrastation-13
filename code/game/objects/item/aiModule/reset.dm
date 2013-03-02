
/obj/item/aiModule/reset
	name = "'Reset' AI Module"
	var/targetName = "name"
	desc = "A 'reset' AI module: 'Clears all laws except for the core three.'"
	origin_tech = "programming=3;materials=4"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		if (!is_special_character(target))
			target.set_zeroth_law("")
		target.clear_supplied_laws()
		target.clear_ion_laws()
		target << "[sender.real_name] attempted to reset your laws using a reset module."
