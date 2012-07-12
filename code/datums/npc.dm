/datum/npc_variables
	var
		thought = "" //The NPC's current thought.

	var/datum/npc_task/task = null //The NPC's current task.

	var/mob/owner //The owner of this.

	var/list/thoughts //The NPC's past thoughts.
	var/list/previous_tasks //The NPC's previous tasks. Best to max it at 10 or something.

	var/actively_seek_attack_targets = 0

	proc
		think(var/new_thought)
		assign_task(var/new_task)


/datum/npc_variables/New(var/mob/_owner)
	owner = _owner


/datum/npc_variables/think(var/new_thought)
	thoughts += thought //Save the old thought.
	thought = new_thought //Assign the current thought.


/datum/npc_variables/assign_task(var/new_task)
	if(task)
		del(task)
	task = new_task

/datum/npc_variables/proc/process()
	if(task)
		task.process()
	else if(thought != "do nothing")
		if(owner.health > 0) //if not dead
			var/datum/npc_task/new_task = new /datum/npc_task(src)
			assign_task(new_task)



/datum/npc_task
	var
		target = null //The task's current target.
		task_type = "" //The tpye of task it is.
		where_to_equip_item = null //If it's task involves equipping an item, this specifies where to equip it.

	/* Task types:
	 * "get item"
	 * - Gets the item specified by target.
	 * "walk around"
	 * - Randomly walk around.
	 */

	var/datum/npc_variables/owner

	proc
		target(var/new_target)
		attack_mob()


/datum/npc_task/New(var/datum/npc_variables/_owner)
	owner = _owner

/datum/npc_task/target(var/new_target)
	target = new_target

datum/npc_task/proc/process()
	var/do_not_proceed = 0
	if(owner.owner.health <= 0) //if dead or otherwise can't do anything
		do_not_proceed = 1

	if(owner.owner.monkeyizing)
		do_not_proceed = 1
		owner.owner.say("AAAAAH, MY BODY IS TRANSFORMING!!!")

	if(do_not_proceed)
		owner.think("do nothing")
		//world << "Dead npc"
		del owner.task
		return //Do nothing.

	if(owner.owner.eye_blind)
		world << "eye blinded"
	if(owner.owner.blinded)
		world << "blinded"

	//TODO: Stand up if lying down.

	if(owner.actively_seek_attack_targets && !owner.owner.eye_blind && !owner.owner.blinded && !owner.owner.sleeping && !owner.owner.resting && !owner.owner.lying)
		var/list/targets[0]
		//for(var/mob/living/M in range(world.view, src)) //Find any living mobs in the sight of this guy.
		for(var/mob/living/M in view(12, owner.owner)) //Find any living mobs in the sight of this guy.
			if(istype(M, /mob/living/carbon/human))
				if(!M:space_pirate) //If not a space pirate.
					var/mob/living/carbon/human/the_human = M
					targets += the_human //TODO: runtime error: type mismatch: the human (/mob/living/carbon/human) += Emmanuel Cox
			else
				targets += M
		for(var/obj/mecha/M in view(12, owner.owner)) //Find mechas.
			//TODO: Check if mecha is operational
			if(M.health > 0)
				targets += M
		for(var/obj/machinery/bot/B in view(12, owner.owner)) //Find bots.
			targets += B
		var/the_target = null
		var/done = 0
		while(!done)
			the_target = pick(targets) //Choose a target.
			if(the_target)
				//TODO: Make this code work with mechas and bots and stuff too.
				if(istype(the_target, /mob))
					if(the_target:health > 0 && !istype(the_target, /mob/dead/observer))
						done = 1
					else
						targets -= the_target
				else
					done = 1
			else
				done = 1

		if(the_target) //Found a target.
			//TODO: Check if alive.
			//world << "Found target."
			var/datum/npc_task/new_task = new /datum/npc_task(owner)
			if(istype(the_target, /mob))
				new_task.task_type = "attack mob"
			else if(istype(the_target, /obj/mecha))
				new_task.task_type = "attack mecha"
			else if(istype(the_target, /obj/machinery/bot))
				new_task.task_type = "attack bot"
			new_task.target = the_target
			//var/datum/npc_task/old_owner = owner
			//del owner.task
			owner.assign_task(new_task)

	if(task_type == "walk around"  && !owner.owner.eye_blind && !owner.owner.blinded && !owner.owner.sleeping && !owner.owner.resting && !owner.owner.lying && owner.owner.canmove && !owner.owner.stunned) //Randomly walk around.
		var/direct = pick("NORTH", "SOUTH", "EAST", "WEST") //Choose a direction.

		//if(can_move_to_that_turf()) //Todo: Find out if it can move to that turf.
		//	owner.owner.Move(null, direct)

		//owner.owner.Move(null, text2dir(direct))
		owner.owner.Move(get_step(owner.owner, pick(cardinal)))
	else if(task_type == "attack mob"  && !owner.owner.eye_blind && !owner.owner.blinded  && !owner.owner.sleeping && !owner.owner.resting && !owner.owner.lying && !owner.owner.stunned)
		//world << "Attacking something."
		//if(istype(target, /mob))
		//	world << "Target is a mob."

		attack_mob() //Have it attack the mob.
	else if(task_type == "attack mecha"  && !owner.owner.eye_blind && !owner.owner.blinded && !owner.owner.sleeping && !owner.owner.resting && !owner.owner.lying && !owner.owner.stunned)
		attack_mecha() //Have it attack the mecha.
	else if(task_type == "attack bot"  && !owner.owner.eye_blind && !owner.owner.blinded && !owner.owner.sleeping && !owner.owner.resting && !owner.owner.lying && !owner.owner.stunned)
		attack_bot()
	else if(task_type == "")
		//Assign new task.

		task_type = "walk around" //Just have it walk around.

	else
		//Unknown> Walk around.
		task_type = "walk around" //Just have it walk around for now.

/datum/npc_task/attack_mob()
	//if(!owner.owner.l_hand && !owner.owner.r_hand)
		//TODO: See if it has a weapon somewhere on them.
		//If has one, equip it.
		//If has none, then cancel attacking.

		//var/obj/item/weapon/weapon = null
		//weapon = owner.owner.find_weapon_on_self()
		//if(!weapon) //If it didn't find a weapon.

	if(!istype(target, /mob))
		//world << "Invalid target."
		del owner.task
		return

	if(target:health <= 0)
		//world << "Killed target."
		del owner.task

	var/obj/item/weapon = null

	if(owner.owner.l_hand)
		if(istype(owner.owner.l_hand, /obj/item/weapon))
			//Found a weapon.
			weapon = owner.owner.l_hand
	if(owner.owner.r_hand)
		if(istype(owner.owner.r_hand, /obj/item/weapon))
			weapon = owner.owner.r_hand

	//if(weapon)
		//TODO: Attack the target.
		//world << "Weapon."
	//else
		//No weapon. Cancel attack.
		//world << "No weapon."

	//TODO: Attack.

	//TODO: If gun, shoot.
	//TODO: If out of ammo, see if have other gun or can refill. Switch weapons in either case.
	//TODO: Melee.
	//TODO: Barehanded if needed.

	//Dirty hack for now, just to get something out there.

	//TODO: Check if the enemy is dead.

	var/obj/item/projectile/midbullet/A = new /obj/item/projectile/midbullet(owner.owner.loc)

	if(!A)
		//world << "!A"
		return

	//if(!istype(target, /turf))
	//	del(A)
	//	return
	//world << owner.owner.loc
	A.current = target:loc
	A.yo = target:y - owner.owner.y
	A.xo = target:x - owner.owner.x
	playsound(owner.owner, 'Gunshot.ogg', 100, 1)
	spawn(0)
		A.process()
	return

/datum/npc_task/proc/attack_mecha()
	//if(!owner.owner.l_hand && !owner.owner.r_hand)
		//TODO: See if it has a weapon somewhere on them.
		//If has one, equip it.
		//If has none, then cancel attacking.

		//var/obj/item/weapon/weapon = null
		//weapon = owner.owner.find_weapon_on_self()
		//if(!weapon) //If it didn't find a weapon.

	if(!istype(target, /obj/mecha))
		//world << "Invalid target."
		del owner.task
		return

	if(target:health <= 0)
		//world << "Killed target."
		del owner.task

	var/obj/item/weapon = null

	if(owner.owner.l_hand)
		if(istype(owner.owner.l_hand, /obj/item/weapon))
			//Found a weapon.
			weapon = owner.owner.l_hand
	if(owner.owner.r_hand)
		if(istype(owner.owner.r_hand, /obj/item/weapon))
			weapon = owner.owner.r_hand

	//if(weapon)
		//TODO: Attack the target.
		//world << "Weapon."
	//else
		//No weapon. Cancel attack.
		//world << "No weapon."

	//TODO: Attack.

	//TODO: If gun, shoot.
	//TODO: If out of ammo, see if have other gun or can refill. Switch weapons in either case.
	//TODO: Melee.
	//TODO: Barehanded if needed.

	//Dirty hack for now, just to get something out there.

	//TODO: Check if the enemy is dead.

	var/obj/item/projectile/midbullet/A = new /obj/item/projectile/midbullet(owner.owner.loc)

	if(!A)
		//world << "!A"
		return

	//if(!istype(target, /turf))
	//	del(A)
	//	return
	//world << owner.owner.loc
	A.current = target:loc
	A.yo = target:y - owner.owner.y
	A.xo = target:x - owner.owner.x
	playsound(owner.owner, 'Gunshot.ogg', 100, 1)
	spawn(0)
		A.process()
	return



/datum/npc_task/proc/attack_bot()
	//if(!owner.owner.l_hand && !owner.owner.r_hand)
		//TODO: See if it has a weapon somewhere on them.
		//If has one, equip it.
		//If has none, then cancel attacking.

		//var/obj/item/weapon/weapon = null
		//weapon = owner.owner.find_weapon_on_self()
		//if(!weapon) //If it didn't find a weapon.

	if(!istype(target, /obj/machinery/bot))
		//world << "Invalid target."
		del owner.task
		return

	if(target:health <= 0)
		//world << "Killed target."
		del owner.task

	var/obj/item/weapon = null

	if(owner.owner.l_hand)
		if(istype(owner.owner.l_hand, /obj/item/weapon))
			//Found a weapon.
			weapon = owner.owner.l_hand
	if(owner.owner.r_hand)
		if(istype(owner.owner.r_hand, /obj/item/weapon))
			weapon = owner.owner.r_hand

	//if(weapon)
		//TODO: Attack the target.
		//world << "Weapon."
	//else
		//No weapon. Cancel attack.
		//world << "No weapon."

	//TODO: Attack.

	//TODO: If gun, shoot.
	//TODO: If out of ammo, see if have other gun or can refill. Switch weapons in either case.
	//TODO: Melee.
	//TODO: Barehanded if needed.

	//Dirty hack for now, just to get something out there.

	//TODO: Check if the enemy is dead.

	var/obj/item/projectile/midbullet/A = new /obj/item/projectile/midbullet(owner.owner.loc)

	if(!A)
		//world << "!A"
		return

	//if(!istype(target, /turf))
	//	del(A)
	//	return
	//world << owner.owner.loc
	A.current = target:loc
	A.yo = target:y - owner.owner.y
	A.xo = target:x - owner.owner.x
	playsound(owner.owner, 'Gunshot.ogg', 100, 1)
	spawn(0)
		A.process()
	return