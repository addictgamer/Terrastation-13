

mob/living/thing/proc/vanish()
	set name = "vanish"
	set category = "Pingas Melter"
	set desc = "Toggles ghost-like invisibility"
	if(holder && mob)
		if(mob.invisibility == 1)
			mob.invisibility = 0
			mob << "\red <b>You are now visible to humans.</b>"
		else
			mob.invisibility = 1
			mob << "\blue <b>You are now invisible to humans.</b>"
