/* So, this thing generates power and requires no fuel.
 BUT, if set to produce more than a certain safe ammount, then it becomes unsafe and prone to explode.
 TODO: Program the unsafe part of it...And building them.

*/


/obj/machinery/power/energy_funnel
	name = "Energy Funnel"
	desc = "A device that funnels in energy from alternate dimensions."
	icon = 'energy_funnel.dmi'
	icon_state = "energy_funnel"
	anchored = 1
	density = 1
	directwired = 1
	var/target_power_gen = 0
	var/max_safe_power_gen = 1500 //The max power it can safely gen without having the random chance of exploding or something bad like that happening.
	//var/list/component_parts //The parts that make up this blarg.

	process()
		var/power_produced = 0 //The power to produce.
		power_produced = target_power_gen //Produce the power.
		add_avail(power_produced)

		return


	RefreshParts()
		var/temp_rating = 0
		var/temp_reliability = 0
		for(var/obj/item/weapon/stock_parts/SP in component_parts)
			if(istype(SP, /obj/item/weapon/stock_parts/micro_laser) || istype(SP, /obj/item/weapon/stock_parts/capacitor))
				temp_rating += SP.rating
		for(var/obj/item/weapon/CP in component_parts)
			temp_reliability += CP.reliability
		reliability = min(round(temp_reliability / 4), 100)


	attack_hand(mob/user as mob)
		return
	..()


	attackby(obj/item/W, mob/user)
		if(istype(W, /obj/item/device/analyzer))
			user << "\blue The [W.name] detects that [target_power_gen]W is the targetted power to generate."
			return 1
		else if(istype(W, /obj/item/weapon/wrench))
			playsound(src.loc, 'Ratchet.ogg', 75, 1)
			src.anchored = !src.anchored
			user.visible_message("[user.name] [anchored? "secures":"unsecures"] the [src.name].", \
				"You [anchored? "secure":"undo"] the external bolts.", \
				"You hear ratchet")
			if(anchored)
				connect_to_network()
			else
				disconnect_from_network()
		else if(istype(W, /obj/item/weapon/screwdriver)) //If it's a screwdriver...dissassemble the machine.
			var/obj/machinery/constructable_frame/machine_frame/new_frame = new /obj/machinery/constructable_frame/machine_frame(src.loc)
			for(var/obj/item/I in component_parts)
				if(I.reliability < 100)
					I.crit_fail = 1
				I.loc = src.loc
			new_frame.state = 2
			new_frame.icon_state = "box_1"
			del(src)
		else if(istype(W, /obj/item/device/multitool)) //If it's a multitool, adjust the target power...
			target_power_gen = input(user, "Target power gen:","Enter ammount","") as num
		else
			..()
			return 1


	New()
		component_parts = list()
		component_parts += new /obj/item/weapon/stock_parts/matter_bin/super(src)
		component_parts += new /obj/item/weapon/stock_parts/micro_laser/ultra(src)
		component_parts += new /obj/item/weapon/cable_coil(src)
		component_parts += new /obj/item/weapon/cable_coil(src)
		component_parts += new /obj/item/weapon/cable_coil(src)
		component_parts += new /obj/item/weapon/cable_coil(src)
		component_parts += new /obj/item/weapon/stock_parts/capacitor/super(src)
		component_parts += new /obj/item/weapon/circuitboard/energy_funnel(src)
		component_parts += new /obj/item/weapon/cell/hyper(src)
		component_parts += new /obj/item/weapon/stock_parts/manipulator/pico(src)
		RefreshParts()


	proc

		updateicon()
			overlays = null
			if(stat & (BROKEN))
				return


/obj/item/weapon/circuitboard/energy_funnel
	name = "Circuit board (Energy Funnel)"
	build_path = "/obj/machinery/power/energy_funnel"
	origin_tech = "programming=2"