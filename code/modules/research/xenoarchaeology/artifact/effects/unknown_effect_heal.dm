
/datum/artifact_effect/heal
	effecttype = "heal"
	effect_type = 5

/datum/artifact_effect/heal/DoEffectTouch(var/mob/toucher)
	//todo: check over this properly
	if(toucher && iscarbon(toucher))
		var/weakness = GetAnomalySusceptibility(toucher)
		if(prob(weakness * 100))
			var/mob/living/carbon/C = toucher
			to_chat(C, "<span class='notice'>You feel a soothing energy invigorate you.</span>")

			if(ishuman(toucher))
				var/mob/living/carbon/human/H = toucher
				for(var/obj/item/organ/external/affecting in H.bodyparts)
					if(affecting && istype(affecting))
						affecting.heal_damage(25 * weakness, 25 * weakness)
				//H:heal_organ_damage(25, 25)
//				H.vessel.add_reagent("blood",5) //former line, changed to the following:
				H.restore_blood()				//because fuck it why not at least this will compile with the new system
				H.nutrition += 50 * weakness
				H.adjustBrainLoss(-25 * weakness)
				var/radiation = min(H.radiation, 25 * weakness)
				H.apply_effect(-radiation,IRRADIATE,0)
				H.bodytemperature = initial(H.bodytemperature)
//				spawn(1)
//					H.fixblood() //I don't think this is needed anymore because I think I blanket healed it above besides this proc no longer exists
			//
			C.adjustOxyLoss(-25 * weakness)
			C.adjustToxLoss(-25 * weakness)
			C.adjustBruteLoss(-25 * weakness)
			C.adjustFireLoss(-25 * weakness)
			//
			C.regenerate_icons()
			return 1

/datum/artifact_effect/heal/DoEffectAura()
	//todo: check over this properly
	if(holder)
		var/turf/T = get_turf(holder)
		for(var/mob/living/carbon/C in range(src.effectrange,T))
			var/weakness = GetAnomalySusceptibility(C)
			if(prob(weakness * 100))
				if(prob(10))
					to_chat(C, "<span class='notice'>You feel a soothing energy radiating from something nearby.</span>")
				C.adjustBruteLoss(-1 * weakness)
				C.adjustFireLoss(-1 * weakness)
				C.adjustToxLoss(-1 * weakness)
				C.adjustOxyLoss(-1 * weakness)
				C.adjustBrainLoss(-1 * weakness)
				C.updatehealth()

/datum/artifact_effect/heal/DoEffectPulse()
	//todo: check over this properly
	if(holder)
		var/turf/T = get_turf(holder)
		for(var/mob/living/carbon/C in range(src.effectrange,T))
			var/weakness = GetAnomalySusceptibility(C)
			if(prob(weakness * 100))
				to_chat(C, "<span class='notice'>A wave of energy invigorates you.</span>")
				C.adjustBruteLoss(-5 * weakness)
				C.adjustFireLoss(-5 * weakness)
				C.adjustToxLoss(-5 * weakness)
				C.adjustOxyLoss(-5 * weakness)
				C.adjustBrainLoss(-5 * weakness)
				C.updatehealth()
