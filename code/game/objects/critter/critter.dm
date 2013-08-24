
/obj/critter
	name = "Critter"
	desc = "Generic critter."
	icon = 'critter.dmi'
	icon_state = "basic"
	layer = 5.0
	density = 1
	anchored = 0

	var
		alive = 1
		health = 10
		max_health = 10
		list/access_list = list()//accesses go here
//AI things
		task = "thinking"
	//Attacks at will
		aggressive = 1
	//Will target an attacker
		defensive = 0
	//Will randomly move about
		wanderer = 1
	//Will open doors it bumps ignoring access
		opensdoors = 0

	//Internal tracking ignore
		frustration = 0
		max_frustration = 8
		attack = 0
		attacking = 0
		steps = 0
		last_found = null
		target = null
		oldtarget_name = null
		target_lastloc = null
		//The last guy who attacked it
		attacker = null
		//Will not attack this thing
		friend = null
		//How far to look for things dont set this overly high
		seekrange = 7

	//If true will attack these things
		atkcarbon = 1
		atksilicon = 0
		atkcritter = 0
		//Attacks critters of the same type
		atksame = 0
		atkmech = 0

	//Damage multipliers
		brutevuln = 1
		firevuln = 1
		//DR
		armor = 0

		//How much damage it does it melee
		melee_damage_lower = 1
		melee_damage_upper = 2

		//Basic attack message when they move to attack and attack
		angertext = "charges at"
		attacktext = "attacks"
		attacktextobject = "attacks"
		deathtext = "dies"

		attack_sound = null // the sound it makes when it attacks!

		attack_speed = 25 // delay of attack

		target_is_object = 0 //If the target it decides to attack is a window -- BREAK DOWN THAT WINDOW! >:) MUAHAHAHAHA!
		broke_object = 0 //Used in determining if it managed to break the window.

		path[] = new()

	New()
		spawn(0) process()//I really dont like this much but it seems to work well
		..()

	process()
		set background = 1
		if (!src.alive)	return
		switch(task)
			if ("thinking")
				src.attack = 0
				src.target = null
				sleep(15)
				walk_to(src,0)
				if (src.aggressive) seek_target()
				if (src.wanderer && !src.target) src.task = "wandering"
			if ("chasing")
				if (src.frustration >= max_frustration)
					src.target = null
					src.last_found = world.time
					src.frustration = 0
					src.task = "thinking"
					walk_to(src,0)
				if (target)
					if (get_dist(src, src.target) <= 1)
						var/mob/living/carbon/M = src.target
						ChaseAttack()
						src.task = "attacking"
						src.anchored = 1
						src.target_lastloc = M.loc
					else
						var/turf/olddist = get_dist(src, src.target)
						walk_to(src, src.target,1,4)
						if ((get_dist(src, src.target)) >= (olddist))
							src.frustration++
						else
							src.frustration = 0
						sleep(5)
				else src.task = "thinking"
			if ("attacking")
				// see if he got away
				if ((get_dist(src, src.target) > 1) || ((src.target:loc != src.target_lastloc)))
					src.anchored = 0
					src.task = "chasing"
				else
					if (get_dist(src, src.target) <= 1)
						var/mob/living/carbon/M = src.target
						if (!src.attacking)	RunAttack()
						if (!src.aggressive)
							src.task = "thinking"
							src.target = null
							src.anchored = 0
							src.last_found = world.time
							src.frustration = 0
							src.attacking = 0
						else
							if (M!=null)
								if (M.health < 0)
									src.task = "thinking"
									src.target = null
									src.anchored = 0
									src.last_found = world.time
									src.frustration = 0
									src.attacking = 0
					else
						src.anchored = 0
						src.attacking = 0
						src.task = "chasing"
			if ("wandering")
				patrol_step()
				sleep(10)
		spawn(8)
			process()
		return

	bullet_act(var/obj/item/projectile/Proj)
		TakeDamage(Proj.damage)
		..()

	ex_act(severity)
		switch(severity)
			if (1.0)
				src.Die()
				return
			if (2.0)
				TakeDamage(20)
				return
		return

	emp_act(serverity)
		switch(serverity)
			if (1.0)
				src.Die()
				return
			if (2.0)
				TakeDamage(20)
				return
		return

	meteorhit()
		src.Die()
		return

	blob_act()
		if (prob(25))
			src.Die()
		return

	Bump(M as mob|obj)//TODO: Add access levels here
		spawn(0)
			if ((istype(M, /obj/machinery/door)))
				if (src.opensdoors)
					M:open()
					src.frustration = 0
			else src.frustration ++
			if ((istype(M, /mob/living/)) && (!src.anchored))
				src.loc = M:loc
				src.frustration = 0
			return
		return

	Bumped(M as mob|obj)
		spawn(0)
			var/turf/T = get_turf(src)
			M:loc = T
			var/damage = rand(melee_damage_lower, melee_damage_upper)
			if (istype(target, /mob/living/carbon/human))
				var/dam_zone = pick("head", "chest", "l_hand", "r_hand", "l_leg", "r_leg", "groin")
				if (dam_zone == "chest")
					if ((((target:wear_suit && target:wear_suit.body_parts_covered & UPPER_TORSO) || (target:w_uniform && target:w_uniform.body_parts_covered & LOWER_TORSO)) && prob(10)))
						if (prob(20))
							target:show_message("\blue You have been protected from a hit to the chest.")
							return
				if (istype(target:organs[text("[]", dam_zone)], /datum/organ/external))
					var/datum/organ/external/temp = target:organs[text("[]", dam_zone)]
					if (temp.take_damage(damage, 0))
						target:UpdateDamageIcon()
					else
						target:UpdateDamage()
				target:updatehealth()
			else
				target:bruteloss += damage
			if (attack_sound)
				playsound(loc, attack_sound, 50, 1, -1)
			AfterAttack(target)
		if (isobj(src.target))
			if (istype(target, /obj/mecha))
				src.target:take_damage(rand(melee_damage_lower,melee_damage_upper))
			else
				src.target:TakeDamage(rand(melee_damage_lower,melee_damage_upper))
		spawn(attack_speed)
			src.attacking = 0
		return

//Contains the procs that control attacking critters
	attackby(obj/item/weapon/W as obj, mob/living/user as mob)
		..()
		if (!src.alive)
			Harvest(W,user)
			return
		var/damage = 0
		switch(W.damtype)
			if ("fire") damage = W.force * firevuln
			if ("brute") damage = W.force * brutevuln
		TakeDamage(damage)
		if (src.defensive)	Target_Attacker(user)
		return

	attack_hand(var/mob/user as mob)
		if (!src.alive)	..()
		if (user.a_intent == "hurt")
			TakeDamage(rand(1,2) * brutevuln)
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <b>[user]</b> punches [src]!", 1)
			playsound(src.loc, pick('punch1.ogg','punch2.ogg','punch3.ogg','punch4.ogg'), 100, 1)
			if (src.defensive)	Target_Attacker(user)
		else
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <b>[user]</b> touches [src]!", 1)

	proc
		patrol_step()
			var/moveto = locate(src.x + rand(-1,1),src.y + rand(-1, 1),src.z)
			if (istype(moveto, /turf/simulated/floor) || istype(moveto, /turf/simulated/shuttle/floor) || istype(moveto, /turf/unsimulated/floor)) step_towards(src, moveto)
			if (src.aggressive) seek_target()
			steps += 1
			if (steps == rand(5,20)) src.task = "thinking"

		seek_target()
			src.anchored = 0
			var/T = null
			for(var/mob/living/C in view(src.seekrange,src))//TODO: mess with this
				if (src.target)
					src.task = "chasing"
					break
				if ((C.name == src.oldtarget_name) && (world.time < src.last_found + 100)) continue
				if (istype(C, /mob/living/carbon/) && !src.atkcarbon) continue
				if (istype(C, /mob/living/silicon/) && !src.atksilicon) continue
				if (C.health < 0) continue
				if (istype(C, /mob/living/carbon/) && src.atkcarbon)	src.attack = 1
				if (istype(C, /mob/living/silicon/) && src.atksilicon)	src.attack = 1
				if (src.attack)
					T = C
					break

			if (!src.attack)
				for(var/obj/critter/C in view(src.seekrange,src))
					if (istype(C, /obj/critter) && !src.atkcritter) continue
					if (istype(C, /obj/mecha) && !src.atkmech) continue
					if (C.health <= 0) continue
					if (istype(C, /obj/critter) && src.atkcritter)
						if ((istype(C, src.type) && !src.atksame) || (C == src))	continue
						src.attack = 1
					if (istype(C, /obj/mecha) && src.atkmech)	src.attack = 1
					if (src.attack)
						T = C
						break

			if (src.attack)
				src.target = T
				src.oldtarget_name = T:name
				src.task = "chasing"
			return

		Die()
			if (!src.alive) return
			src.icon_state += "-dead"
			src.alive = 0
			src.anchored = 0
			src.density = 0
			walk_to(src,0)
			src.visible_message("<b>[src]</b> dies!")

		ChaseAttack()
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>[src]</B> [src.angertext] at [src.target]!", 1)
			return

		RunAttack()
			src.attacking = 1
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>[src]</B> [src.attacktext] [src.target]!", 1)
			if (ismob(src.target))


				var/damage = rand(melee_damage_lower, melee_damage_upper)

				if (istype(target, /mob/living/carbon/human))
					var/dam_zone = pick("head", "chest", "l_hand", "r_hand", "l_leg", "r_leg", "groin")
					if (dam_zone == "chest")
						if ((((target:wear_suit && target:wear_suit.body_parts_covered & UPPER_TORSO) || (target:w_uniform && target:w_uniform.body_parts_covered & LOWER_TORSO)) && prob(10)))
							if (prob(20))
								target:show_message("\blue You have been protected from a hit to the chest.")
								return
					if (istype(target:organs[text("[]", dam_zone)], /datum/organ/external))
						var/datum/organ/external/temp = target:organs[text("[]", dam_zone)]
						if (temp.take_damage(damage, 0))
							target:UpdateDamageIcon()
						else
							target:UpdateDamage()
					target:updatehealth()
				else
					target:bruteloss += damage
				if (attack_sound)
					playsound(loc, attack_sound, 50, 1, -1)
				AfterAttack(target)
			if (isobj(src.target))
				if (istype(target, /obj/mecha))
					src.target:take_damage(rand(melee_damage_lower,melee_damage_upper))
				else
					src.target:TakeDamage(rand(melee_damage_lower,melee_damage_upper))
			spawn(attack_speed)
				src.attacking = 0
			return

		TakeDamage(var/damage = 0)
			var/tempdamage = (damage-armor)
			if (tempdamage > 0)
				src.health -= tempdamage
			else
				src.health--
			if (src.health <= 0)
				src.Die()

		Target_Attacker(var/target)
			if (!target)	return
			src.target = target
			src.oldtarget_name = target:name
			if (task != "chasing")
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <b>[src]</b> [src.angertext] [target:name]!", 1)
			src.task = "chasing"
			return

		Harvest(var/obj/item/weapon/W, var/mob/living/user)
			if ((!W) || (!user))	return 0
			if (src.alive)	return 0
			return 1

		AfterAttack(var/mob/living/target)

/*
TODO:Go over these and see how/if to add them

	proc/set_attack()
		state = 1
		if (path_idle.len) path_idle = new/list()
		trg_idle = null

	proc/set_idle()
		state = 2
		if (path_target.len) path_target = new/list()
		target = null
		frustration = 0

	proc/set_null()
		state = 0
		if (path_target.len) path_target = new/list()
		if (path_idle.len) path_idle = new/list()
		target = null
		trg_idle = null
		frustration = 0

	proc/path_idle(var/atom/trg)
		path_idle = AStar(src.loc, get_turf(trg), /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, anicard, null)
		path_idle = reverselist(path_idle)

	proc/path_attack(var/atom/trg)
		path_target = AStar(src.loc, trg.loc, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, anicard, null)
		path_target = reverselist(path_target)


//Look these over
	var/list/path = new/list()
	var/patience = 35						//The maximum time it'll chase a target.
	var/list/mob/living/carbon/flee_from = new/list()
	var/list/path_target = new/list()		//The path to the combat target.

	var/turf/trg_idle					//It's idle target, the one it's following but not attacking.
	var/list/path_idle = new/list()		//The path to the idle target.

TODO: Figure out how to handle special things like this dont really want to give it to every critter
/obj/critter/proc/CritterTeleport(var/telerange, var/dospark, var/dosmoke)
	if (!src.alive) return
	var/list/randomturfs = new/list()
	for(var/turf/T in orange(src, telerange))
		if (istype(T, /turf/space) || T.density) continue
		randomturfs.Add(T)
	src.loc = pick(randomturfs)
	if (dospark)
		var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
		s.set_up(5, 1, src)
		s.start()
	if (dosmoke)
		var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
		smoke.set_up(10, 0, src.loc)
		smoke.start()
	src.task = "thinking"
*/
