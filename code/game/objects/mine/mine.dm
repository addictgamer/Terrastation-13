
/obj/mine
	name = "Mine"
	desc = "I Better stay away from that thing."
	density = 1
	anchored = 1
	layer = 3
	icon = 'weapons.dmi'
	icon_state = "uglymine"
	var
		triggerproc = "explode" //name of the proc thats called when the mine is triggered
		triggered = 0

	New()
		icon_state = "uglyminearmed"

	HasEntered(AM as mob|obj)
		Bumped(AM)

	Bumped(mob/M as mob|obj)
		if (triggered) return
		if (istype(M, /mob/living/carbon/human) || istype(M, /mob/living/carbon/monkey))
			for(var/mob/O in viewers(world.view, src.loc))
				O << text("<font color='red'>[M] triggered the \icon[] [src]</font>", src)
			triggered = 1
			call(src,triggerproc)(M)

	proc
		triggerrad(obj)
			var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			obj:radiation += 50
			randmutb(obj)
			domutcheck(obj,null)
			spawn(0)
				del(src)

		triggerstun(obj)
			obj:stunned += 30
			var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			spawn(0)
				del(src)

		triggern2o(obj)
			//example: n2o triggerproc
			//note: im lazy
			for (var/turf/simulated/floor/target in range(1,src))
				if (!target.blocks_air)
					if (target.parent)
						target.parent.suspend_group_processing()
					var/datum/gas_mixture/payload = new
					var/datum/gas/sleeping_agent/trace_gas = new
					trace_gas.moles = 30
					payload += trace_gas
					target.air.merge(payload)
			spawn(0)
				del(src)

		triggerplasma(obj)
			for (var/turf/simulated/floor/target in range(1,src))
				if (!target.blocks_air)
					if (target.parent)
						target.parent.suspend_group_processing()
					var/datum/gas_mixture/payload = new
					payload.toxins = 30
					target.air.merge(payload)
					target.hotspot_expose(1000, CELL_VOLUME)
			spawn(0)
				del(src)

		triggerkick(obj)
			var/datum/effects/system/spark_spread/s = new /datum/effects/system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			del(obj:client)
			spawn(0)
				del(src)

		explode(obj)
			explosion(loc, 0, 1, 2, 3)
			spawn(0)
				del(src)
