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
	attacktextobject = "bashes"
	attack_sound = 'bite.ogg'
	attack_speed = 10
	var/stunchance = 10 // chance to tackle things down

	process()
		set background = 1
		if (!src.alive)	return
		switch(task)
			if("thinking")
				src.attack = 0
				src.target = null
				sleep(15)
				walk_to(src,0)
				if (src.aggressive) seek_target()
				if (src.wanderer && !src.target) src.task = "wandering"
			if("chasing")
				if (!target_is_object)
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
							//walk_to(src, src.target,1,4)
							if (src.path.len) //Has a path.
								step_to(src, src.path[1])
								src.path -= src.path[1]
							else //No path. Simply walk to it.
								walk_to(src, src.target,1,4)
							if ((get_dist(src, src.target)) >= (olddist))
								src.frustration++
							else
								src.frustration = 0
							sleep(5)
					else src.task = "thinking"
				else //Is an object
					if (src.frustration >= max_frustration)
						src.target = null
						src.last_found = world.time
						src.frustration = 0
						src.task = "thinking"
						walk_to(src,0)
					if (target)
						if (get_dist(src, src.target) <= 1)
							var/obj/O = src.target
							ChaseAttack()
							src.task = "attacking"
							src.anchored = 1
							src.target_lastloc = O.loc
						else
							var/turf/olddist = get_dist(src, src.target)
							//walk_to(src, src.target,1,4)
							if (src.path.len) //Has a path.
								step_to(src, src.path[1])
								src.path -= src.path[1]
							else //No path. Simply walk to it.
								walk_to(src, src.target,1,4)
							if ((get_dist(src, src.target)) >= (olddist))
								src.frustration++
							else
								src.frustration = 0
							sleep(5)
					else src.task = "thinking"
			if("attacking")
				// see if he got away
				if (src.target_is_object) //If the target is an object, break it.
					if ((get_dist(src, src.target) > 1) || ((src.target:loc != src.target_lastloc)))
						src.anchored = 0
						src.task = "chasing"
					else
						if (get_dist(src, src.target) <= 1)
							var/obj/O = src.target
							if(!src.attacking)	RunAttack()
							/*if(O != null)
								if(O.health < 0) //Er...
									src.task = "thinking"
									src.target = null
									src.anchored = 0
									src.last_found = world.time
									src.frustration = 0
									src.attacking = 0*/
						else
							src.anchored = 0
							src.attacking = 0
							src.task = "chasing"
				else //Nope, it's a mob or something.
					if ((get_dist(src, src.target) > 1) || ((src.target:loc != src.target_lastloc)))
						src.anchored = 0
						src.task = "chasing"
					else
						if (get_dist(src, src.target) <= 1)
							var/mob/living/carbon/M = src.target
							if(!src.attacking)	RunAttack()
							if(!src.aggressive)
								src.task = "thinking"
								src.target = null
								src.anchored = 0
								src.last_found = world.time
								src.frustration = 0
								src.attacking = 0
							else
								if(M!=null)
									if(M.health < 0)
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
			if("wandering")
				patrol_step()
				sleep(10)
		spawn(8)
			process()
		return

	RunAttack()
		if (src.target_is_object)
			src.attacking = 1
			//world << "Attacking window!"
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>[src]</B> [src.attacktextobject] [src.target]!", 1)

			var/damage = ((rand(melee_damage_lower, melee_damage_upper)) * 2) //Spesscarp live to genocide objects.

			playsound(loc, attack_sound, 50, 1, -1)

			target:attack_by_critter(damage, src)

			if (src.broke_object)
				//world << "Broke the window!"
				attacking = 0
				target = null
				src.task = "thinking"

			spawn(attack_speed)
				src.attacking = 0
		else
			src.attacking = 1
			for(var/mob/O in viewers(src, null))
				O.show_message("\red <B>[src]</B> [src.attacktext] [src.target]!", 1)
			if(ismob(src.target))


				var/damage = rand(melee_damage_lower, melee_damage_upper)

				if(istype(target, /mob/living/carbon/human))
					var/dam_zone = pick("head", "chest", "l_hand", "r_hand", "l_leg", "r_leg", "groin")
					if (dam_zone == "chest")
						if ((((target:wear_suit && target:wear_suit.body_parts_covered & UPPER_TORSO) || (target:w_uniform && target:w_uniform.body_parts_covered & LOWER_TORSO)) && prob(10)))
							if(prob(20))
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

				if(attack_sound)
					playsound(loc, attack_sound, 50, 1, -1)

				AfterAttack(target)


			if(isobj(src.target))
				if(istype(target, /obj/mecha))
					src.target:take_damage(rand(melee_damage_lower,melee_damage_upper))
				else
					src.target:TakeDamage(rand(melee_damage_lower,melee_damage_upper))
			spawn(attack_speed)
				src.attacking = 0
			return


	seek_target() //Seeks a new target for the carp.
		//world << "Seeking target."
		//Reset these two variables.
		src.target_is_object = 0
		src.broke_object = 0
		src.anchored = 0
		var/T = null
		//Reset the path.
		del path
		path = new()
		//First, make a list of priority objects it can destroy (obstacles to it -- windows, tables, and grilles).
		//var/can_attack_creature = 0

		//TODO: Make it see if there are any creatures in its path. If none, then DESTROY ALL OBJECTS.

		//TODO: Eat food.

		/*
		Reference of the AStar pathfinding. Use it to figure out if the carp can lunch.


		Use:
		your_list = AStar(start location, end location, adjacent turf proc, distance proc)
		For the adjacent turf proc i wrote:
		/turf/proc/AdjacentTurfs
		And for the distance one i wrote:
		/turf/proc/Distance
		So an example use might be:

		src.path_list = AStar(src.loc, target.loc, /turf/proc/AdjacentTurfs, /turf/proc/Distance)

		Note: The path is returned starting at the END node, so i wrote reverselist to reverse it for ease of use.

		src.path_list = reverselist(src.pathlist)

		Then to start on the path, all you need to do it:
		Step_to(src, src.path_list[1])
		src.path_list -= src.path_list[1] or equivilent to remove that node from the list.*/

		var/found = 0

		//TODO: Add support for mowing down a path to target creatures.

		//TODO: Compile a list of targets and randomly choose one.

		for (var/mob/living/C in view(src.seekrange, src)) //Look at all the creatures in range.
			if (found == 0) //Didn't find one.
				//world << "Potential creature: [C.name]"
				var/list[] = new()
				list = AStar(src.loc, C.loc, /turf/proc/AdjacentTurfsSpace, /turf/proc/Distance)
				list = reverselist(list)
				if (list.len != 0)
					//world << "Found a creature."
					//Assign the target.
					//T = C
					//src.attack = 1
					//src.task = "chasing"
					//TODO: Save the pathfinding list?
					//if((C.name == src.oldtarget_name) && (world.time < src.last_found + 100)) continue
					//if(istype(C, /mob/living/carbon/) && !src.atkcarbon) continue
					//if(istype(C, /mob/living/silicon/) && !src.atksilicon) continue
					path = list //Copy this over.
					if(C.health < 0) continue
					if(istype(C, /mob/living/carbon/))	src.attack = 1
					if(istype(C, /mob/living/silicon/))	src.attack = 1
					if(src.attack)
						//world << "Attacking creature [C.name]."
						src.target_is_object = 0
						T = C
						found = 1
						break
			else
				break //Found one. Stop.


		//TODO: Look for objects which seem threatening to it first.

		//TODO: Attack adjacent objects if no threats found. TODO: Only attack if they're visible.
		if (found == 0)
			var/turfs[] = new()
			turfs = call(src.loc, /turf/proc/AdjacentTurfsCritterB)(null)

			for (var/turf/turf in turfs) //Look through all the turfs for an object.
				if (!found) //Only proceed if not found.
					for (var/obj/O in turf.contents) //Look through every object in the turf
						if  (!found) //Didn't find one yet.
							if (!istype(O, /obj/critter/spesscarp) && !istype(O, /obj/item) && !istype(O, /obj/decal) && !istype(O, /obj/multiz)) //Make sure it's not an illegal type.
								//Well, it just found an object.
								found = 1
								src.attack = 1
								T = O
								src.target_is_object = 1
								break
						else
							break //Stop. Found one already.
				else
					break //Stop. Found one already.
			del turfs //Free memory.

		//TODO: Compile a list of targets and randomly choose one.

		if (found == 0) //Didn't find a creature o an adjacent object. Look for all other objects now.
			//world << "No creature found. Looking for an object."
			for (var/obj/O in view(src.seekrange, src)) //Look at all the objects in range.
				if (found == 0) //Didn't find one yet.
					if (!istype(O, /obj/critter/spesscarp) && !istype(O, /obj/item) && !istype(O, /obj/decal)) //Make sure it's not an illegal type.
						//world << "Potential object: [O.name]"
						var/list[] = new()
						list = AStar(src.loc, O.loc, /turf/proc/AdjacentTurfsCritterB, /turf/proc/Distance)
						list = reverselist(list)
						if (list.len != 0)
							//world << "Found an object. Attacking [O.name]"
							//Assign the target.
							found = 1
							src.attack = 1
							T = O
							path = list //Copy this over.
							//src.task = "chasing"
							src.target_is_object = 1
							//TODO: Save the pathfinding list?
							break
				else
					break //Found one. Stop.

		/*if (!can_attack_creature)
			//TODO: Smash the nearest object.
			for(var/obj/O in view(src.seekrange, src)) //Look for an object to smash.
				T = W
				src.attack = 1
				src.task = "chasing"
				src.target_is_object = 1
		else //Creature in range.
			//TODO: Attack that creature.
			if(!src.attack)
				for(var/obj/critter/C in view(src.seekrange,src))
					if(istype(C, /obj/critter) && !src.atkcritter) continue
					if(istype(C, /obj/mecha) && !src.atkmech) continue
					if(C.health <= 0) continue
					if(istype(C, /obj/critter) && src.atkcritter)
						if((istype(C, src.type) && !src.atksame) || (C == src))	continue
						src.attack = 1
					if(istype(C, /obj/mecha) && src.atkmech)	src.attack = 1
					if(src.attack)
						T = C
						break*/

		if(src.attack)
			src.target = T
			src.oldtarget_name = T:name
			src.task = "chasing"
			//world << "src.attack"
		else
			src.task = "wandering" //Nothing to attack. Move around.
			//world << "else"

		return



	Harvest(var/obj/item/weapon/W, var/mob/living/user)
		if(..())
			var/success = 0
			if(istype(W, /obj/item/weapon/butch))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if(istype(W, /obj/item/weapon/kitchenknife))
				new/obj/item/weapon/reagent_containers/food/snacks/carpmeat(src.loc)
				success = 1
			if(success)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red [user.name] cuts apart the [src.name]!", 1)
				del(src)
				return 1
			return 0

	AfterAttack(var/mob/living/target)
		if(prob(stunchance))
			if(target.weakened <= 0)
				target.weakened += rand(10, 15)
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>[src]</B> knocks down [target]!", 1)
				playsound(loc, 'pierce.ogg', 25, 1, -1)



/obj/critter/spesscarp/elite
	desc = "Oh shit, you're really fucked now. It has an evil gleam in its eye."
	health = 50
	max_health = 50
	melee_damage_lower = 20
	melee_damage_upper = 35
	stunchance = 15
	attack_speed = 7
	opensdoors = 1 // would give all access dono if want