
/obj/machinery/mineral/stacking_machine
	name = "Stacking machine"
	icon = 'mining_machines.dmi'
	icon_state = "stacker"
	density = 1
	anchored = 1.0
	var/obj/machinery/mineral/stacking_unit_console/CONSOLE
	var/stk_types = list()
	var/stk_amt   = list()
	var/obj/machinery/mineral/input = null
	var/obj/machinery/mineral/output = null
	var/ore_gold = 0;
	var/ore_silver = 0;
	var/ore_diamond = 0;
	var/ore_plasma = 0;
	var/ore_iron = 0;
	var/ore_uranium = 0;
	var/ore_clown = 0;
	var/ore_glass = 0;
	var/ore_rglass = 0;
	var/ore_steel = 0;
	var/ore_adamantine = 0;
	var/stack_amt = 50; //ammount to stack before releassing

/obj/machinery/mineral/stacking_machine/New()
	..()
	spawn( 5 )
		for (var/dir in cardinal)
			src.input = locate(/obj/machinery/mineral/input, get_step(src, dir))
			if (src.input) break
		for (var/dir in cardinal)
			src.output = locate(/obj/machinery/mineral/output, get_step(src, dir))
			if (src.output) break
		processing_objects.Add(src)
		return
	return

/obj/machinery/mineral/stacking_machine/process()
	if (src.output && src.input)
		var/obj/item/O
		while (locate(/obj/item, input.loc))
			O = locate(/obj/item, input.loc)
			if (istype(O,/obj/item/stack/sheet/metal))
				ore_iron+= O:amount;
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/diamond))
				ore_diamond+= O:amount;
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/plasma))
				ore_plasma+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/gold))
				ore_gold+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/silver))
				ore_silver+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/clown))
				ore_clown+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/uranium))
				ore_uranium+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/glass))
				ore_glass+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/rglass))
				ore_rglass+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/r_metal))
				ore_steel+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/stack/sheet/adamantine))
				ore_adamantine+= O:amount
				del(O)
				//continue
			if (istype(O,/obj/item/weapon/ore/slag))
				del(O)
				//continue
			O.loc = src.output.loc
	if (ore_gold >= stack_amt)
		var/obj/item/stack/sheet/gold/G = new /obj/item/stack/sheet/gold
		G.amount = stack_amt
		G.loc = output.loc
		ore_gold -= stack_amt
		//return
	if (ore_silver >= stack_amt)
		var/obj/item/stack/sheet/silver/G = new /obj/item/stack/sheet/silver
		G.amount = stack_amt
		G.loc = output.loc
		ore_silver -= stack_amt
		//return
	if (ore_diamond >= stack_amt)
		var/obj/item/stack/sheet/diamond/G = new /obj/item/stack/sheet/diamond
		G.amount = stack_amt
		G.loc = output.loc
		ore_diamond -= stack_amt
		//return
	if (ore_plasma >= stack_amt)
		var/obj/item/stack/sheet/plasma/G = new /obj/item/stack/sheet/plasma
		G.amount = stack_amt
		G.loc = output.loc
		ore_plasma -= stack_amt
		//return
	if (ore_iron >= stack_amt)
		var/obj/item/stack/sheet/metal/G = new /obj/item/stack/sheet/metal
		G.amount = stack_amt
		G.loc = output.loc
		ore_iron -= stack_amt
		//return
	if (ore_clown >= stack_amt)
		var/obj/item/stack/sheet/clown/G = new /obj/item/stack/sheet/clown
		G.amount = stack_amt
		G.loc = output.loc
		ore_clown -= stack_amt
		//return
	if (ore_uranium >= stack_amt)
		var/obj/item/stack/sheet/uranium/G = new /obj/item/stack/sheet/uranium
		G.amount = stack_amt
		G.loc = output.loc
		ore_uranium -= stack_amt
		//return
	if (ore_glass >= stack_amt)
		var/obj/item/stack/sheet/glass/G = new /obj/item/stack/sheet/glass
		G.amount = stack_amt
		G.loc = output.loc
		ore_glass -= stack_amt
		//return
	if (ore_rglass >= stack_amt)
		var/obj/item/stack/sheet/rglass/G = new /obj/item/stack/sheet/rglass
		G.amount = stack_amt
		G.loc = output.loc
		ore_rglass -= stack_amt
		//return
	if (ore_steel >= stack_amt)
		var/obj/item/stack/sheet/r_metal/G = new /obj/item/stack/sheet/r_metal
		G.amount = stack_amt
		G.loc = output.loc
		ore_steel -= stack_amt
		//return
	if (ore_adamantine >= stack_amt)
		var/obj/item/stack/sheet/adamantine/G = new /obj/item/stack/sheet/adamantine
		G.amount = stack_amt
		G.loc = output.loc
		ore_adamantine -= stack_amt
		//return
	return
