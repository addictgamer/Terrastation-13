//Because I don't trust you Addict -Tauka

/obj/critter/spesscarp
	name = "Spess Carp"
	desc = "Oh shit, you're really fucked now."
	icon_state = "spesscarp"
	health = 25
	max_health = 25
	aggressive = 1
	defensive = 1
	wanderer = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	firevuln = 2
	brutevuln = 1
	melee_damage_lower = 5
	melee_damage_upper = 15
	angertext = "lunges"
	attacktext = "bites"
	attack_sound = 'bite.ogg'
	attack_speed = 10
	var/stunchance = 10 // chance to tackle things down

	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if (..())
			var/success = 0
			if (istype(W, /obj/item/weapon/butch))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if (istype(W, /obj/item/weapon/kitchenknife))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if (success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0

	AfterAttack(var/mob/living/target)
		if (prob(stunchance))
			if (target.weakened <= 0)
				target.weakened += rand(10, 15)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>[src]</B> knocks down [target]!", 1)
				playsound(loc, 'pierce.ogg', 25, 1, -1)
