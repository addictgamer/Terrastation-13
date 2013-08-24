
/turf/simulated/wall/mineral
	icon = 'mineral_walls.dmi'
	walltype = "iron"

	var/oreAmount = 1
	var/hardness = 1

	New()
		..()
		name = "[walltype] wall"

	dismantle_wall(devastated = 0)
		if (!devastated)
			var/ore = text2path("/obj/item/weapon/ore/[walltype]")
			for(var/i = 1, i <= oreAmount, i++)
				new ore(src)
			ReplaceWithFloor()
		else
			ReplaceWithSpace()

	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W,/obj/item/weapon/pickaxe))
			var/obj/item/weapon/pickaxe/digTool = W
			user << "You start digging the [name]."
			if (do_after(user,digTool.digspeed*hardness) && src)
				user << "You finished digging."
				dismantle_wall()
		else if (istype(W,/obj/item/weapon)) //not sure, can't not just weapons get passed to this proc?
			hardness -= W.force/100
			user << "You hit the [name] with your [W.name]!"
			CheckHardness()
		else
			attack_hand(user)
		return

	proc/CheckHardness()
		if (hardness <= 0)
			dismantle_wall()
