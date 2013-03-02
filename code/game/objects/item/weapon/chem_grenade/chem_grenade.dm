
//Includes changes by Mord_Sith to allow for buildable cameras
/obj/item/weapon/chem_grenade
	name = "Grenade Casing"
	icon_state = "chemg"
	icon = 'chemical.dmi'
	item_state = "flashbang"
	w_class = 2.0
	force = 2.0
	var/stage = 0
	var/state = 0
	var/path = 0
	var/motion = 0
	var/direct = "SOUTH"
	var/obj/item/weapon/circuitboard/circuit = null
	var/list/beakers = new/list()
	var/list/allowed_containers = list("/obj/item/weapon/reagent_containers/glass/beaker", "/obj/item/weapon/reagent_containers/glass/dispenser", "/obj/item/weapon/reagent_containers/glass/bottle")
	var/affected_area = 3
	throw_speed = 4
	throw_range = 20
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT | USEDELAY
	New()
		var/datum/reagents/R = new/datum/reagents(1000)
		reagents = R
		R.my_atom = src

	attackby(obj/item/weapon/W as obj, mob/user as mob)//TODO:Have grenades use the new assembly things
		if(istype(W,/obj/item/device/assembly_holder) && !stage && path != 2)
			path = 1
			user << "\blue You add [W] to the metal casing."
			playsound(src.loc, 'Screwdriver2.ogg', 25, -3)
			del(W) //Okay so we're not really adding anything here. cheating.
			icon_state = initial(icon_state) +"_ass"
			name = "unsecured grenade"
			stage = 1
		else if(istype(W,/obj/item/weapon/screwdriver) && stage == 1 && path != 2)
			path = 1
			if(beakers.len)
				user << "\blue You lock the assembly."
				playsound(src.loc, 'Screwdriver.ogg', 25, -3)
				name = "grenade"
				icon_state = initial(icon_state) +"_locked"
				stage = 2
			else
				user << "\red You need to add at least one beaker before locking the assembly."
		else if ((istype(W,/obj/item/weapon/reagent_containers/glass/beaker)||istype(W,/obj/item/weapon/reagent_containers/glass/dispenser)||istype(W,/obj/item/weapon/reagent_containers/glass/bottle)) && stage == 1 && path != 2)
			path = 1
			if(beakers.len == 2)
				user << "\red The grenade can not hold more containers."
				return
			else
				if(W.reagents.total_volume)
					user << "\blue You add \the [W] to the assembly."
					user.drop_item()
					W.loc = src
					beakers += W
				else
					user << "\red \the [W] is empty."

		else if(path != 1)
			if(!istype(src.loc,/turf))
				user << "\red You need to put the canister on the ground to do that!"
			else
				switch(state)
					if(0)
						if(istype(W, /obj/item/weapon/wrench))
							playsound(src.loc, 'Ratchet.ogg', 50, 1)
							if(do_after(user, 20))
								user << "\blue You wrench the canister in place."
								src.name = "Camera Assembly"
								src.anchored = 1
								src.state = 1
								path = 2
					if(1)
						if(istype(W, /obj/item/weapon/wrench))
							playsound(src.loc, 'Ratchet.ogg', 50, 1)
							if(do_after(user, 20))
								user << "\blue You unfasten the canister."
								src.name = "Grenade Casing"
								src.anchored = 0
								src.state = 0
								path = 0
						if(istype(W, /obj/item/device/multitool))
							playsound(src.loc, 'Deconstruct.ogg', 50, 1)
							user << "\blue You place the electronics inside the canister."
							src.circuit = W
							user.drop_item()
							W.loc = src
						if(istype(W, /obj/item/weapon/screwdriver) && circuit)
							playsound(src.loc, 'Screwdriver.ogg', 50, 1)
							user << "\blue You screw the circuitry into place."
							src.state = 2
						if(istype(W, /obj/item/weapon/crowbar) && circuit)
							playsound(src.loc, 'Crowbar.ogg', 50, 1)
							user << "\blue You remove the circuitry."
							src.state = 1
							circuit.loc = src.loc
							src.circuit = null
					if(2)
						if(istype(W, /obj/item/weapon/screwdriver) && circuit)
							playsound(src.loc, 'Screwdriver.ogg', 50, 1)
							user << "\blue You unfasten the circuitry."
							src.state = 1
						if(istype(W, /obj/item/cable_coil))
							if(W:amount >= 1)
								playsound(src.loc, 'Deconstruct.ogg', 50, 1)
								if(do_after(user, 20))
									W:amount -= 1
									if(!W:amount) del(W)
									user << "\blue You add cabling to the canister."
									src.state = 3
					if(3)
						if(istype(W, /obj/item/weapon/wirecutters))
							playsound(src.loc, 'wirecutter.ogg', 50, 1)
							user << "\blue You remove the cabling."
							src.state = 2
							var/obj/item/cable_coil/A = new /obj/item/cable_coil( src.loc )
							A.amount = 1
						if(istype(W, /obj/item/device/radio/signaler))
							playsound(src.loc, 'Deconstruct.ogg', 50, 1)
							user << "\blue You attach the wireless signaller unit to the circutry."
							user.drop_item()
							W.loc = src
							src.state = 4
					if(4)
						if(istype(W, /obj/item/weapon/crowbar) && !motion)
							playsound(src.loc, 'Crowbar.ogg', 50, 1)
							user << "\blue You remove the remote signalling device."
							src.state = 3
							new /obj/item/device/radio/signaler( src.loc, 1 )
						if(istype(W, /obj/item/device/prox_sensor) && motion == 0)
//							if(W:amount >= 1)
							playsound(src.loc, 'Deconstruct.ogg', 50, 1)
//								W:use(1)
							user << "\blue You attach the proximity sensor."
							motion = 1
						if(istype(W, /obj/item/weapon/crowbar) && motion)
							playsound(src.loc, 'Crowbar.ogg', 50, 1)
							user << "\blue You remove the proximity sensor."
							new /obj/item/device/prox_sensor( src.loc, 1 )
							motion = 0
						if(istype(W, /obj/item/stack/sheet/glass))
							if(W:amount >= 1)
								playsound(src.loc, 'Deconstruct.ogg', 50, 1)
								if(do_after(user, 20))
									W:use(1)
									user << "\blue You put in the glass lens."
									src.state = 5
					if(5)
						if(istype(W, /obj/item/weapon/crowbar))
							playsound(src.loc, 'Crowbar.ogg', 50, 1)
							user << "\blue You remove the glass lens."
							src.state = 4
							new /obj/item/stack/sheet/glass( src.loc, 2 )
						if(istype(W, /obj/item/weapon/screwdriver))
							playsound(src.loc, 'Screwdriver.ogg', 50, 1)
							user << "\blue You connect the lense."
							var/B
							if(motion == 1)
								B = new /obj/machinery/camera/motion( src.loc )
							else
								B = new /obj/machinery/camera( src.loc )
							B:network = "SS13"
							B:network = input(usr, "Which network would you like to connect this camera to?", "Set Network", "SS13")
							direct = input(user, "Direction?", "Assembling Camera", null) in list( "NORTH", "EAST", "SOUTH", "WEST" )
							B:dir = text2dir(direct)
							del(src)


	afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
		if (istype(target, /obj/item/weapon/storage)) return ..()
		if (!src.state && stage == 2 && !crit_fail)
			user << "\red You prime the grenade! 3 seconds!"
			message_admins("[key_name_admin(user)] used a chemistry grenade ([src.name]).")
			log_game("[key_name_admin(user)] used a chemistry grenade ([src.name]).")
			src.state = 1
			src.icon_state = initial(icon_state)+"_armed"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn(30)
				explode()
			user.drop_item()
			var/t = (isturf(target) ? target : target.loc)
			walk_towards(src, t, 3)
		else if(crit_fail)
			user << "\red This grenade is a dud and unusable!"

	attack_self(mob/user as mob)
		if (!src.state && stage == 2 && !crit_fail)
			user << "\red You prime the grenade! 3 seconds!"
			message_admins("[key_name_admin(user)] used a chemistry grenade ([src.name]).")
			log_game("[key_name_admin(user)] used a chemistry grenade ([src.name]).")
			src.state = 1
			src.icon_state = initial(icon_state)+"_armed"
			playsound(src.loc, 'armbomb.ogg', 75, 1, -3)
			spawn(30)
				explode()
		else if(crit_fail)
			user << "\red This grenade is a dud and unusable!"

	attack_hand()
		walk(src,0)
		return ..()
	attack_paw()
		return attack_hand()

	proc
		explode()
			if(reliability)
				var/has_reagents = 0
				for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
					if(G.reagents.total_volume) has_reagents = 1

				if(!has_reagents)
					playsound(src.loc, 'Screwdriver2.ogg', 50, 1)
					state = 0
					return

				playsound(src.loc, 'bamf.ogg', 50, 1)

				for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
					G.reagents.trans_to(src, G.reagents.total_volume)

				if(src.reagents.total_volume) //The possible reactions didnt use up all reagents.
					var/datum/effects/system/steam_spread/steam = new /datum/effects/system/steam_spread()
					steam.set_up(10, 0, get_turf(src))
					steam.attach(src)
					steam.start()

					for(var/atom/A in view(affected_area, src.loc))
						if( A == src ) continue
						src.reagents.reaction(A, 1, 10)


				invisibility = 100 //Why am i doing this?
				spawn(50)		   //To make sure all reagents can work
					del(src)	   //correctly before deleting the grenade.
			else
				icon_state = initial(icon_state) + "_locked"
				crit_fail = 1
				for(var/obj/item/weapon/reagent_containers/glass/G in beakers)
					G.loc = get_turf(src.loc)
