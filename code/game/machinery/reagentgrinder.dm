
/obj/machinery/reagentgrinder
	name = "Reagent Grinder"
	icon = 'kitchen.dmi'
	icon_state = "juicer1"
	layer = 2.9
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 5
	active_power_usage = 100
	var/obj/item/weapon/reagent_containers/beaker = null
	var/global/list/allowed_items = list (
		/obj/item/stack/sheet/plasma = "plasma",
		/obj/item/stack/sheet/uranium = "uranium",
		/obj/item/stack/sheet/clown = "banana",
		/obj/item/stack/sheet/silver = "silver",
		/obj/item/stack/sheet/gold = "gold",
		/obj/item/weapon/reagent_containers/food/snacks/grown/banana = "banana",
		/obj/item/weapon/reagent_containers/food/snacks/grown/carrot = "imidazoline",
		/obj/item/weapon/reagent_containers/food/snacks/grown/corn = "cornoil",
		/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap = "psilocybin",
		/obj/item/weapon/reagent_containers/food/snacks/grown/chili = "capsaicin",
		/obj/item/weapon/reagent_containers/food/snacks/grown/icepepper = "frostoil",
		/obj/item/weapon/grown/nettle = "acid",
		/obj/item/weapon/grown/deathnettle = "pacid",
	)

/obj/machinery/reagentgrinder/New()
	..()
	beaker = new /obj/item/weapon/reagent_containers/glass/large(src)
	return

/obj/machinery/reagentgrinder/update_icon()
	icon_state = "juicer"+num2text(!isnull(beaker))
	return


/obj/machinery/reagentgrinder/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if (istype(O,/obj/item/weapon/reagent_containers/glass) || \
		istype(O,/obj/item/weapon/reagent_containers/food/drinks/drinkingglass))
		if (beaker)
			return 1
		else
			user.before_take_item(O)
			O.loc = src
			beaker = O
			src.verbs += /obj/machinery/reagentgrinder/verb/detach
			update_icon()
			src.updateUsrDialog()
			return 0
	if (!is_type_in_list(O, allowed_items))
		user << "Cannot refine into a reagent."
		return 1
	user.before_take_item(O)
	O.loc = src
	src.updateUsrDialog()
	return 0

/obj/machinery/reagentgrinder/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/reagentgrinder/attack_ai(mob/user as mob)
	return 0

/obj/machinery/reagentgrinder/attack_hand(mob/user as mob)
	user.machine = src
	interact(user)

/obj/machinery/reagentgrinder/proc/interact(mob/user as mob) // The microwave Menu
	var/is_chamber_empty = 0
	var/is_beaker_ready = 0
	var/processing_chamber = ""
	var/beaker_contents = ""

	for (var/i in allowed_items)
		for (var/obj/item/O in src.contents)
			if (!istype(O,i))
				continue
			processing_chamber+= "some <B>[O]</B><BR>"
			break
	if (!processing_chamber)
		is_chamber_empty = 1
		processing_chamber = "Nothing."
	if (!beaker)
		beaker_contents = "\The [src] has no beaker attached."
	else if (!beaker.reagents.total_volume)
		beaker_contents = "\The [src]  has attached an empty beaker."
		is_beaker_ready = 1
	else if (beaker.reagents.total_volume < beaker.reagents.maximum_volume)
		beaker_contents = "\The [src]  has attached a beaker with something."
		is_beaker_ready = 1
	else
		beaker_contents = "\The [src]  has attached a beaker and the beaker is full!"

	var/dat = {"
<b>Processing chamber contains:</b><br>
[processing_chamber]<br>
[beaker_contents]<hr>
"}
	if (is_beaker_ready && !is_chamber_empty && !(stat & (NOPOWER|BROKEN)))
		dat += "<A href='?src=\ref[src];action=grind'>Turn on!<BR>"
	if (beaker)
		dat += "<A href='?src=\ref[src];action=detach'>Detach a beaker!<BR>"
	user << browse("<HEAD><TITLE>Reagent Grinder</TITLE></HEAD><TT>[dat]</TT>", "window=reagentgrinder")
	onclose(user, "reagentgrinder")
	return


/obj/machinery/reagentgrinder/Topic(href, href_list)
	if (..())
		return
	usr.machine = src
	switch(href_list["action"])
		if ("grind")
			grind()

		if ("detach")
			detach()
	src.updateUsrDialog()
	return

/obj/machinery/reagentgrinder/verb/detach()
	set category = "Object"
	set name = "Detach Beaker from the grinder"
	set src in oview(1)
	if (usr.stat != 0)
		return
	if (!beaker)
		return
	src.verbs -= /obj/machinery/reagentgrinder/verb/detach
	beaker.loc = src.loc
	beaker = null
	update_icon()

/obj/machinery/reagentgrinder/proc/get_juice_id(var/obj/item/weapon/reagent_containers/food/snacks/grown/O)
	for (var/i in allowed_items)
		if (istype(O, i))
			return allowed_items[i]

/obj/machinery/reagentgrinder/proc/get_juice_amount(var/obj/item/weapon/reagent_containers/food/snacks/grown/O)
	if (!istype(O))
		return 5
	else if (O.potency == -1)
		return 5
	else
		return round(O.potency / 5)

/obj/machinery/reagentgrinder/proc/get_grownweapon_id(var/obj/item/weapon/grown/O)
	for (var/i in allowed_items)
		if (istype(O, i))
			return allowed_items[i]

/obj/machinery/reagentgrinder/proc/get_grownweapon_amount(var/obj/item/weapon/grown/O)
	if (!istype(O))
		return 5
	else if (O.potency == -1)
		return 5
	else
		return round(O.potency)

/obj/machinery/reagentgrinder/proc/get_grind_id(var/obj/item/stack/sheet/O)
	for (var/i in allowed_items)
		if (istype(O, i))
			return allowed_items[i]

/obj/machinery/reagentgrinder/proc/get_grind_amount(var/obj/item/stack/sheet/O)
	return 20

/obj/machinery/reagentgrinder/proc/grind()
	power_change()
	if (stat & (NOPOWER|BROKEN))
		return
	if (!beaker || beaker.reagents.total_volume >= beaker.reagents.maximum_volume)
		return
	playsound(src.loc, 'juicer.ogg', 20, 1)
	for (var/obj/item/weapon/reagent_containers/food/snacks/O in src.contents)
		var/r_id = get_juice_id(O)
		beaker.reagents.add_reagent(r_id,get_juice_amount(O))
		del(O)
		if (beaker.reagents.total_volume >= beaker.reagents.maximum_volume)
			break
	for (var/obj/item/stack/sheet/O in src.contents)
		var/g_id = get_grind_id(O)
		beaker.reagents.add_reagent(g_id,get_grind_amount(O))
		del(O)
		if (beaker.reagents.total_volume >= beaker.reagents.maximum_volume)
			break
	for (var/obj/item/weapon/grown/O in src.contents)
		var/g_id = get_grownweapon_id(O)
		beaker.reagents.add_reagent(g_id,get_grownweapon_amount(O))
		del(O)
		if (beaker.reagents.total_volume >= beaker.reagents.maximum_volume)
			break
