
//TODO: Split this one and the automatic one, or combine the automatic and manual function into one.
/obj/machinery/mineral/processing_unit
	name = "Furnace"
	icon = 'mining_machines.dmi'
	icon_state = "furnace"
	density = 1
	anchored = 1.0
	var/obj/machinery/mineral/input = null
	var/obj/machinery/mineral/output = null
	var/obj/machinery/mineral/CONSOLE = null
	var/ore_gold = 0;
	var/ore_silver = 0;
	var/ore_diamond = 0;
	var/ore_glass = 0;
	var/ore_plasma = 0;
	var/ore_uranium = 0;
	var/ore_iron = 0;
	var/ore_clown = 0;
	var/ore_adamantine = 0;

	//NOTE: The following are unused. Only kept in for compatability with the consoles.
	var/selected_gold = 0
	var/selected_silver = 0
	var/selected_diamond = 0
	var/selected_glass = 0
	var/selected_plasma = 0
	var/selected_uranium = 0
	var/selected_iron = 0
	var/selected_clown = 0
	var/selected_adamantine = 0

	var/on = 0 //0 = off, 1 =... oh you know!

/obj/machinery/mineral/processing_unit/New()
	..()
	spawn( 5 )
		for (var/dir in cardinal)
			src.input = locate(/obj/machinery/mineral/input, get_step(src, dir))
			if(src.input) break
		for (var/dir in cardinal)
			src.output = locate(/obj/machinery/mineral/output, get_step(src, dir))
			if(src.output) break
		processing_objects.Add(src)
		return
	return

/obj/machinery/mineral/processing_unit/process()
	if(src.output && src.input)
		var/i
		for (i = 0; i < 10; i++)

			if (ore_glass > 0)
				ore_glass--;
				new /obj/item/stack/sheet/glass(output.loc)
				//user.visible_message("Created glass sheets!")
			else
				on = 0

			if (ore_gold > 0)
				ore_gold--;
				new /obj/item/stack/sheet/gold(output.loc)
				//user.visible_message("Created gold sheets!")
			else
				on = 0

			if (ore_silver > 0)
				ore_silver--;
				new /obj/item/stack/sheet/silver(output.loc)
				//user.visible_message("Created silver sheets!")
			else
				on = 0

			if (ore_diamond > 0)
				ore_diamond--;
				new /obj/item/stack/sheet/diamond(output.loc)
				//user.visible_message("Created diamond sheets!")
			else
				on = 0

			if (ore_plasma > 0)
				ore_plasma--;
				new /obj/item/stack/sheet/plasma(output.loc)
				//user.visible_message("Created plasma sheets!")
			else
				on = 0

			if (ore_uranium > 0)
				ore_uranium--;
				new /obj/item/stack/sheet/uranium(output.loc)
				//user.visible_message("Created uranium sheets!")
			else
				on = 0

			if (ore_iron > 0)
				ore_iron--;
				new /obj/item/stack/sheet/metal(output.loc)
				//user.visible_message("Created metal sheets!")
			else
				on = 0

			if (ore_iron > 0)
				ore_iron--;
				new /obj/item/stack/sheet/metal(output.loc)
				//user.visible_message("Created metal sheets!")
			else
				on = 0

			if (ore_clown > 0)
				ore_clown--;
				new /obj/item/stack/sheet/clown(output.loc)
				//user.visible_message("Created clown sheets!")
			else
				on = 0

			if (ore_adamantine > 0)
				ore_adamantine--;
				new /obj/item/stack/sheet/adamantine(output.loc)
				//user.visible_message("Created adamantine sheets!")
			else
				on = 0

			//if a non valid combination is selected

			var/b = 1 //this part checks if all required ores are available

			if(!(ore_gold && ore_silver && ore_diamond && ore_glass && ore_plasma && ore_uranium && ore_iron && ore_clown && ore_adamantine))
				b = 0
				//world << "\red No ore!"

			if (b) //if they are, deduct one from each, produce slag and shut the machine off
				if (ore_gold == 1)
					ore_gold--
				if (ore_silver == 1)
					ore_silver--
				if (ore_diamond == 1)
					ore_diamond--
				if (ore_uranium == 1)
					ore_uranium--
				if (ore_plasma == 1)
					ore_plasma--
				if (ore_iron == 1)
					ore_iron--
				if (ore_clown == 1)
					ore_clown--
				if (ore_adamantine == 1)
					ore_adamantine--
				new /obj/item/weapon/ore/slag(output.loc)
				on = 0
			else
				on = 0
				break

		for (i = 0; i < 10; i++)
			var/obj/item/O
			O = locate(/obj/item, input.loc)
			if (O)
				if (istype(O,/obj/item/weapon/ore/iron))
					ore_iron++;
					//user.visible_message("Picked up iron ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/glass))
					ore_glass++;
					//user.visible_message("Picked up glass ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/diamond))
					ore_diamond++;
					//user.visible_message("Picked up diamond ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/plasma))
					ore_plasma++
					//user.visible_message("Picked up plasma ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/gold))
					ore_gold++
					//user.visible_message("Picked up gold ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/silver))
					ore_silver++
					//user.visible_message("Picked up silver ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/uranium))
					ore_uranium++
					//user.visible_message("Picked up uranium ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/clown))
					ore_clown++
					//user.visible_message("Picked up clown ore!")
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/adamantine))
					ore_adamantine++
					//user.visible_message("Picked up adamintine ore!")
					del(O)
					continue
				O.loc = src.output.loc
				on = 1
			else
				break
	return

/obj/machinery/mineral/processing_unit/attack_hand(mob/user as mob)

	if(!on)
		on = 1
		user.visible_message("[user.name] turns the [src.name] on.", \
			"You turn the [src.name] on.")
	else
		user << "\red Already on!"

/*/obj/machinery/mineral/processing_unit
	name = "Furnace"
	icon = 'mining_machines.dmi'
	icon_state = "furnace"
	density = 1
	anchored = 1.0
	var/obj/machinery/mineral/input = null
	var/obj/machinery/mineral/output = null
	var/obj/machinery/mineral/CONSOLE = null
	var/ore_gold = 0;
	var/ore_silver = 0;
	var/ore_diamond = 0;
	var/ore_glass = 0;
	var/ore_plasma = 0;
	var/ore_uranium = 0;
	var/ore_iron = 0;
	var/ore_clown = 0;
	var/ore_adamantine = 0;
	var/selected_gold = 0
	var/selected_silver = 0
	var/selected_diamond = 0
	var/selected_glass = 0
	var/selected_plasma = 0
	var/selected_uranium = 0
	var/selected_iron = 0
	var/selected_clown = 0
	var/selected_adamantine = 0
	var/on = 0 //0 = off, 1 =... oh you know!

/obj/machinery/mineral/processing_unit/New()
	..()
	spawn( 5 )
		for (var/dir in cardinal)
			src.input = locate(/obj/machinery/mineral/input, get_step(src, dir))
			if(src.input) break
		for (var/dir in cardinal)
			src.output = locate(/obj/machinery/mineral/output, get_step(src, dir))
			if(src.output) break
		processing_objects.Add(src)
		return
	return

/obj/machinery/mineral/processing_unit/process()
	if (src.output && src.input)
		var/i
		for (i = 0; i < 10; i++)
			if (1)
				//if (selected_glass == 1 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_glass > 0)
						ore_glass--;
						new /obj/item/stack/sheet/glass(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 1 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_gold > 0)
						ore_gold--;
						new /obj/item/stack/sheet/gold(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 1 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_silver > 0)
						ore_silver--;
						new /obj/item/stack/sheet/silver(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 1 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_diamond > 0)
						ore_diamond--;
						new /obj/item/stack/sheet/diamond(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 1 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_plasma > 0)
						ore_plasma--;
						new /obj/item/stack/sheet/plasma(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 1 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_uranium > 0)
						ore_uranium--;
						new /obj/item/stack/sheet/uranium(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 1 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_iron > 0)
						ore_iron--;
						new /obj/item/stack/sheet/metal(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 1 && selected_clown == 0 && selected_adamantine == 0)
				if(1)
					if (ore_iron > 0)
						ore_iron--;
						new /obj/item/stack/sheet/metal(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 1 && selected_adamantine == 0)
				if(1)
					if (ore_clown > 0)
						ore_clown--;
						new /obj/item/stack/sheet/clown(output.loc)
					else
						on = 0
					continue
				//if (selected_glass == 0 && selected_gold == 0 && selected_silver == 0 && selected_diamond == 0 && selected_plasma == 0 && selected_uranium == 0 && selected_iron == 0 && selected_clown == 0 && selected_adamantine == 1)
				if(1)
					if (ore_adamantine > 0)
						ore_adamantine--;
						new /obj/item/stack/sheet/adamantine(output.loc)
					else
						on = 0
					continue

				//if a non valid combination is selected

				var/b = 1 //this part checks if all required ores are available

				//if (!(selected_gold || selected_silver ||selected_diamond || selected_uranium | selected_plasma || selected_iron || selected_iron))
				//	b = 0

				//if (selected_gold == 1)
				if(1)
					if (ore_gold <= 0)
						b = 0
				//if (selected_silver == 1)
				if(1)
					if (ore_silver <= 0)
						b = 0
				//if (selected_diamond == 1)
				if(1)
					if (ore_diamond <= 0)
						b = 0
				//if (selected_uranium == 1)
				if(1)
					if (ore_uranium <= 0)
						b = 0
				//if (selected_plasma == 1)
				if(1)
					if (ore_plasma <= 0)
						b = 0
				//if (selected_iron == 1)
				if(1)
					if (ore_iron <= 0)
						b = 0
				//if (selected_glass == 1)
				if(1)
					if (ore_glass <= 0)
						b = 0
				//if (selected_clown == 1)
				if(1)
					if (ore_clown <= 0)
						b = 0
				//if (selected_adamantine == 1)
				if(1)
					if (ore_adamantine <= 0)
						b = 0

				if (b) //if they are, deduct one from each, produce slag and shut the machine off
					if (selected_gold == 1)
						ore_gold--
					if (selected_silver == 1)
						ore_silver--
					if (selected_diamond == 1)
						ore_diamond--
					if (selected_uranium == 1)
						ore_uranium--
					if (selected_plasma == 1)
						ore_plasma--
					if (selected_iron == 1)
						ore_iron--
					if (selected_clown == 1)
						ore_clown--
					if (selected_adamantine == 1)
						ore_adamantine--
					new /obj/item/weapon/ore/slag(output.loc)
					on = 0
				else
					on = 0
					break
				break
			else
				break
		for (i = 0; i < 10; i++)
			var/obj/item/O
			O = locate(/obj/item, input.loc)
			if (O)
				if (istype(O,/obj/item/weapon/ore/iron))
					ore_iron++;
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/glass))
					ore_glass++;
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/diamond))
					ore_diamond++;
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/plasma))
					ore_plasma++
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/gold))
					ore_gold++
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/silver))
					ore_silver++
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/uranium))
					ore_uranium++
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/clown))
					ore_clown++
					del(O)
					continue
				if (istype(O,/obj/item/weapon/ore/adamantine))
					ore_adamantine++
					del(O)
					continue
				O.loc = src.output.loc
			else
				break
	return*/
