/* Here we have stuff like the npc_process proc */

/mob/living/carbon/human/proc/npc_process()
	if(space_pirate) //If it's a space pirate...
		if(!npc_data)
			npc_data = new /datum/npc_variables(src)
			npc_data.actively_seek_attack_targets = 1

		//TODO: Make them look for valuable items.
		//TODO: Make them look for non-space-pirates in sight and target them.

		//if(!npc_data.task)// || npc_data.thought == "")
		//	var/list/mobs
			//for(var/mob/living/M in range(world.view, src)) //Find any living mobs in the sight of this guy.
		//	for(var/mob/living/M in view(12, src)) //Find any living mobs in the sight of this guy.
		//		if(istype(M, /mob/living/carbon/human))
		//			if(!M:space_pirate) //If not a space pirate.
		//				mobs += M
		//	var/mob/living/target_mob = null
		//	target_mob = pick(mobs) //Choose a target.
		//	if(target_mob) //Found a target.
				//world << "Found target for space pirate."
		//		var/datum/npc_task/new_task = new /datum/npc_task(npc_data)
		//		new_task.task_type = "attack mob"
		//		new_task.target = target_mob
		//		npc_data.assign_task(new_task)

		npc_data.process()
	else
		if(!npc_data)
			npc_data = new /datum/npc_variables(src)

		//if(npc_data.task == "")
		//	var/direct = pick(1, 2, 3, 4)
		//	src.Move(null, direct)
		npc_data.process()