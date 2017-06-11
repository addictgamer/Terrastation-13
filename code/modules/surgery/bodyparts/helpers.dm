/*
/mob/living/proc/get_bodypart(zone)
	return

/mob/living/carbon/get_bodypart(zone)
	if(!zone)
		zone = "chest"
	for(var/X in bodyparts)
		var/obj/item/bodypart/L = X
		if(L.body_zone == zone)
			return L

/mob/living/carbon/has_hand_for_held_index(i)
	if(i)
		var/obj/item/bodypart/L = hand_bodyparts[i]
		if(L)
			return L
	return FALSE




/mob/proc/has_left_hand()
	return TRUE

/mob/living/carbon/has_left_hand()
	for(var/obj/item/bodypart/L in hand_bodyparts)
		if(L.held_index % 2)
			return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_left_hand()
	return 1


/mob/proc/has_right_hand()
	return TRUE

/mob/living/carbon/has_right_hand()
	for(var/obj/item/bodypart/L in hand_bodyparts)
		if(!(L.held_index % 2))
			return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_right_hand()
	return 1


*/
//Limb numbers
/mob/living/carbon/human/proc/get_num_arms()
	return 2

/mob/living/carbon/human/get_num_arms()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/organ/external/affecting = X
		if(affecting.body_part == ARM_RIGHT)
			.++
		if(affecting.body_part == ARM_LEFT)
			.++


//sometimes we want to ignore that we don't have the required amount of arms.
/mob/living/carbon/human/proc/get_arm_ignore()
	return 0

///mob/living/carbon/alien/larva/get_arm_ignore()
//	return 1 //so we can still handcuff larvas.


///mob/living/carbon/human/proc/get_num_legs()
/mob/living/proc/get_num_legs()
	return 2

/mob/living/carbon/human/get_num_legs()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/organ/external/affecting = X
		if(affecting.body_part == LEG_RIGHT)
			.++
		if(affecting.body_part == LEG_LEFT)
			.++

//sometimes we want to ignore that we don't have the required amount of legs.
/mob/living/carbon/human/proc/get_leg_ignore()
	return 0