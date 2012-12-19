
/obj/critter/hivebot/tele//this still needs work
	name = "Beacon"
	desc = "Some odd beacon thing"
	icon = 'Hivebot.dmi'
	icon_state = "def_radar-off"
	health = 100
	max_health = 100
	aggressive = 0
	wanderer = 0
	opensdoors = 0
	atkcarbon = 0
	atksilicon = 0
	atkcritter = 0
	atksame = 0
	atkmech = 0
	firevuln = 0.5
	brutevuln = 1
	seekrange = 2
	armor = 10

	var
		bot_type = "norm"
		bot_amt = 10
		spawn_delay = 600
		turn_on = 0
		auto_spawn = 1

	proc
		warpbots()

	New()
		..()
		var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
		smoke.set_up(5, 0, src.loc)
		smoke.start()
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>The [src] warps in!</B>", 1)
		playsound(src.loc, 'EMPulse.ogg', 25, 1)
		if(auto_spawn)
			spawn(spawn_delay)
				turn_on = 1
				auto_spawn = 0


	warpbots()
		icon_state = "def_radar"
		for(var/mob/O in viewers(src, null))
			O.show_message("\red The [src] turns on!", 1)
		while(bot_amt > 0)
			bot_amt--
			switch(bot_type)
				if("norm")
					new /obj/critter/hivebot(get_turf(src))
				if("range")
					new /obj/critter/hivebot/range(get_turf(src))
				if("rapid")
					new /obj/critter/hivebot/rapid(get_turf(src))
				if("borg")
					new /obj/critter/hivebot/borg(get_turf(src))
		spawn(100)
			del(src)
		return


	process()
		if((health < (max_health/2)) && (!turn_on))
			//if(prob(2))//Might be a bit low, will mess with it likely
			//	turn_on = 1
			turn_on = 1
		if(turn_on == 1)
			warpbots()
			turn_on = 2
		..()
