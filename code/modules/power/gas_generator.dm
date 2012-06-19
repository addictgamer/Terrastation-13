
/obj/machinery/power/gas_power_gen
	name = "Gas Power Generator"
	desc = "A device which uses gas tanks filled with plasma to produce electricity."
	icon = 'gas_power_gen.dmi'
	icon_state = "gas_power_gen_off"
	anchored = 1
	density = 1
	directwired = 1
	var
		obj/item/weapon/tank/plasma/P = null
		last_power = 0
		active = 0


	process()  //Needs Plasma!
		if(P && active)
			if(P.air_contents.toxins <= 0)
				P.air_contents.toxins = 0
				eject()
			else
				P.air_contents.toxins -= 0.001
				//receive_pulse(rand(50,500)) //Generate the electricity. //Uncomment for fluctuating power gen.
				receive_pulse(500) //Generates the electricity.

		else
			if(!P)
				active = 0 //Turn off.
				icon_state = "gas_power_gen_off"
				flick("gas_power_gen_off", src)
				updateicon()
		return


	attack_hand(mob/user as mob)
		if(anchored)
			toggle_power()
			user.visible_message("[user.name] turns the [src.name] [active? "on":"off"].", \
			"You turn the [src.name] [active? "on":"off"].")
			return
	..()


	attackby(obj/item/W, mob/user)
		if(istype(W, /obj/item/device/analyzer))
			user << "\blue The [W.name] detects that [last_power]W were recently produced."
			return 1
		else if(istype(W, /obj/item/weapon/tank/plasma))
			if(!src.anchored)
				user << "The [src] needs to be secured to the floor first."
				return 1
			if(src.P)
				user << "\red There appears to already be a plasma tank loaded!"
				return 1
			src.P = W
			W.loc = src
			if (user.client)
				user.client.screen -= W
			user.u_equip(W)
			updateicon()
		else if(istype(W, /obj/item/weapon/crowbar))
			if(P)
				eject()
				return 1
		else if(istype(W, /obj/item/weapon/wrench))
			if(P)
				user << "\red Remove the plasma tank first."
				return 1
			playsound(src.loc, 'Ratchet.ogg', 75, 1)
			src.anchored = !src.anchored
			user.visible_message("[user.name] [anchored? "secures":"unsecures"] the [src.name].", \
				"You [anchored? "secure":"undo"] the external bolts.", \
				"You hear ratchet")
			if(anchored)
				connect_to_network()
			else
				disconnect_from_network()
		else
			..()
			return 1


	ex_act(severity)
		switch(severity)
			if(2, 3)
				eject()
		return ..()


	proc
		eject()
			var/obj/item/weapon/tank/plasma/Z = src.P
			if (!Z)
				return
			Z.loc = get_turf(src)
			Z.layer = initial(Z.layer)
			src.P = null
			if(active)
				toggle_power()
			else
				updateicon()

		receive_pulse(var/pulse_strength)
			if(P && active)
				var/power_produced = 0
				power_produced = P.air_contents.toxins*pulse_strength//*20
				//power_produced += power_produced*pulse_strength
				add_avail(power_produced)
				last_power = power_produced
				return
			return


		updateicon()
			overlays = null
			if(P)
				overlays += image('gas_power_gen.dmi', "gas_tank")
			if(stat & (NOPOWER|BROKEN))
				return


		toggle_power()
			active = !active
			if(active)
				icon_state = "gas_power_gen_on"
				flick("gas_power_gen_on", src)

			else
				icon_state = "gas_power_gen_off"
				flick("gas_power_gen_off", src)
			updateicon()
			return