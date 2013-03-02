
/*
TODO:
var mob/living/carbon/mobtarget is old target from magicmonster.dm which was merged into here.
Find a way to make the mob use /obj/critter vars so we can get rid of this
*/


#define viewrange 7 //min 2

/obj/critter/creature
	name = "creature"
	desc = "A sanity-destroying otherthing."
	icon = 'otherthing.dmi'
	icon_state = "otherthing"
	unacidable = 1 //Creature is not harmed by acid.
	health = 80
	max_health = 80
	aggressive = 1
	defensive = 1
	wanderer = 1
	opensdoors = 1
	atkcarbon = 1
	atksilicon = 1
	atkcritter = 1
	atkmech = 1
	atksame = 1
	firevuln = 1
	brutevuln = 1
	melee_damage_lower = 25
	melee_damage_upper = 50
	angertext = "runs"
	attacktext = "chomps"
	flags = 258.0
	var
		state = 0
		list/path_target = new/list()
		turf/trg_idle
		list/path_idle = new/list()
		cycle_pause = 5
		mob/living/carbon/mobtarget

	New()
		..()
		health = max_health
		src.process()

	examine()
		set src in view()
		..()
		if(!alive)
			usr << text("\red <B>the thing isn't moving</B>")
		else if (src.health > 15)
			usr << text("\red <B>A sanity-destroying otherthing.</B>")
		else
			usr << text("\red <B>the thing looks hurt</B>")
		return


	attack_hand(user as mob)
		return

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		switch(W.damtype)
			if("fire")
				src.health -= W.force * 2
			if("brute")
				src.health -= W.force * 1
			else
		if (src.health <= 0)
			src.death()
		else if (W.force)
			if(ishuman(user) || ismonkey(user))
				src.mobtarget = user
				src.state = 1
		..()

	process()
		set background = 1
		var/quick_move = 0

		if (!alive)
			return

		if (!mobtarget)
			if (path_target.len) path_target = new/list()

			var/last_health = INFINITY

			for (var/mob/living/carbon/C in range(viewrange-2,src.loc))
				if (C.stat == 2 || !can_see(src,C,viewrange))
					continue
				if(C:stunned || C:paralysis || C:weakened)
					mobtarget = C
					break
				if(C:health < last_health)
					last_health = C:health
					mobtarget = C

			if(mobtarget)
				set_attack()
			else if(state != 2)
				set_idle()
				idle()

		else if(mobtarget)
			var/turf/distance = get_dist(src, mobtarget)
			set_attack()

			if(can_see(src,mobtarget,viewrange))
				if(distance <= 1)
					for(var/mob/O in viewers(world.view,src))
						O.show_message("\red <B>[src.mobtarget] has been attacked by [src]!</B>", 1, "\red You hear the sounds of combat", 2)
					mobtarget:bruteloss += rand(1,10)
					sleep(5)
					//target:paralysis = max(target:paralysis, 10)

				else
					step_towards(src,get_step_towards2(src , mobtarget))
					set_null()
					spawn(cycle_pause) src.process()
					return

			else
				if( !path_target.len )

					path_attack(mobtarget)
					if(!path_target.len)
						set_null()
						spawn(cycle_pause) src.process()
						return
				else
					var/turf/next = path_target[1]

					if(next in range(1,src))
						path_attack(mobtarget)

					if(!path_target.len)
						src.frustration += 5
					else
						next = path_target[1]
						path_target -= next
						step_towards(src,next)
						quick_move = 1

			if (get_dist(src, src.mobtarget) >= distance) src.frustration++
			else src.frustration--
			if(frustration >= 35) set_null()

		if(quick_move)
			spawn(cycle_pause/2)
				src.process()
		else
			spawn(cycle_pause)
				src.process()

	bullet_act(var/obj/item/projectile/Proj)
		health -= round(Proj.damage / 2)
		healthcheck()

	ex_act(severity)
		switch(severity)
			if(1.0)
				src.death()
			if(2.0)
				src.health -= 15
				healthcheck()
		return

	meteorhit()
		src.death()
		return

	blob_act()
		if(prob(50))
			src.death()
		return

	Bumped(AM as mob|obj)
		if(ismob(AM) && (ishuman(AM) || ismonkey(AM)) )
			src.mobtarget = AM
			set_attack()
		else if(ismob(AM))
			spawn(0)
				var/turf/T = get_turf(src)
				AM:loc = T

	Bump(atom/A)
		if(ismob(A) && (ishuman(A) || ismonkey(A)))
			src.mobtarget = A
			set_attack()
		else if(ismob(A))
			src.loc = A:loc

	temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
		if(exposed_temperature > 200)
			health -= 5
			healthcheck()

	proc
		death()
			if(!alive) return
			src.alive = 0
			density = 0
			icon_state = "dead"
			set_null()
			for(var/mob/O in hearers(src, null))
				O.show_message("\red <B>[src] falls over dead!</B>", 1)

		healthcheck()
			if (src.health <= 0)
				src.death()


		path_attack(var/atom/trg)
			mobtarget = trg
			path_target = AStar(src.loc, mobtarget.loc, /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, null, null)
			path_target = reverselist(path_target)


		path_idle(var/atom/trg)
			path_idle = AStar(src.loc, get_turf(trg), /turf/proc/CardinalTurfsWithAccess, /turf/proc/Distance, 0, 250, null, null)
			path_idle = reverselist(path_idle)

		idle()
			set background = 1
			var/quick_move = 0

			if(state != 2 || !alive || mobtarget) return

			if(!path_idle.len)
				path_idle(trg_idle)
				if(!path_idle.len)
					trg_idle = null
					set_idle()
					spawn(cycle_pause) src.idle()
					return
				else
					step(src,pick(cardinal))

			else

				if(can_see(src,trg_idle,viewrange))
					switch(get_dist(src, trg_idle))
						if(1)
							if(istype(trg_idle,/obj/alien/weeds))
								step_towards(src,get_step_towards2(src , trg_idle))
						if(2 to INFINITY)
							step_towards(src,get_step_towards2(src , trg_idle))
							if(path_idle.len) path_idle = new/list()
						/*
						if(viewrange+1 to INFINITY)
							step_towards(src,get_step_towards2(src , trg_idle))
							if(path_idle.len) path_idle = new/list()
							quick_move = 1
						*/
				else
					var/turf/next = path_idle[1]
					if(!next in range(1,src))
						path_idle(trg_idle)

					if(!path_idle.len)
						spawn(cycle_pause) src.idle()
						return
					else
						next = path_idle[1]
						path_idle -= next
						step_towards(src,next)
						quick_move = 1

			if(quick_move)
				spawn(cycle_pause/2)
					idle()
			else
				spawn(cycle_pause)
					idle()

		set_null()
			state = 0
			if (path_target.len) path_target = new/list()
			if (path_idle.len) path_idle = new/list()
			mobtarget = null
			trg_idle = null
			frustration = 0

		set_idle()
			state = 2
			if (path_target.len) path_target = new/list()
			mobtarget = null
			frustration = 0

		set_attack()
			state = 1
			if(path_idle.len) path_idle = new/list()
			trg_idle = null
