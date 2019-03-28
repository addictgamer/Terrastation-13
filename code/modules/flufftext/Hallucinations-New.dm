#define HAL_LINES_FILE "hallucination.json"

#define HALLUCINATION_MINOR		1
#define HALLUCINATION_MEDIUM	51
#define HALLUCINATION_MAJOR		86



/mob/living/carbon
	var/image/halimage
	var/image/halbody
	var/obj/halitem

/mob/living/carbon/proc/handle_hallucinations()
	var/list/static/hallucination_list = init_hallucinations()
	if(!hallucination)
		return
	var/list/valid_hallucinations
	for(var/x in 2 to hallucination_list.len step 2)
		if(hallucination_list[x - 1] <= hallucination)
			valid_hallucinations = hallucination_list[x]
	if(!valid_hallucinations)
		return
	var/halpick = pickweight(valid_hallucinations)
	new halpick(src, FALSE)

/datum/hallucination
	var/natural = TRUE
	var/mob/living/carbon/target
	var/feedback_details //extra info for investigate
	var/weight = 0
	var/severity = 0

/proc/init_hallucinations()
	var/list/all_hallucinations = typesof(/datum/hallucination)
	var/list/standard_hallucinations = list(HALLUCINATION_MINOR, list(), HALLUCINATION_MEDIUM, list(), HALLUCINATION_MAJOR, list() )
	for(var/x in 2 to standard_hallucinations.len step 2)
			var/list/L = standard_hallucinations[x]
			for(var/datum/hallucination/D in all_hallucinations)
				if(D.severity == standard_hallucinations[x - 1]
					L[D] = D.weight
	return standard_hallucinations

/datum/hallucination/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	target = C
	natural = !forced

/datum/hallucination/proc/wake_and_restore()
	target.hal_screwyhud = SCREWYHUD_NONE
	target.SetSleeping(0)

/datum/hallucination/Destroy()
	target.investigate_log("was afflicted with a hallucination of type [type] by [natural?"hallucination status":"an external source"]. [feedback_details]", INVESTIGATE_HALLUCINATIONS)
	target = null
	return ..()

//Returns a random turf in a ring around the target mob, useful for sound hallucinations
/datum/hallucination/proc/random_far_turf()
	var/x_based = prob(50)
	var/first_offset = pick(-8,-7,-6,-5,5,6,7,8)
	var/second_offset = rand(-8,8)
	var/x_off
	var/y_off
	if(x_based)
		x_off = first_offset
		y_off = second_offset
	else
		y_off = first_offset
		x_off = second_offset
	var/turf/T = locate(target.x + x_off, target.y + y_off, target.z)
	return T

/obj/effect/hallucination
	invisibility = INVISIBILITY_OBSERVER
	var/mob/living/carbon/target = null

/obj/effect/hallucination/simple/New(loc, mob/living/carbon/T)
	..()
	target = T
	current_image = GetImage()
	if(target.client)
		target.client.images |= current_image

/obj/effect/hallucination/simple/proc/GetImage()
	var/image/I = image(image_icon, src, image_state, image_layer, dir = dir)
	I.pixel_x = px
	I.pixel_y = py
	if(col_mod)
		I.color = col_mod
	return I

/obj/effect/hallucination/simple/proc/Show(update = 1)
	if(active)
		if(target.client)
			target.client.images.Remove(current_image)
		if(update)
			current_image = GetImage()
		if(target.client)
			target.client.images |= current_image

/obj/effect/hallucination/simple/update_icon(new_state, new_icon, new_px = 0, new_py = 0)
	image_state = new_state
	if(new_icon)
		image_icon = new_icon
	else
		image_icon = initial(image_icon)
	px = new_px
	py = new_py
	Show()

/obj/effect/hallucination/simple/Move()
	..()
	Show()

/obj/effect/hallucination/simple/Destroy()
	if(target.client)
		target.client.images.Remove(current_image)
	active = 0
	return ..()

#define FAKE_FLOOD_EXPAND_TIME 20
#define FAKE_FLOOD_MAX_RADIUS 10

/datum/hallucination/fake_flood
	//Plasma starts flooding from the nearby vent
	var/turf/center
	var/list/flood_images = list()
	var/list/turf/flood_turfs = list()
	var/image_icon = 'icons/effects/tile_effects.dmi'
	var/image_state = "plasma"
	var/radius = 0
	var/next_expand = 0
	weight = 5
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/fake_flood/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/U in orange(7,target))
		if(!U.welded)
			center = get_turf(U)
			break
	if(!center)
		qdel(src)
		return
	feedback_details += "Vent Coords: [center.x],[center.y],[center.z]"
	var/image/plasma_image = image(image_icon,center,image_state,MOB_LAYER)
	plasma_image.alpha = 50
	plasma_image.plane = GAME_PLANE
	flood_images += plasma_image
	flood_turfs += center
	if(target.client)
		target.client.images |= flood_images
	next_expand = world.time + FAKE_FLOOD_EXPAND_TIME
	processing_objects += src

/datum/hallucination/fake_flood/process()
	if(next_expand <= world.time)
		radius++
		if(radius > FAKE_FLOOD_MAX_RADIUS)
			qdel(src)
			return
		Expand()
		if((get_turf(target) in flood_turfs) && !target.internal)
			new /datum/hallucination/fake_alert(target, TRUE, "too_much_tox")
		next_expand = world.time + FAKE_FLOOD_EXPAND_TIME


/datum/hallucination/fake_flood/proc/Expand()
	for(var/image/I in flood_images)
		I.alpha = min(I.alpha + 50, 255)
	for(var/turf/FT in flood_turfs)
		for(var/dir in cardinal)
			var/turf/T = get_step(FT, dir)
			if((T in flood_turfs) || !FT.CanAtmosPass(T))
				continue
			var/image/new_plasma = image(image_icon,T,image_state,MOB_LAYER)
			new_plasma.alpha = 50
			new_plasma.plane = GAME_PLANE
			flood_images += new_plasma
			flood_turfs += T
	if(target.client)
		target.client.images |= flood_images

/datum/hallucination/fake_flood/Destroy()
	processing_objects -= src
	qdel(flood_turfs)
	flood_turfs = list()
	if(target.client)
		target.client.images.Remove(flood_images)
	qdel(flood_images)
	flood_images = list()
	return ..()

/obj/effect/hallucination/simple/xeno
	image_icon = 'icons/mob/alien.dmi'
	image_state = "alienh_pounce"

/obj/effect/hallucination/simple/xeno/New(loc,var/mob/living/carbon/T)
	..()
	name = "alien hunter ([rand(1, 1000)])"

/obj/effect/hallucination/simple/xeno/throw_impact(A)
	update_icon("alienh_pounce")
	if(A == target)
		target.Weaken(5)
		target.visible_message("<span class='danger'>[target] flails around wildly.</span>","<span class ='userdanger'>[name] pounces on you!</span>")

/datum/hallucination/xeno_attack
	//Xeno crawls from nearby vent,jumps at you, and goes back in
	var/obj/machinery/atmospherics/components/unary/vent_pump/pump = null
	var/obj/effect/hallucination/simple/xeno/xeno = null
	severity = HALLUCINATION_MEDIUM
	weight = 10

/datum/hallucination/xeno_attack/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/U in orange(7,target))
		if(!U.welded)
			pump = U
			break
	if(pump)
		feedback_details += "Vent Coords: [pump.x],[pump.y],[pump.z]"
		xeno = new(pump.loc,target)
		sleep(10)
		xeno.update_icon("alienh_leap",'icons/mob/alienleap.dmi',-32,-32)
		xeno.throw_at(target,7,1, xeno, FALSE, TRUE)
		sleep(10)
		xeno.update_icon("alienh_leap",'icons/mob/alienleap.dmi',-32,-32)
		xeno.throw_at(pump,7,1, xeno, FALSE, TRUE)
		sleep(10)
		var/xeno_name = xeno.name
		to_chat(target, "<span class='notice'>[xeno_name] begins climbing into the ventilation system...</span>")
		sleep(30)
		qdel(xeno)
		to_chat(target, "<span class='notice'>[xeno_name] scrambles into the ventilation ducts!</span>")
	qdel(src)


/obj/effect/hallucination/simple/clown
	image_icon = 'icons/mob/animal.dmi'
	image_state = "clown"

/obj/effect/hallucination/simple/clown/New(loc, mob/living/carbon/T, duration)
	..(loc, T)
	name = pick(clown_names)
	sleep(duration)
	qdel(src)

/obj/effect/hallucination/simple/clown/scary
	image_state = "scary_clown"

/obj/effect/hallucination/simple/borer
	image_icon = 'icons/mob/animal.dmi'
	image_state = "brainslug"

/datum/hallucination/borer
	//A borer paralyzes you and crawls in your ear
	var/obj/machinery/atmospherics/unary/vent_pump/pump = null
	var/obj/effect/hallucination/simple/borer/borer = null
	weight = 10
	severity = HALLUCINATION_MAJOR

/datum/hallucination/borer/New(loc, mob/living/carbon/T)
	set waitfor = FALSE
	..()
	target = T
	for(var/obj/machinery/atmospherics/unary/vent_pump/U in orange(7, target))
		if(!U.welded)
			pump = U
			break
	if(pump)
		borer = new(pump.loc,target)
		for(var/i=0, i<11, i++)
			walk_to(borer, get_step(borer, get_cardinal_dir(borer, T)))
			if(borer.Adjacent(T))
				to_chat(T, "<span class='userdanger'>You feel a creeping, horrible sense of dread come over you, freezing your limbs and setting your heart racing.</span>")
				T.Stun(4)
				sleep(50)
				qdel(borer)
				sleep(rand(60, 90))
				to_chat(T, "<span class='changeling'><i>Primary [rand(1000,9999)] states:</i> [pick("Hello","Hi","You're my slave now!","Don't try to get rid of me...")]</span>")
				break
			sleep(4)
		if(!qdeleted(borer))
			qdel(borer)
	qdel(src)

/obj/effect/hallucination/simple/bubblegum
	name = "Bubblegum"
	image_icon = 'icons/mob/lavaland/96x96megafauna.dmi'
	image_state = "bubblegum"
	px = -32

/datum/hallucination/oh_yeah
	var/obj/effect/hallucination/simple/bubblegum/bubblegum
	var/image/fakebroken
	var/image/fakerune

/datum/hallucination/oh_yeah/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	. = ..()
	var/turf/closed/wall/wall
	for(var/turf/closed/wall/W in range(7,target))
		wall = W
		break
	if(!wall)
		qdel(src)
		return
	feedback_details += "Source: [wall.x],[wall.y],[wall.z]"

	fakebroken = image('icons/turf/floors.dmi', wall, "plating", layer = TURF_LAYER)
	var/turf/landing = get_turf(target)
	var/turf/landing_image_turf = get_step(landing, SOUTHWEST) //the icon is 3x3
	fakerune = image('icons/effects/96x96.dmi', landing_image_turf, "landing", layer = ABOVE_OPEN_TURF_LAYER)
	fakebroken.override = TRUE
	if(target.client)
		target.client.images |= fakebroken
		target.client.images |= fakerune
	target.playsound_local(wall,'sound/effects/meteorimpact.ogg', 150, 1)
	bubblegum = new(wall, target)
	addtimer(CALLBACK(src, .proc/bubble_attack, landing), 10)

/datum/hallucination/oh_yeah/proc/bubble_attack(turf/landing)
	var/charged = FALSE //only get hit once
	while(get_turf(bubblegum) != landing && target && target.stat != DEAD)
		bubblegum.forceMove(get_step_towards(bubblegum, landing))
		bubblegum.setDir(get_dir(bubblegum, landing))
		target.playsound_local(get_turf(bubblegum), 'sound/effects/meteorimpact.ogg', 150, 1)
		shake_camera(target, 2, 1)
		if(bubblegum.Adjacent(target) && !charged)
			charged = TRUE
			target.Weaken(4)
			target.staminaloss += 40
			step_away(target, bubblegum)
			shake_camera(target, 4, 3)
			target.visible_message("<span class='warning'>[target] jumps backwards, falling on the ground!</span>","<span class='userdanger'>[bubblegum] slams into you!</span>")
		sleep(2)
	sleep(30)
	qdel(src)



/datum/hallucination/oh_yeah/Destroy()
	if(target.client)
		target.client.images.Remove(fakebroken)
		target.client.images.Remove(fakerune)
	QDEL_NULL(fakebroken)
	QDEL_NULL(fakerune)
	QDEL_NULL(bubblegum)
	return ..()

/datum/hallucination/battle
	weight = 2
	var/battle_type
/datum/hallucination/battle/proc/attack(mob/living/carbon/target)
	var/turf/source = random_far_turf()
	feedback_details += "Type: [battle_type]"

/datum/hallucination/battle/ranged
	var/min_iterations = 5
	var/max_iterations = 10
	var/fire_sound
	var/hit_sound
	var/miss_sound
	var/hit_prob = 50
	var/fall_prob = 70
	var/hits_to_fall = 4

/datum/hallucination/battle/melee/esword
	severity = HALLUCINATION_MEDIUM
	battle_type = "esword"

/datum/hallucination/battle/melee/esword/attack(mob/living/carbon/target)
	..()
	target.playsound_local(source, 'sound/weapons/saberon.ogg',15, 1)
	for(var/i in 1 to rand(4, 8))
		target.playsound_local(source, 'sound/weapons/blade1.ogg', 50, 1)
		if(i == 4)
			target.playsound_local(source, get_sfx("bodyfall"), 25, 1)
		sleep(rand(CLICK_CD_MELEE, CLICK_CD_MELEE + 6))
	target.playsound_local(source, 'sound/weapons/saberoff.ogg', 15, 1)

/datum/hallucination/battle/melee/stunprod/
	severity = HALLUCINATION_MEDIUM
	battle_type = "stunprod"

/datum/hallucination/battle/melee/stunprod/attack(mob/living/carbon/target)
	..()
	target.playsound_local(source, 'sound/weapons/egloves.ogg', 40, 1)
	target.playsound_local(source, get_sfx("bodyfall"), 25, 1)
	sleep(20)
	target.playsound_local(source, 'sound/weapons/cablecuff.ogg', 15, 1)

/datum/hallucination/battle/melee/harmbaton/
	severity = HALLUCINATION_MEDIUM
	battle_type = "harmbaton"

/datum/hallucination/battle/melee/harmbaton/attack(mob/living/carbon/target)
	..()
	target.playsound_local(source, 'sound/weapons/egloves.ogg', 40, 1)
	target.playsound_local(source, get_sfx("bodyfall"), 25, 1)
	sleep(20)
	for(var/i in 1 to rand(5, 12))
		target.playsound_local(source, "swing_hit", 50, 1)
		sleep(rand(CLICK_CD_MELEE, CLICK_CD_MELEE + 4))

/datum/hallucination/battle/bomb/
	severity = HALLUCINATION_MEDIUM
	battle_type = "bomb"

/datum/hallucination/battle/bomb/attack(mob/living/carbon/target)
	..()
	for(var/i in 1 to rand(3, 11))
		target.playsound_local(source, 'sound/items/timer.ogg', 25, 0)
		sleep(15)

/datum/hallucination/battle/ranged/attack(mob/living/carbon/target)
	..()
	var/hits = 0
	for(var/i in 1 to rand(min_iterations, max_iterations))
		target.playsound_local(source, fire_sound, 25, 1)
		if(prob(hit_prob))
			addtimer(CALLBACK(target, /mob/.proc/playsound_local, source, hit_sound, 25, 1), rand(5,10))
			hits++
		else
			addtimer(CALLBACK(target, /mob/.proc/playsound_local, source, miss_sound, 25, 1), rand(5,10))
		sleep(rand(CLICK_CD_RANGE, CLICK_CD_RANGE + 6))
		if(hits >= hits_to_fall && prob(fall_prob))
			target.playsound_local(source, get_sfx("bodyfall"), 25, 1)
			break

/datum/hallucination/battle/ranged/laser
	severity = HALLUCINATION_MEDIUM
	battle_type = "laser"
	fire_sound = 'sound/weapons/laser.ogg'
	hit_sound = 'sound/weapons/sear.ogg'

/datum/hallucination/battle/ranged/disabler
	severity = HALLUCINATION_MEDIUM
	battle_type = "disabler"
	fire_sound = 'sound/weapons/taser2.ogg'
	hit_sound = 'sound/weapons/tap.ogg'
	miss_sound = 'sound/weapons/effects/searwall.ogg'

/datum/hallucination/battle/ranged/gun
	severity = HALLUCINATION_MEDIUM
	battle_type = "gun"
	min_iterations = 3
	max_iterations = 6
	hits_to_fall = 2
	hit_prob = 60
	fall_prob = 80
	fire_sound = 'sound/weapons/gunshot.ogg'
	hit_sound = 'sound/weapons/pierce.ogg'
	miss_sound = "ricochet"
/datum/hallucination/battle/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	attack(target)
	qdel(src)




/datum/hallucination/items_other/proc/equip(mob/living/carbon/target)
	var/image_file
	var/image/A = null

	for(var/mob/living/carbon/human/H in view(7,target))
		if(H != target)
			var/hand = H.l_hand
			if(!hand)
				image_file = image_lefthand
			else
				hand = H.r_hand
				if(!hand)
					image_file = image_righthand

			A = image(image_file,H,image_state, layer=ABOVE_MOB_LAYER)


			if(target.client)
				target.client.images |= A
				sleep(rand(150,250))
				target.client.images.Remove(A)
			break




/datum/hallucination/items_other
	weight = 1
	var/image_lefthand = 'icons/mob/inhands/items_lefthand.dmi'
	var/image_righthand = 'icons/mob/inhands/items_righthand.dmi'
	var/image_state
	var/item_name

/datum/hallucination/items_other/esword
	severity = HALLUCINATION_MEDIUM
	image_state = "swordred"

/datum/hallucination/items_other/esword/equip(mob/living/carbon/target)
	target.playsound_local(H, 'sound/weapons/saberon.ogg',35,1)
	..()
	target.playsound_local(H, 'sound/weapons/saberoff.ogg',35,1)

/datum/hallucination/items_other/esword/dual
	image_state = "dualsaberred1"

/datum/hallucination/items_other/gun
	image_lefthand = 'icons/mob/inhands/guns_lefthand.dmi'
	image_righthand = 'icons/mob/inhands/guns_righthand.dmi'

/datum/hallucination/items_other/gun/taser
	severity = HALLUCINATION_MEDIUM
	image_state = "advtaserstun4"

/datum/hallucination/items_other/gun/ebow
	severity = HALLUCINATION_MEDIUM
	image_state = "crossbow"

/datum/hallucination/items_other/baton
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/baton/equip(mob/living/carbon/target)
	target.playsound_local(H, "sparks",75,1,-1)
	..()

/datum/hallucination/items_other/dual_esword
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/stunpaper
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/ttv
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/flash
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/chainsaw
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/armblade
	severity = HALLUCINATION_MEDIUM

/datum/hallucination/items_other/New(mob/living/carbon/C, forced = TRUE, item_type)
	set waitfor = FALSE
	..()
	target = C
	equip(target)
	qdel(src)

