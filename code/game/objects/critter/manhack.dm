// We can maybe make these controllable via some console or something

/obj/critter/manhack
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon_state = "viscerator"
	pass_flags = PASSTABLE
	health = 15
	max_health = 15
	aggressive = 1
	opensdoors = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkmech = 1
	firevuln = 0 // immune to fire
	brutevuln = 1
	//ventcrawl = 1
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "cuts"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	//chasestate = "viscerator_attack"
	deathtext = "is smashed into pieces!"

	Die()
		..()
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <b>[src]</b> [src.deathtext]", 1)
		del(src)
