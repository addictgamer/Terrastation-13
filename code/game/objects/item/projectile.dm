
/obj/item/projectile
	name = "projectile"
	icon = 'projectiles.dmi'
	icon_state = "bullet"
	density = 1
	throwforce = 0.1 //an attempt to make it possible to shoot your way through space
	unacidable = 1 //Just to be sure.
	anchored = 1 // I'm not sure if it is a good idea. Bullets sucked to space and curve trajectories near singularity could be awesome. --rastaf0
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT // ONBELT???
	mouse_opacity = 0
	var
		def_zone = ""
		//damage_type = PROJECTILE_BULLET
		mob/firer = null
		silenced = 0
		yo = null
		xo = null
		current = null
		turf/original = null

		damage = 51		// damage dealt by projectile. This is used for machinery, livestock, anything not under /mob heirarchy
		flag = "bullet" // identifier flag (bullet, laser, bio, rad, taser). This is to identify what kind of armor protects against the shot


		nodamage = 0 // determines if the projectile will skip any damage inflictions
		list/mobdamage = list(BRUTE = 50, BURN = 0, TOX = 0, OXY = 0, CLONE = 0) // determines what kind of damage it does to mobs
		list/effects = list("stun" = 0, "weak" = 0, "paralysis" = 0, "stutter" = 0, "drowsyness" = 0, "radiation" = 0, "eyeblur" = 0, "emp" = 0) // long list of effects a projectile can inflict on something. !!MUY FLEXIBLE!!~
		list/effectprob = list("stun" = 100, "weak" = 100, "paralysis" = 100, "stutter" = 100, "drowsyness" = 100, "radiation" = 100, "eyeblur" = 100, "emp" = 100) // Probability for an effect to execute
		list/effectmod = list("stun" = SET, "weak" = SET, "paralysis" = SET, "stutter" = SET, "drowsyness" = SET, "radiation" = SET, "eyeblur" = SET, "emp" = SET) // determines how the effect modifiers will effect a mob's variable


		bumped = 0

	weakbullet
		damage = 8
		mobdamage = list(BRUTE = 8, BURN = 0, TOX = 0, OXY = 0, CLONE = 0)
		New()
			..()
			effects["weak"] = 15
			effects["stun"] = 15
			effects["stutter"] = 5
			effects["eyeblur"] = 5

	midbullet
		damage = 8
		mobdamage = list(BRUTE = 32, BURN = 0, TOX = 0, OXY = 0, CLONE = 0)
		New()
			..()
			effects["weak"] = 10
			effects["stun"] = 10

	suffocationbullet
		damage = 50
		mobdamage = list(BRUTE = 50, BURN = 0, TOX = 0, OXY = 15, CLONE = 0)

	cyanideround
		damage = 50
		mobdamage = list(BRUTE = 50, BURN = 0, TOX = 100, OXY = 15, CLONE = 0)

	burstbullet
		damage = 20
		mobdamage = list(BRUTE = 20, BURN = 0, TOX = 0, OXY = 0, CLONE = 0)

	beam
		name = "laser"
		icon_state = "laser"
		pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
		damage = 20
		mobdamage = list(BRUTE = 0, BURN = 20, TOX = 0, OXY = 0, CLONE = 0)
		flag = "laser"
		New()
			..()
			effects["eyeblur"] = 5
			effectprob["eyeblur"] = 50

		pulse
			name = "pulse"
			icon_state = "u_laser"
			damage = 50
			mobdamage = list(BRUTE = 10, BURN = 40, TOX = 0, OXY = 0, CLONE = 0)

	heavylaser
		name = "heavy laser"
		icon_state = "heavylaser"
		pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
		damage = 40
		mobdamage = list(BRUTE = 0, BURN = 40, TOX = 0, OXY = 0, CLONE = 0)
		flag = "laser"
		New()
			..()
			effects["eyeblur"] = 10
			effectprob["eyeblur"] = 100

	deathlaser
		name = "death laser"
		icon_state = "heavylaser"
		pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
		damage = 60
		mobdamage = list(BRUTE = 10, BURN = 60, TOX = 0, OXY = 0, CLONE = 0)
		flag = "laser"
		New()
			..()
			effects["eyeblur"] = 20
			effectprob["eyeblur"] = 100
			effects["weak"] = 5
			effectprob["weak"] = 15

	fireball
		name = "shock"
		icon_state = "fireball"
		pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
		damage = 25
		mobdamage = list(BRUTE = 0, BURN = 25, TOX = 0, OXY = 0, CLONE = 0)
		flag = "laser"
		New()
			..()
			effects["stun"] = 10
			effects["weak"] = 10
			effects["stutter"] = 10
			effectprob["weak"] = 25
	gyro
		name ="gyro"
		icon_state= "bolter"
		pass_flags = PASSTABLE
		damage = 50
		mobdamage = list(BRUTE = 50, BURN = 0, TOX = 0, OXY = 0, CLONE = 0)
		flag = "bullet"
		New()
			..()
			effects["weak"] = 10
			effects["stun"] = 10

	declone
		name = "declown"
		icon_state = "declone"
		pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
		damage = 0
		mobdamage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, CLONE = 40)
		flag = "bio"
		New()
			..()
			effects["radiation"] = 70
			effectmod["radiation"] = ADD

	dart
		name = "dart"
		icon_state = "toxin"
		flag = "bio"
		damage = 0
		mobdamage = list(BRUTE = 0, BURN = 0, TOX = 10, OXY = 0, CLONE = 0)
		New()
			..()
			effects["weak"] = 5
			effectmod["weak"] = ADD

	electrode
		name = "electrode"
		icon_state = "spark"
		flag = "taser"
		damage = 0
		nodamage = 1
		New()
			..()
			effects["stun"] = 10
			effects["weak"] = 10
			effects["stutter"] = 10
			effectprob["weak"] = 25

	ion
		name = "ion bolt"
		icon_state = "ion"
		flag = "taser"
		damage = 0
		nodamage = 1
		New()
			..()
			effects["emp"] = 1
			effectprob["emp"] = 80

	stunshot
		name = "stunshot"
		icon_state = "bullet"
		flag = "stunshot"
		damage = 5
		mobdamage = list(BRUTE = 5, BURN = 0, TOX = 0, OXY = 0, CLONE = 0)
		New()
			..()
			effects["stun"] = 20
			effects["weak"] = 20
			effects["stutter"] = 20
			effectprob["weak"] = 45

	bolt
		name = "bolt"
		icon_state = "cbbolt"
		flag = "taser"
		damage = 0
		nodamage = 1
		New()
			..()
			effects["weak"] = 10
			effects["stutter"] = 10

	largebolt
		name = "largebolt"
		icon_state = "cbbolt"
		flag = "rad"
		damage = 20
		mobdamage = list(BRUTE = 10, BURN = 0, TOX = 10, OXY = 0, CLONE = 0)
		New()
			..()
			effects["radiation"] = 40
			effectprob["radiation"] = 95
			effects["drowsyness"] = 10
			effectprob["drowsyness"] = 25
			effectmod["radiation"] = ADD
			effectmod["drowsyness"] = SET

	freeze
		name = "freeze beam"
		icon_state = "ice_2"
		damage = 0
		var/temperature = 0

		proc/Freeze(atom/A as mob|obj|turf|area)
			if (istype(A, /mob))
				var/mob/M = A
				if (M.bodytemperature > temperature)
					M.bodytemperature = temperature

	plasma
		name = "plasma blast"
		icon_state = "plasma_2"
		damage = 0
		var/temperature = 800

		proc/Heat(atom/A as mob|obj|turf|area)
			if (istype(A, /mob/living/carbon))
				var/mob/M = A
				if (M.bodytemperature < temperature)
					M.bodytemperature = temperature




	Bump(atom/A as mob|obj|turf|area)
		if (A == firer)
			loc = A.loc
			return // cannot shoot yourself

		if (bumped) return

		bumped = 1
		if (firer && istype(A, /mob))
			var/mob/M = A
			if (!istype(A, /mob/living))
				loc = A.loc
				return // nope.avi

			if (!silenced)
				/*
				for(var/mob/O in viewers(M))
					O.show_message("\red [A.name] has been shot by [firer.name]!", 1) */

				visible_message("\red [A.name] has been shot by [firer.name]!", "\blue You hear a [istype(src, /obj/item/projectile/beam) ? "gunshot" : "laser blast"]!")
			else
				M << "\red You've been shot!"
			if (istype(firer, /mob))
				M.attack_log += text("\[[]\] <b>[]/[]</b> shot <b>[]/[]</b> with a <b>[]</b>", time_stamp(), firer, firer.ckey, M, M.ckey, src)
				firer.attack_log += text("\[[]\] <b>[]/[]</b> shot <b>[]/[]</b> with a <b>[]</b>", time_stamp(), firer, firer.ckey, M, M.ckey, src)
			else
				M.attack_log += text("\[[]\] <b>UNKOWN SUBJECT (No longer exists)</b> shot <b>[]/[]</b> with a <b>[]</b>", time_stamp(), M, M.ckey, src)
		spawn(0)
			if (A)

				if (istype(src, /obj/item/projectile/freeze))
					var/obj/item/projectile/freeze/F = src
					F.Freeze(A)
				else if (istype(src, /obj/item/projectile/plasma))
					var/obj/item/projectile/plasma/P = src
					P.Heat(A)
				else

					A.bullet_act(src, def_zone)
					if (istype(A,/turf) && !istype(src, /obj/item/projectile/beam))
						for(var/obj/O in A)
							O.bullet_act(src, def_zone)

			// Okay this code, along with the sleep(10) {del(src)} up ahead is to make
			// sure the projectile doesn't cut off any procs it's executing. this may seem
			// incredibly stupid, I know, but it's to workaround pesky runtime error spam
			invisibility = 101
			loc = locate(1,1,1)

		sleep(10)
		del(src) // wait exactly 1 second, then delete itself. See above comments ^

		return

	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if (air_group || (height==0)) return 1

		if (istype(mover, /obj/item/projectile))
			return prob(95)
		else
			return 1

	process()
		spawn while(src)

			if ((!( current ) || loc == current))
				current = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z)
			if ((x == 1 || x == world.maxx || y == 1 || y == world.maxy))
				del(src)
				return
			step_towards(src, current)

			sleep( 1 )

			if (!bumped)
				if (loc == original)
					for(var/mob/living/M in original)
						Bump(M)
						sleep( 1 )

		return
