
/obj/item/powerarmor/atmoseal/optional
	name = "Togglable power armor atmospheric seals"
	desc = "Keeps the bad stuff out, but lets you remove your helmet without having to turn the whole suit off."

/obj/item/powerarmor/atmoseal/optional/proc/helmtoggle(sudden = 0, manual = 0)
	var/mob/living/carbon/human/user = usr
	var/obj/item/clothing/head/powered/helm
	if(user.head && istype(user.head,/obj/item/clothing/head/powered))
		helm = user.head

		if(!sealed)
			user << "\red Unable to initialize helmet seal, armor seals not active."
			return
		if(!helm.parent)
			user << "\blue Helmet locked."
			helm.canremove = 0
			parent.helm = helm
			helm.parent = parent
			sleep(20)
			parent.helm.gas_transfer_coefficient = 0.01
			parent.helm.permeability_coefficient = 0.02
			parent.helm.heat_transfer_coefficient = 0.02
			parent.helm.radiation_protection = 0.75
			parent.helm.flags |= HEADSPACE
			user << "\blue Helmet atmospheric seals engaged."
			if(manual)
				for (var/armorvar in helm.armor)
					helm.armor[armorvar] = parent.armor[armorvar]
			return
		else
			if(manual)
				user << "\blue Helmet atmospheric seals disengaged."
			parent.helm.gas_transfer_coefficient = 1
			parent.helm.permeability_coefficient = 1
			parent.helm.heat_transfer_coefficient = 1
			parent.helm.radiation_protection = 0
			parent.helm.flags &= ~HEADSPACE
			if(manual)
				for (var/armorvar in helm.armor)
					helm.armor[armorvar] = parent.reactive.togglearmor[armorvar]
			if(!sudden)
				if(manual)
					sleep(20)
					user << "\blue Helmet unlocked."
				helm.canremove = 1
				parent.helm = null
				helm.parent = null
