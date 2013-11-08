
/datum/disease/effectholder
	var/datum/disease/effect/effect
	var/chance = 0 //Chance in percentage each tick
	var/happensonce = 0
	var/multiplier = 1 //The chance the effects are WORSE

/datum/disease/effectholder/proc/runeffect(var/mob/living/carbon/human/mob,var/stage)
	if(happensonce > -1 && effect.stage <= stage && prob(chance))
		effect.activate(mob)
		if(happensonce == 1)
			happensonce = -1

/datum/disease/effectholder/proc/getrandomeffect(var/badness = 1)
	var/list/datum/disease/effect/list = list()
	for(var/e in (typesof(/datum/disease/effect) - /datum/disease/effect))
		var/datum/disease/effect/f = new e
		if (f.badness > badness)	//we don't want such strong effects
			continue
		if(f.stage == src.stage)
			list += f
	effect = pick(list)
	chance = rand(1,6)

/datum/disease/effectholder/proc/minormutate()
	switch(pick(1,2,3,4,5))
		if(1)
			chance = rand(0,effect.chance_maxm)
		if(2)
			multiplier = rand(1,effect.maxm)

/datum/disease/effectholder/proc/majormutate()
	getrandomeffect(2)

// EFFECTS
/datum/disease/effect
	var/chance_maxm = 50
	var/maxm = 1
	var/badness = 1
	proc/activate(var/mob/living/carbon/mob,var/multiplier)
	proc/deactivate(var/mob/living/carbon/mob)

// SPECIAL
/*
/datum/disease/effect/alien
	name = "Unidentified Foreign Body"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "\red You feel something tearing its way out of your stomach..."
		mob.adjustToxLoss(10)
		mob.updatehealth()
		if(prob(40))
			if(mob.client)
				mob.client.mob = new/mob/living/carbon/alien/larva(mob.loc)
			else
				new/mob/living/carbon/alien/larva(mob.loc)
			var/datum/disease/disease/D = mob:virus2
			mob:gib()
			del D
*/

/datum/disease/effect/invisible
	name = "Waiting Syndrome"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		return

// STAGE 4
/datum/disease/effect/gibbingtons
	name = "Gibbingtons Syndrome"
	stage = 4
	badness = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.gib()

/datum/disease/effect/radian
	name = "Radian's Syndrome"
	stage = 4
	maxm = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.radiation += (2*multiplier)

/datum/disease/effect/deaf
	name = "Dead Ear Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.ear_deaf += 20

/datum/disease/effect/monkey
	name = "Monkism Syndrome"
	stage = 4
	badness = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob,/mob/living/carbon/human))
			var/mob/living/carbon/human/h = mob
			h.monkeyize()

/datum/disease/effect/suicide
	name = "Suicidal Syndrome"
	stage = 4
	badness = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.suiciding = 1
	// instead of killing them instantly, just put them at -175 health and let 'em gasp for a while
		viewers(mob) << "\red <b>[mob.name] is holding \his breath. It looks like \he's trying to commit suicide.</b>"
		mob.adjustOxyLoss(175 - mob.getToxLoss() - mob.getFireLoss() - mob.getBruteLoss() - mob.getOxyLoss())
		mob.updatehealth()
		spawn(200)	// in case they get revived by cryo chamber or something stupid like that, let them suicide again in 20 seconds
			mob.suiciding = 0

/datum/disease/effect/killertoxins
	name = "Toxification Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.adjustToxLoss(15*multiplier)

/datum/disease/effect/dna
	name = "Reverse Pattern Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.bodytemperature = max(mob.bodytemperature, 350)
		scramble(0,mob,10)
		mob.apply_damage(10, CLONE)

/datum/disease/effect/organs
	name = "Shutdown Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			var/datum/organ/external/E = pick(H.organs)
			if (!(E.status & ORGAN_DEAD))
				E.status |= ORGAN_DEAD
				H << "<span class='notice'>You can't feel your [E.display_name] anymore...</span>"
		mob.adjustToxLoss(15*multiplier)

	deactivate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			for (var/datum/organ/external/E in H.organs)
				E.status &= ~ORGAN_DEAD

/datum/disease/effect/immortal
	name = "Longevity Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			for (var/datum/organ/external/E in H.organs)
				if (E.status & ORGAN_BROKEN && prob(30))
					E.status ^= ORGAN_BROKEN
		var/heal_amt = -5*multiplier
		mob.apply_damages(heal_amt,heal_amt,heal_amt,heal_amt)

	deactivate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			H << "<span class='notice'>You suddenly feel hurt and old...</span>"
			H.age += 8
		var/backlash_amt = 5*multiplier
		mob.apply_damages(backlash_amt,backlash_amt,backlash_amt,backlash_amt)

// STAGE 3
/datum/disease/effect/bones
	name = "Fragile Bones Syndrome"
	stage = 4
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			for (var/datum/organ/external/E in H.organs)
				E.min_broken_damage = max(5, E.min_broken_damage - 30)

	deactivate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			for (var/datum/organ/external/E in H.organs)
				E.min_broken_damage = initial(E.min_broken_damage)

/datum/disease/effect/toxins
	name = "Hyperacidity"
	stage = 3
	maxm = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.adjustToxLoss((2*multiplier))

/datum/disease/effect/shakey
	name = "World Shaking Syndrome"
	stage = 3
	maxm = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		shake_camera(mob,5*multiplier)

/datum/disease/effect/telepathic
	name = "Telepathy Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.dna.check_integrity()
		var/newdna = setblock(mob.dna.struc_enzymes,REMOTETALKBLOCK,toggledblock(getblock(mob.dna.struc_enzymes,REMOTETALKBLOCK,3)),3)
		mob.dna.struc_enzymes = newdna
		domutcheck(mob, null)

/datum/disease/effect/mind
	name = "Lazy Mind Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			var/datum/organ/internal/brain/B = H.internal_organs["brain"]
			B.take_damage(5)
		else
			mob.setBrainLoss(50)

/datum/disease/effect/hallucinations
	name = "Hallucinational Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.hallucination += 25

/datum/disease/effect/deaf
	name = "Hard of Hearing Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.ear_deaf = 5

/datum/disease/effect/giggle
	name = "Uncontrolled Laughter Effect"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*giggle")

/datum/disease/effect/confusion
	name = "Topographical Cretinism"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "<span class='notice'>You have trouble telling right and left apart all of a sudden.</span>"
		mob.confused += 10

/datum/disease/effect/mutation
	name = "DNA Degradation"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.apply_damage(2, CLONE)


/datum/disease/effect/groan
	name = "Groaning Syndrome"
	stage = 3
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*groan")

// STAGE 2
/datum/disease/effect/scream
	name = "Loudness Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*scream")

/datum/disease/effect/drowsness
	name = "Automated Sleeping Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.drowsyness += 10

/datum/disease/effect/sleepy
	name = "Resting Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*collapse")

/datum/disease/effect/blind
	name = "Blackout Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.eye_blind = max(mob.eye_blind, 4)

/datum/disease/effect/cough
	name = "Anima Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*cough")
		for(var/mob/living/carbon/M in view(1,mob))
			if(airborne_can_reach(get_turf(mob), get_turf(M)))
				for (var/datum/disease/disease/V in mob.virus2)
					if(V.spreadtype == "Airborne")
						infect_virus2(M,V)

/datum/disease/effect/hungry
	name = "Appetiser Effect"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.nutrition = max(0, mob.nutrition - 200)

/datum/disease/effect/fridge
	name = "Refridgerator Syndrome"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*shiver")

/datum/disease/effect/hair
	name = "Hair Loss"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		if(istype(mob, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = mob
			if(H.species.name == "Human" && !(H.h_style == "Bald") && !(H.h_style == "Balding Hair"))
				H << "<span class='danger'>Your hair starts to fall out in clumps...</span>"
				spawn(50)
					H.h_style = "Balding Hair"
					H.update_hair()

/datum/disease/effect/stimulant
	name = "Adrenaline Extra"
	stage = 2
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "<span class='notice'>You feel a rush of energy inside you!</span>"
		if (mob.reagents.get_reagent_amount("hyperzine") < 30)
			mob.reagents.add_reagent("hyperzine", 10)
		if (prob(30))
			mob.jitteriness += 10

// STAGE 1
/datum/disease/effect/sneeze
	name = "Coldingtons Effect"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*sneeze")
		if (prob(50))
			var/obj/effect/decal/cleanable/mucus/M = new(get_turf(mob))
			M.virus2 = virus_copylist(mob.virus2)

/datum/disease/effect/gunck
	name = "Flemmingtons"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "\red Mucous runs down the back of your throat."

/datum/disease/effect/drool
	name = "Saliva Effect"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*drool")

/datum/disease/effect/twitch
	name = "Twitcher"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob.say("*twitch")

/datum/disease/effect/headache
	name = "Headache"
	stage = 1
	activate(var/mob/living/carbon/mob,var/multiplier)
		mob << "<span class = 'notice'> Your head hurts a bit</span>"
		mob << "<span class = 'notice'> Your head hurts a bit</span>"
