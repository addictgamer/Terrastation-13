
/obj/item/aiModule/teleporterOffline
	name = "'TeleporterOffline' AI Module"
	desc = "A 'teleporter offline' AI module: 'Keep the teleporter offline at all costs. Anything attempting to access or activate the teleporter is not human.'"
	origin_tech = "programming=3;materials=4"

	attack_hand(var/mob/user as mob)
		..()

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		var/law = "Keep the teleporter offline at all costs. Anything attempting to access or activate the teleporter is not human."
		target << law
		target.add_supplied_law(7, law)
