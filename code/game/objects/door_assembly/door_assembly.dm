
obj/door_assembly
	icon = 'door_assembly.dmi'
	name = "Airlock Assembly"
	icon_state = "door_as0"
	anchored = 0
	density = 1
	var
		state = 0
		glass = 0
		base_icon_state
		obj/item/weapon/airlock_electronics/electronics = null
		airlock_type = /obj/machinery/door/airlock //the type path of the airlock once completed
		glass_type = /obj/machinery/door/airlock/glass //the type path of the airlock if changed into a glass airlock
		glass_base_icon_state = "door_as_g"

	New()
		base_icon_state = copytext(icon_state,1,lentext(icon_state))

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, /obj/item/weapon/weldingtool) && W:welding && !anchored )
			if (W:remove_fuel(0,user))
				W:welding = 2
				user.visible_message("[user] dissassembles the airlock assembly.", "You start to dissassemble the airlock assembly.")
				playsound(src.loc, 'Welder2.ogg', 50, 1)
				if (do_after(user, 40))
					user << "\blue You dissasembled the airlock assembly!"
					new /obj/item/stack/sheet/metal(get_turf(src), 4)
					if (src.glass==1)
						new /obj/item/stack/sheet/rglass(get_turf(src))
					del(src)
				W:welding = 1
			else
				user << "\blue You need more welding fuel to dissassemble the airlock assembly."
				return
		else if (istype(W, /obj/item/weapon/wrench) && !anchored )
			playsound(src.loc, 'Ratchet.ogg', 100, 1)
			var/turf/T = get_turf(user)
			user.visible_message("[user] secures the airlock assembly to the floor.", "You start to secure the airlock assembly to the floor.")
			sleep(40)
			if (get_turf(user) == T)
				user << "\blue You secured the airlock assembly!"
				src.name = "Secured Airlock Assembly"
				src.anchored = 1
		else if (istype(W, /obj/item/weapon/wrench) && anchored )
			playsound(src.loc, 'Ratchet.ogg', 100, 1)
			var/turf/T = get_turf(user)
			user.visible_message("[user] unsecures the airlock assembly from the floor.", "You start to unsecure the airlock assembly from the floor.")
			sleep(40)
			if (get_turf(user) == T)
				user << "\blue You unsecured the airlock assembly!"
				src.name = "Airlock Assembly"
				src.anchored = 0
		else if (istype(W, /obj/item/cable_coil) && state == 0 && anchored )
			var/obj/item/cable_coil/coil = W
			var/turf/T = get_turf(user)
			user.visible_message("[user] wires the airlock assembly.", "You start to wire the airlock assembly.")
			sleep(40)
			if (get_turf(user) == T)
				coil.use(1)
				src.state = 1
				user << "\blue You wire the Airlock!"
				src.name = "Wired Airlock Assembly"
		else if (istype(W, /obj/item/weapon/wirecutters) && state == 1 )
			playsound(src.loc, 'Wirecutter.ogg', 100, 1)
			var/turf/T = get_turf(user)
			user.visible_message("[user] cuts the wires from the airlock assembly.", "You start to cut the wires from airlock assembly.")
			sleep(40)
			if (get_turf(user) == T)
				user << "\blue You cut the airlock wires.!"
				new/obj/item/cable_coil(T, 1)
				src.state = 0
				src.name = "Secured Airlock Assembly"
		else if (istype(W, /obj/item/weapon/airlock_electronics) && state == 1 )
			playsound(src.loc, 'Screwdriver.ogg', 100, 1)
			var/turf/T = get_turf(user)
			user.visible_message("[user] installs the electronics into the airlock assembly.", "You start to install electronics into the airlock assembly.")
			user.drop_item()
			W.loc = src
			sleep(40)
			if (get_turf(user) == T)
				user << "\blue You installed the airlock electronics!"
				src.state = 2
				src.name = "Near finished Airlock Assembly"
				src.electronics = W
			else
				W.loc = src.loc

				//del(W)
		else if (istype(W, /obj/item/weapon/crowbar) && state == 2 )
			playsound(src.loc, 'Crowbar.ogg', 100, 1)
			var/turf/T = get_turf(user)
			user.visible_message("[user] removes the electronics from the airlock assembly.", "You start to install electronics into the airlock assembly.")
			sleep(40)
			if (get_turf(user) == T)
				user << "\blue You removed the airlock electronics!"
				src.state = 1
				src.name = "Wired Airlock Assembly"
				var/obj/item/weapon/airlock_electronics/ae
				if (!electronics)
					ae = new/obj/item/weapon/airlock_electronics( src.loc )
				else
					ae = electronics
					electronics = null
					ae.loc = src.loc
		else if (istype(W, /obj/item/stack/sheet/rglass) && glass == 0)
			playsound(src.loc, 'Crowbar.ogg', 100, 1)
			user.visible_message("[user] adds reinforced glass windows to the airlock assembly.", "You start to install reinforced glass windows into the airlock assembly.")
			var/obj/item/stack/sheet/rglass/G = W
			if (do_after(user, 40) && G.amount>=1)
				user << "\blue You installed glass windows the airlock assembly!"
				G.use(1)
				src.glass = 1
				src.name = "Near finished Window Airlock Assembly"
				src.airlock_type = /obj/machinery/door/airlock/glass
				src.base_icon_state = "door_as_g" //this will be applied to the icon_state with the correct state number at the proc's end.
		else if (istype(W, /obj/item/weapon/screwdriver) && state == 2 )
			playsound(src.loc, 'Screwdriver.ogg', 100, 1)
			var/turf/T = get_turf(user)
			user << "\blue Now finishing the airlock."
			sleep(40)
			if (get_turf(user) == T)
				user << "\blue You finish the airlock!"
				var/obj/machinery/door/airlock/door
				if (glass)
					door = new src.glass_type( src.loc )
				else
					door = new src.airlock_type( src.loc )
				//door.req_access = src.req_access
				door.electronics = src.electronics
				door.req_access = src.electronics.conf_access
				src.electronics.loc = door
				del(src)
		else
			..()
		if (glass)
			icon_state = "[glass_base_icon_state][state]"
		else
			icon_state = "[base_icon_state][state]"
		//This updates the icon_state. They are named as "door_as1_eng" where the 1 in that example
		//represents what state it's in. So the most generic algorithm for the correct updating of
		//this is simply to change the number.

/*
	door_assembly_mhatch
		name = "Airtight Maintenance Hatch Assembly"
		icon_state = "door_as_mhatch1"
		airlock_type = /obj/machinery/door/airlock/maintenance_hatch
		anchored = 1
		density = 1
		state = 1
		glass = 0
*/
