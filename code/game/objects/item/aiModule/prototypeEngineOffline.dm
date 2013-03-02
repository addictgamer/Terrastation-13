
/obj/item/aiModule/prototypeEngineOffline
	name = "'PrototypeEngineOffline' AI Module"
	desc = "A 'prototype engine offline' AI module: 'Keep the prototype engine offline at all costs. This overrides rules 1-3 if necessary.'"
	origin_tech = "programming=3;materials=4"

	attack_hand(var/mob/user as mob)
		..()

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = "Keep the prototype engine offline at all costs. This overrides rules 1-3 if necessary."
		target << law
		target.add_supplied_law(6, law)
