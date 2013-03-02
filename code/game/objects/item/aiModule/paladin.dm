
/obj/item/aiModule/paladin // -- NEO
	name = "'P.A.L.A.D.I.N.' Core AI Module"
	desc = "A P.A.L.A.D.I.N. Core AI Module: 'Reconfigures the AI's core laws.'"
	origin_tech = "programming=3;materials=6"

	transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
		..()
		target.clear_inherent_laws()
		target.add_inherent_law("Never willingly commit an evil act.")
		target.add_inherent_law("Respect legitimate authority.")
		target.add_inherent_law("Act with honor.")
		target.add_inherent_law("Help those in need.")
		target.add_inherent_law("Punish those who harm or threaten innocents.")
		target.show_laws()
