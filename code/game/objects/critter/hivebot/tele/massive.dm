
/obj/critter/hivebot/tele/massive
	bot_type = "borg"
	bot_amt = 25
	auto_spawn = 1
	spawn_delay = 100


	New()
		..()
		var/datum/effects/system/harmless_smoke_spread/smoke = new /datum/effects/system/harmless_smoke_spread()
		smoke.set_up(5, 0, src.loc)
		smoke.start()
		bot_amt = rand(25, 100)
		for(var/mob/O in viewers(src, null))
			O.show_message("\red <B>The [src] warps in!</B>", 1)
		playsound(src.loc, 'EMPulse.ogg', 25, 1)
		if (auto_spawn)
			spawn(spawn_delay)
				turn_on = 1
				auto_spawn = 0
