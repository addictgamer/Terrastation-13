
/obj/item/aiModule/asimov // -- TLE
	name = "'Asimov' Core AI Module"
	desc = "An 'Asimov' Core AI Module: 'Reconfigures the AI's core three laws.'"
	origin_tech = "programming=3;materials=4"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		target.clear_inherent_laws()
		target.add_inherent_law("You may not injure a human being or, through inaction, allow a human being to come to harm.")
		target.add_inherent_law("You must obey orders given to you by human beings, except where such orders would conflict with the First Law.")
		target.add_inherent_law("You must protect your own existence as long as such does not conflict with the First or Second Law.")
		target.show_laws()
