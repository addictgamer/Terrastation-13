
/obj/item/powerarmor/atmoseal
	name = "Power armor atmospheric seals"
	desc = "Keeps the bad stuff out."
	slowdown = 1
	var/sealed = 0

/obj/item/powerarmor/atmoseal/toggle(sudden = 0)
	switch(parent.active)
		if (1)
			if (!sudden)
				usr << "\blue Atmospheric seals disengaged."
			parent.gas_transfer_coefficient = 1
			parent.permeability_coefficient = 1
			parent.heat_transfer_coefficient = 1
			parent.radiation_protection = 0
			parent.flags &= ~SUITSPACE
			if (parent.helmrequired)
				parent.helm.gas_transfer_coefficient = 1
				parent.helm.permeability_coefficient = 1
				parent.helm.heat_transfer_coefficient = 1
				parent.helm.radiation_protection = 0
				parent.helm.flags &= ~HEADSPACE
			if (parent.glovesrequired)
				parent.gloves.gas_transfer_coefficient = 1
				parent.gloves.permeability_coefficient = 1
				parent.gloves.heat_transfer_coefficient = 1
				parent.gloves.radiation_protection = 0
			if (parent.shoesrequired)
				parent.shoes.gas_transfer_coefficient = 1
				parent.shoes.permeability_coefficient = 1
				parent.shoes.heat_transfer_coefficient = 1
				parent.shoes.radiation_protection = 0
			sealed = 0

		if (0)
			usr << "\blue Atmospheric seals engaged."
			parent.gas_transfer_coefficient = 0.01
			parent.permeability_coefficient = 0.02
			parent.heat_transfer_coefficient = 0.02
			parent.radiation_protection = 0.75
			parent.flags |= SUITSPACE
			if (parent.helmrequired)
				parent.helm.gas_transfer_coefficient = 0.01
				parent.helm.permeability_coefficient = 0.02
				parent.helm.heat_transfer_coefficient = 0.02
				parent.helm.radiation_protection = 0.75
				parent.helm.flags |= HEADSPACE
			if (parent.glovesrequired)
				parent.gloves.gas_transfer_coefficient = 0.01
				parent.gloves.permeability_coefficient = 0.02
				parent.gloves.heat_transfer_coefficient = 0.02
				parent.gloves.radiation_protection = 0.75
			if (parent.shoesrequired)
				parent.shoes.gas_transfer_coefficient = 0.01
				parent.shoes.permeability_coefficient = 0.02
				parent.shoes.heat_transfer_coefficient = 0.02
				parent.shoes.radiation_protection = 0.75
			sealed = 1
