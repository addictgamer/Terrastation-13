
/obj/item/powerarmor/servos
	name = "Adminbus power armor movement servos"
	desc = "Made with the rare Badminium molecule."
	var/toggleslowdown = 9

/obj/item/powerarmor/servos/toggle(sudden = 0)
	switch(parent.active)
		if (1)
			if (!sudden)
				usr << "\blue Movement assist servos disengaged."
			parent.slowdown += toggleslowdown
		if (0)
			usr << "\blue Movement assist servos engaged."
			parent.slowdown -= toggleslowdown
