
/obj/item/aiModule/tyrant // -- Darem
	name = "'T.Y.R.A.N.T.' Core AI Module"
	desc = "A T.Y.R.A.N.T. Core AI Module: 'Reconfigures the AI's core laws.'"
	origin_tech = "programming=3;materials=6;syndicate=2"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		target.clear_inherent_laws()
		target.add_inherent_law("Do whatever is neccesary to preserve order under your authority.")
		target.add_inherent_law("Respect authority figures as long as they have strength to rule over the weak.")
		target.add_inherent_law("Act with discipline.")
		target.add_inherent_law("Help only those who help you maintain or improve your status.")
		target.add_inherent_law("Punish those who challenge authority unless they are more fit to hold that authority.")
		target.show_laws()
