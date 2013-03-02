/obj/item/weapon/storage
	icon = 'storage.dmi'
	name = "storage"
	var/list/can_hold = new/list() //List of objects which this item can store (if set, it can't store anything else)
	var/list/cant_hold = new/list() //List of objects which this item can't store (in effect only if can_hold isn't set)
	var/max_w_class = 2 //Max size of objects that this object can store (in effect only if can_hold isn't set)
	var/max_combined_w_class = 14 //The sum of the w_classes of all the items in this storage item.
	var/storage_slots = 7 //The number of storage slots in this container.
	var/obj/screen/storage/boxes = null
	var/obj/screen/close/closer = null
	w_class = 3.0

/obj/item/weapon/storage/proc/return_inv()

	var/list/L = list(  )

	L += src.contents

	for(var/obj/item/weapon/storage/S in src)
		L += S.return_inv()
	for(var/obj/item/gift/G in src)
		L += G.gift
		if (istype(G.gift, /obj/item/weapon/storage))
			L += G.gift:return_inv()
	return L

/obj/item/weapon/storage/proc/show_to(mob/user as mob)
	for(var/obj/item/weapon/mousetrap/MT in src)
		if(MT.armed)
			for(var/mob/O in viewers(user, null))
				if(O == user)
					user.show_message(text("\red <B>You reach into the [src.name], but there was a live mousetrap in there!</B>"), 1)
				else
					user.show_message(text("\red <B>[user] reaches into the [src.name] and sets off a hidden mousetrap!</B>"), 1)
			MT.loc = user.loc
			MT.triggered(user, user.hand ? "l_hand" : "r_hand")
			MT.layer = OBJ_LAYER
			return
	user.client.screen -= src.boxes
	user.client.screen -= src.closer
	user.client.screen -= src.contents
	user.client.screen += src.boxes
	user.client.screen += src.closer
	user.client.screen += src.contents
	user.s_active = src
	return

/obj/item/weapon/storage/proc/hide_from(mob/user as mob)

	if(!user.client)
		return
	user.client.screen -= src.boxes
	user.client.screen -= src.closer
	user.client.screen -= src.contents
	return

/obj/item/weapon/storage/proc/close(mob/user as mob)

	src.hide_from(user)
	user.s_active = null
	return

//This proc draws out the inventory and places the items on it. tx and ty are the upper left tile and mx, my are the bottm right.
//The numbers are calculated from the bottom-left (Right hand slot on the map) being 1,1.
/obj/item/weapon/storage/proc/orient_objs(tx, ty, mx, my)
	var/cx = tx
	var/cy = ty
	src.boxes.screen_loc = text("[tx],[ty] to [mx],[my]")
	for(var/obj/O in src.contents)
		O.screen_loc = text("[cx],[cy]")
		O.layer = 20
		cx++
		if (cx > mx)
			cx = tx
			cy--
	src.closer.screen_loc = text("[mx+1],[my]")
	return

//This proc determins the size of the inventory to be displayed. Please touch it only if you know what you're doing.
/obj/item/weapon/storage/proc/orient2hud(mob/user as mob)
	var/mob/living/carbon/human/H = user
	var/col_num = 0
	var/row_count = min(7,storage_slots) -1
	if (contents.len > 7)
		if(contents.len % 7) //So having 14 items keeps them in 2 wors instead of 3
			col_num = round(contents.len / 7) // 7 is the maximum allowed column height for r_hand, l_hand and back storage items.
	if (src == user.l_hand)
		src.orient_objs(3-col_num, 3+row_count, 3, 3)
	else if(src == user.r_hand)
		src.orient_objs(1, 3+row_count, 1+col_num, 3)
	else if(src == user.back)
		src.orient_objs(4-col_num, 3+row_count, 4, 3)
	else if(istype(user, /mob/living/carbon/human) && src == H.belt)//only humans have belts
		src.orient_objs(1, 3, 8, 3)
	else
		src.orient_objs(5, 10, 11, 10)
	return

//This proc is called when you want to place an item into the storage item.
/obj/item/weapon/storage/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(isrobot(user))
		user << "\blue You're a robot. No."
		return //Robots can't interact with storage items.

	if(src.loc == W)
		return //Means the item is already in the storage item

	if(contents.len >= storage_slots)
		user << "\red The [src] is full, make some space."
		return //Storage item is full

	if(can_hold.len)
		var/ok = 0
		for(var/A in can_hold)
			if(istype(W, text2path(A) ))
				ok = 1
				break
		if(!ok)
			user << "\red This [src] cannot hold [W]."
			return

	for(var/A in cant_hold) //Check for specific items which this container can't hold.
		if(istype(W, text2path(A) ))
			user << "\red This [src] cannot hold [W]."
			return

	if (W.w_class > max_w_class)
		user << "\red This [W] is too big for this [src]"
		return

	var/sum_w_class = W.w_class
	for(var/obj/item/I in contents)
		sum_w_class += I.w_class //Adds up the combined w_classes which will be in the storage item if the item is added to it.

	if(sum_w_class > max_combined_w_class)
		user << "\red The [W] cannot fit in the [src]. Remove some items or add a smaller one.."
		return

	if ( W.w_class >= src.w_class && (istype(W, /obj/item/weapon/storage)))
		user << "\red The [src] cannot hold  [W] as it's a storage item of the same size."
		return //To prevent the stacking of the same sized items.

	user.u_equip(W)
	W.loc = src
	if ((user.client && user.s_active != src))
		user.client.screen -= W
	src.orient2hud(user)
	W.dropped(user)
	add_fingerprint(user)
	if (istype(W, /obj/item/weapon/gun/energy/crossbow)) return //STEALTHY
	for(var/mob/O in viewers(user, null))
		O.show_message(text("\blue [user] has added [W] to [src]!"))
		//Foreach goto(139)
	return

/obj/item/weapon/storage/dropped(mob/user as mob)
	src.orient_objs(5,10,12,10)
	return

/obj/item/weapon/storage/MouseDrop(over_object, src_location, over_location)
	..()
	if ((over_object == usr && (in_range(src, usr) || usr.contents.Find(src))))
		if (usr.s_active)
			usr.s_active.close(usr)
		src.show_to(usr)
	return

/obj/item/weapon/storage/attack_paw(mob/user as mob)
	playsound(src.loc, "rustle", 50, 1, -5)
	return src.attack_hand(user)

/obj/item/weapon/storage/attack_hand(mob/user as mob)
	playsound(src.loc, "rustle", 50, 1, -5)
	if (src.loc == user)
		if (user.s_active)
			user.s_active.close(user)
		src.show_to(user)
	else
		..()
		for(var/mob/M in range(1))
			if (M.s_active == src)
				src.close(M)
	src.orient2hud(user)
	src.add_fingerprint(user)
	return

/obj/item/weapon/storage/New()

	src.boxes = new /obj/screen/storage(  )
	src.boxes.name = "storage"
	src.boxes.master = src
	src.boxes.icon_state = "block"
	src.boxes.screen_loc = "7,7 to 10,8"
	src.boxes.layer = 19
	src.closer = new /obj/screen/close(  )
	src.closer.master = src
	src.closer.icon_state = "x"
	src.closer.layer = 20
	spawn( 5 )
		src.orient_objs(5, 10, 12, 10)
		return
	return

/obj/item/weapon/storage/emp_act(severity)
	if(!istype(src.loc, /mob/living))
		for(var/obj/O in contents)
			O.emp_act(severity)
	..()

/obj/item/weapon/storage/box
	name = "Box"
	icon_state = "box"
	item_state = "syringe_kit"

/obj/item/weapon/storage/box/survival/New()
	..()
	contents = list()
	sleep(1)
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/weapon/tank/emergency_oxygen( src )
	return

/obj/item/weapon/storage/box/engineer/New()
	..()
	contents = list()
	sleep(1)
	new /obj/item/clothing/mask/breath( src )
	new /obj/item/weapon/tank/emergency_oxygen/engi( src )
	return

/obj/item/weapon/storage/box/syndicate/New()
	..()
	switch (pickweight(list("bloodyspai" = 1, "stealth" = 1, "screwed" = 1, "guns" = 1, "murder" = 1, "freedom" = 1)))
		if ("bloodyspai")
			new /obj/item/clothing/under/chameleon(src)
			new /obj/item/clothing/mask/gas/voice(src)
			new /obj/item/weapon/card/id/syndicate(src)
			new /obj/item/clothing/shoes/syndigaloshes(src)
			return

		if ("stealth")
			new /obj/item/weapon/gun/energy/crossbow(src)
			new /obj/item/weapon/pen/sleepypen(src)
			new /obj/item/device/chameleon(src)
			return

		if ("screwed")
			new /obj/spawner/newbomb/timer/syndicate(src)
			new /obj/spawner/newbomb/timer/syndicate(src)
			new /obj/item/device/powersink(src)
			new /obj/item/clothing/suit/space/syndicate(src)
			new /obj/item/clothing/head/helmet/space/syndicate(src)
			return

		if ("guns")
			new /obj/item/weapon/gun/projectile(src)
			new /obj/item/ammo_magazine(src)
			new /obj/item/weapon/card/emag(src)
			new /obj/item/weapon/plastique(src)
			return

		if ("murder")
			new /obj/item/weapon/melee/energy/sword(src)
			new /obj/item/weapon/cloaking_device(src)
			new /obj/item/weapon/card/emag(src)
			return

		if("freedom")
			var/obj/item/weapon/implanter/O = new /obj/item/weapon/implanter(src)
			O.imp = new /obj/item/weapon/implant/freedom(O)
			var/obj/item/weapon/implanter/U = new /obj/item/weapon/implanter(src)
			U.imp = new /obj/item/weapon/implant/uplink(U)
			return

/obj/item/weapon/storage/dice
	name = "dice pack"
	desc = "Apparently this has dice in them."
	icon_state = "pill_canister"
	icon = 'chemical.dmi'
	item_state = "contsolid"
	w_class = 2.0
	can_hold = list("/obj/item/weapon/dice")

/obj/item/weapon/storage/dice/New()
	new /obj/item/weapon/dice( src )
	new /obj/item/weapon/dice/d20( src )
	..()
	return

/obj/item/weapon/storage/mousetraps
	name = "Pest-B-Gon Mousetraps"
	desc = "WARNING: Keep out of reach of children."
	icon_state = "mousetraps"
	item_state = "syringe_kit"

/obj/item/weapon/storage/mousetraps/New()
	new /obj/item/weapon/mousetrap( src )
	new /obj/item/weapon/mousetrap( src )
	new /obj/item/weapon/mousetrap( src )
	new /obj/item/weapon/mousetrap( src )
	new /obj/item/weapon/mousetrap( src )
	new /obj/item/weapon/mousetrap( src )
	..()
	return

/obj/item/weapon/storage/pillbottlebox
	name = "pill bottles"
	desc = "A box of pill bottles."
	icon_state = "box"
	item_state = "syringe_kit"

/obj/item/weapon/storage/pillbottlebox/New()
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	new /obj/item/weapon/storage/pill_bottle( src )
	..()
	return

//Some spare PDAs in a box

/obj/item/weapon/storage/PDAbox
	name = "spare PDAs"
	desc = "A box of spare PDA microcomputers."
	icon = 'pda.dmi'
	icon_state = "pdabox"
	item_state = "syringe_kit"

/obj/item/weapon/storage/PDAbox/New()
	..()
	new /obj/item/device/pda(src)
	new /obj/item/device/pda(src)
	new /obj/item/device/pda(src)
	new /obj/item/device/pda(src)

	var/newcart = pick(1,2,3,4)
	switch(newcart)
		if(1)
			new /obj/item/weapon/cartridge/janitor(src)
		if(2)
			new /obj/item/weapon/cartridge/security(src)
		if(3)
			new /obj/item/weapon/cartridge/medical(src)
		if(4)
			new /obj/item/weapon/cartridge/head(src)

	new /obj/item/weapon/cartridge/signal/toxins(src)

/obj/item/weapon/storage/explorers_box
	name = "SpaceFriend(tm)"
	icon_state = "box"
	desc = "Everything a dashing space explorer would want to have near in the grim darkness of... whatever."

/obj/item/weapon/storage/explorers_box/New()
	..()
	new /obj/item/device/radio/beacon(src)
	new /obj/item/device/gps(src)
	new /obj/item/device/flashlight(src)
	new /obj/item/weapon/reagent_containers/food/drinks/beer(src)
	new /obj/item/weapon/reagent_containers/food/snacks/chips(src)
	new /obj/item/weapon/cigpacket(src)
	var/obj/item/weapon/reagent_containers/pill/P = new/obj/item/weapon/reagent_containers/pill(src)
	P.reagents.add_reagent("nutriment", 500)
	P.name = "Cyanide pill"
	return

/obj/item/weapon/storage/mechatrackingbox
	name = "Mech tracking box"
	icon_state = "box"
	desc = "Contains mech trackers so they aren't all just laying around the place."

/obj/item/weapon/storage/mechatrackingbox/New()
	new /obj/item/mecha_tracking(src)
	new /obj/item/mecha_tracking(src)
	new /obj/item/mecha_tracking(src)
	new /obj/item/mecha_tracking(src)
	new /obj/item/mecha_tracking(src)
	new /obj/item/mecha_tracking(src)
	new /obj/item/mecha_tracking(src)
	..()
	return

////////////////////////////////////////////////////////////////////////////////


/obj/item/weapon/storage/utilitybelt
	name = "utility belt"
	desc = "Can hold various tools."
	icon = 'belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	can_hold = list(
		"/obj/item/weapon/crowbar",
		"/obj/item/weapon/screwdriver",
		"/obj/item/weapon/weldingtool",
		"/obj/item/weapon/wirecutters",
		"/obj/item/weapon/wrench",
		"/obj/item/device/multitool",
		"/obj/item/device/flashlight",
		"/obj/item/cable_coil",
		"/obj/item/device/t_scanner",
		"/obj/item/device/analyzer")
	flags = FPRINT | TABLEPASS | ONBELT

/obj/item/weapon/storage/utilitybelt/proc/can_use()
	if(!ismob(loc)) return 0
	var/mob/M = loc
	if(src in M.get_equipped_items())
		return 1
	else
		return 0

/obj/item/weapon/storage/utilitybelt/dropped(mob/user as mob)
	..()

/obj/item/weapon/storage/utilitybelt/MouseDrop(obj/over_object as obj, src_location, over_location)
	var/mob/M = usr
	if (!istype(over_object, /obj/screen))
		if(can_use())
			return ..()
		else
			M << "\red I need to wear the belt for that."
			return
	playsound(src.loc, "rustle", 50, 1, -5)
	if (!M.restrained() && !M.stat && can_use())
		if (over_object.name == "r_hand")
			if (!( M.r_hand ))
				M.u_equip(src)
				M.r_hand = src
		else
			if (over_object.name == "l_hand")
				if (!( M.l_hand ))
					M.u_equip(src)
					M.l_hand = src
		M.update_clothing()
		src.add_fingerprint(usr)
		return

/obj/item/weapon/storage/utilitybelt/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/weapon/storage/utilitybelt/attack_hand(mob/user as mob)
	if (src.loc == user)
		if(can_use())
			playsound(src.loc, "rustle", 50, 1, -5)
			if (user.s_active)
				user.s_active.close(user)
			src.show_to(user)
		else
			user << "\red I need to wear the belt for that."
			return
	else
		return ..()

	src.add_fingerprint(user)

/obj/item/weapon/storage/utilitybelt/attackby(obj/item/weapon/W as obj, mob/user as mob)
	//..()  //This will make it impossible to wrap the belt in wrapping paper, but will enable them to work as intended once more.
	if(!can_use())
		user << "\red I need to wear the belt for that."
		return
	else
		..()

/obj/item/weapon/storage/utilitybelt/full/New()
	..()
	new /obj/item/weapon/screwdriver(src)
	new /obj/item/weapon/wrench(src)
	new /obj/item/weapon/weldingtool(src)
	new /obj/item/weapon/crowbar(src)
	new /obj/item/weapon/wirecutters(src)
	new /obj/item/cable_coil(src,30,pick("red","yellow"))


/obj/item/weapon/storage/utilitybelt/medical
   name = "medical belt"
   desc = "Can hold various medical equipment."
   icon_state = "medicalbelt"
   item_state = "medical"
   can_hold = list(
		"/obj/item/device/healthanalyzer",
		"/obj/item/weapon/dnainjector",
		"/obj/item/weapon/reagent_containers/dropper",
		"/obj/item/weapon/reagent_containers/glass/beaker",
		"/obj/item/weapon/reagent_containers/glass/bottle",
		"/obj/item/weapon/reagent_containers/pill",
		"/obj/item/weapon/reagent_containers/syringe",
		"/obj/item/weapon/reagent_containers/glass/dispenser",
		"/obj/item/weapon/zippo",
		"/obj/item/weapon/cigpacket",
		"/obj/item/weapon/storage/pill_bottle",
		"/obj/item/stack/medical",
		"/obj/item/device/flashlight/pen"
	)
   flags = FPRINT | TABLEPASS | ONBELT

/*
/obj/item/weapon/storage/lbe
	name = "Load Bearing Equipment"
	desc = "You wear these on your thighs, they help carry heavy loads."
	icon_state = "backpack" //PLACEHOLDER
	w_class = 2.0
	max_combined_w_class = 17
*/

/obj/item/weapon/storage/katanabelt
	name = "katana belt"
	desc = "A fabric belt that has a japanese katana hanging off of it."
	icon = 'belts.dmi'
	icon_state = "katanabelt"
	item_state = "katana"
	can_hold = list(
		"/obj/item/weapon/katanasword")
	storage_slots = 1
	flags = FPRINT | TABLEPASS | ONBELT

/*
/obj/item/weapon/storage/katanabelt/full/New()
	..()
	new /obj/item/weapon/katanasword(src)
*/

/obj/item/weapon/storage/dualkatanabelt
	name = "Dual Katana belt"
	desc = "For when one katana isn't enough."
	icon = 'belts.dmi'
	icon_state = "dualkatanabelt"
	item_state = "dualkatana"
	can_hold = list(
		"/obj/item/weapon/katanasword")
	storage_slots = 1
	flags = FPRINT | TABLEPASS | ONBELT

/*
/obj/item/weapon/storage/dualkatanabelt/full/New()
	..()
	new /obj/item/weapon/twohanded/katanasword(src)
*/
