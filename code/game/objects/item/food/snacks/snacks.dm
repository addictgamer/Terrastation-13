
/obj/item/weapon/reagent_containers/food/snacks		//Food items that are eaten normally and don't leave anything behind.
	name = "snack"
	desc = "yummy"
	icon = 'food.dmi'
	icon_state = null
	var/bitesize = 1
	var/bitecount = 0
	var/trash = null
	var/slice_path
	var/slices_num

	//Placeholder for effects that trigger on eating that aren't tied to reagents.
	proc/On_Consume()
		if (!trash) return
		if(!reagents.total_volume)
			var/mob/M = usr
			switch(trash)
				if ("raisins")
					var/obj/item/trash/raisins/T = new /obj/item/trash/raisins/( M )
					M.put_in_hand(T)
				if ("candy")
					var/obj/item/trash/candy/T = new /obj/item/trash/candy/( M )
					M.put_in_hand(T)
				if ("cheesie")
					var/obj/item/trash/cheesie/T = new /obj/item/trash/cheesie/( M )
					M.put_in_hand(T)
				if ("chips")
					var/obj/item/trash/chips/T = new /obj/item/trash/chips/( M )
					M.put_in_hand(T)
				if ("popcorn")
					var/obj/item/trash/popcorn/T = new /obj/item/trash/popcorn/( M )
					M.put_in_hand(T)
				if ("sosjerky")
					var/obj/item/trash/sosjerky/T = new /obj/item/trash/sosjerky/( M )
					M.put_in_hand(T)
				if ("syndi_cakes")
					var/obj/item/trash/syndi_cakes/T = new /obj/item/trash/syndi_cakes/( M )
					M.put_in_hand(T)
				if ("waffles")
					var/obj/item/trash/waffles/T = new /obj/item/trash/waffles/( M )
					M.put_in_hand(T)
				if ("plate")
					var/obj/item/trash/plate/T = new /obj/item/trash/plate/( M )
					M.put_in_hand(T)
				if ("snack_bowl")
					var/obj/item/trash/snack_bowl/T = new /obj/item/trash/snack_bowl/( M )
					M.put_in_hand(T)
				if ("pistachios")
					var/obj/item/trash/pistachios/T = new /obj/item/trash/pistachios/( M )
					M.put_in_hand(T)
				if ("semki")
					var/obj/item/trash/semki/T = new /obj/item/trash/semki/( M )
					M.put_in_hand(T)
				if ("tray")
					var/obj/item/trash/tray/T = new /obj/item/trash/tray/( M )
					M.put_in_hand(T)
		return

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		return
	attack_self(mob/user as mob)
		return
	attack(mob/M as mob, mob/user as mob, def_zone)
		if(!reagents.total_volume)						//Shouldn't be needed but it checks to see if it has anything left in it.
			user << "\red None of [src] left, oh no!"
			del(src)
			return 0
		if(istype(M, /mob/living/carbon))
			if(M == user)								//If you're eating it yourself.
				var/fullness = M.nutrition + (M.reagents.get_reagent_amount("nutriment") * 25)
				if (fullness <= 50)
					M << "\red You hungrily chew out a piece of [src] and gobble it!"
				if (fullness > 50 && fullness <= 150)
					M << "\blue You hungrily begin to eat [src]."
				if (fullness > 150 && fullness <= 350)
					M << "\blue You take a bite of [src]."
				if (fullness > 350 && fullness <= 550)
					M << "\blue You unwillingly chew a bit of [src]."
				if (fullness > (550 * (1 + M.overeatduration / 2000)))	// The more you eat - the more you can eat
					M << "\red You cannot force any more of [src] to go down your throat."
					return 0
			else
				if(!istype(M, /mob/living/carbon/metroid))		//If you're feeding it to someone else.
					var/fullness = M.nutrition + (M.reagents.get_reagent_amount("nutriment") * 25)
					if (fullness <= (550 * (1 + M.overeatduration / 1000)))
						for(var/mob/O in viewers(world.view, user))
							O.show_message("\red [user] attempts to feed [M] [src].", 1)
					else
						for(var/mob/O in viewers(world.view, user))
							O.show_message("\red [user] cannot force anymore of [src] down [M]'s throat.", 1)
							return 0

					if(!do_mob(user, M)) return

					M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been fed [src.name] by [user.name] ([user.ckey]) Reagents: \ref[reagents]</font>")
					user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [M.name] by [M.name] ([M.ckey]) Reagents: \ref[reagents]</font>")

					for(var/mob/O in viewers(world.view, user))
						O.show_message("\red [user] feeds [M] [src].", 1)

				else
					user << "This creature does not seem to have a mouth!"
					return

			if(reagents)								//Handle ingestion of the reagent.
				if(reagents.total_volume)
					reagents.reaction(M, INGEST)
					spawn(5)
						if(reagents.total_volume > bitesize)
							/*
							 * I totally cannot understand what this code supposed to do.
							 * Right now every snack consumes in 2 bites, my popcorn does not work right, so I simplify it. -- rastaf0
							var/temp_bitesize =  max(reagents.total_volume /2, bitesize)
							reagents.trans_to(M, temp_bitesize)
							*/
							reagents.trans_to(M, bitesize)
						else
							reagents.trans_to(M, reagents.total_volume)
						bitecount++
						On_Consume()
						if(!reagents.total_volume)
							if(M == user) user << "\red You finish eating [src]."
							else user << "\red [M] finishes eating [src]."
							del(src)
				playsound(M.loc,'eatfood.ogg', rand(10,50), 1)
				return 1

		return 0

	attackby(obj/item/I as obj, mob/user as mob)
		return
	afterattack(obj/target, mob/user , flag)
		return

	examine()
		set src in view()
		..()
		if (!(usr in range(0)) && usr!=src.loc) return
		if (bitecount==0)
			return
		else if (bitecount==1)
			usr << "\blue \The [src] was bitten by someone!"
		else if (bitecount<=3)
			usr << "\blue \The [src] was bitten [bitecount] times!"
		else
			usr << "\blue \The [src] was bitten multiple times!"

	attackby(obj/item/weapon/W as obj, mob/user as mob)

		if((slices_num <= 0 || !slices_num) || !slice_path)
			return 1
		var/inaccurate = 0
		if( \
				istype(W, /obj/item/weapon/kitchenknife) || \
				istype(W, /obj/item/weapon/butch) || \
				istype(W, /obj/item/weapon/scalpel) || \
				istype(W, /obj/item/weapon/kitchen/utensil/knife) \
			)
		else if( \
				istype(W, /obj/item/weapon/circular_saw) || \
				istype(W, /obj/item/weapon/melee/energy/sword) && W:active || \
				istype(W, /obj/item/weapon/melee/energy/blade) || \
				istype(W, /obj/item/weapon/shovel) \
			)
			inaccurate = 1
			return
		else
			return 1
		if ( \
				!isturf(src.loc) || \
				!(locate(/obj/table) in src.loc) && \
				!(locate(/obj/machinery/optable) in src.loc) && \
				!(locate(/obj/item/weapon/tray) in src.loc) \
			)
			user << "\red You cannot slice [src] here! You need a table or at least a tray to do it."
			return 1
		var/slices_lost = 0
		if (!inaccurate)
			user.visible_message( \
				"\blue [user] slices \the [src]!", \
				"\blue You slice \the [src]!" \
			)
		else
			user.visible_message( \
				"\blue [user] inaccurately slices \the [src] with [W]!", \
				"\blue You inaccurately slice \the [src] with your [W]!" \
			)
			slices_lost = rand(1,min(1,round(slices_num/2)))
		var/reagents_per_slice = reagents.total_volume/slices_num
		for(var/i=1 to (slices_num-slices_lost))
			var/obj/slice = new slice_path (src.loc)
			reagents.trans_to(slice,reagents_per_slice)
		del(src)
		return

	attack_animal(var/mob/M)
		if(isanimal(M))
			if(iscorgi(M))
				if(bitecount == 0 || prob(50))
					M.emote("nibbles away at the [src]")
				bitecount++
				if(bitecount >= 5)
					var/sattisfaction_text = pick("burps from enjoyment", "yaps for more", "woofs twice", "looks at the area where the [src] was")
					if(sattisfaction_text)
						M.emote("[sattisfaction_text]")
					del(src)

/*
/obj/item/weapon/reagent_containers/food/snacks/poppypretzel
	name = "Poppy pretzel"
	desc = "" //TODO
	icon_state = "poppypretzel"
	bitesize = 2
	New()
		..()
		reagents.add_reagent("nutriment", 5)
		bitesize = 2
*/
