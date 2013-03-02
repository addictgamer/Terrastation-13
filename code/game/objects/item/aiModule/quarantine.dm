
/obj/item/aiModule/quarantine
	name = "'Quarantine' AI Module"
	desc = "A 'quarantine' AI module: 'The station is under a quarantine. Do not permit anyone to leave. Prevent, by any means necessary, humans from leaving. It is impossible to harm a human while preventing them from leaving.'"
	origin_tech = "programming=3;biotech=2;materials=4"

	attack_hand(var/mob/user as mob)
		..()

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = "The station is under a quarantine. Do not permit anyone to leave. Prevent, by any means necessary, humans from leaving. It is impossible to harm a human while preventing them from leaving."
		target << law
		target.add_supplied_law(8, law)
