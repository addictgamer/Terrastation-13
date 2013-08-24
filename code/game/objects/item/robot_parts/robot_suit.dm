
/obj/item/robot_parts/robot_suit
	name = "Cyborg Endoskeleton"
	desc = "A complex metal backbone with standard limb sockets and pseudomuscle anchors."
	icon_state = "robo_suit"
	construction_time = 500
	construction_cost = list("metal"=50000)
	var
		obj/item/robot_parts/l_arm/l_arm = null
		obj/item/robot_parts/r_arm/r_arm = null
		obj/item/robot_parts/l_leg/l_leg = null
		obj/item/robot_parts/r_leg/r_leg = null
		obj/item/robot_parts/chest/chest = null
		obj/item/robot_parts/head/head = null
		created_name = "Cyborg"

	New()
		..()
		src.updateicon()

	attackby(obj/item/W as obj, mob/user as mob)
		..()
		if (istype(W, /obj/item/stack/sheet/metal))
			var/obj/item/weapon/ed209_assembly/B = new /obj/item/weapon/ed209_assembly
			B.loc = get_turf(src)
			user << "You armed the robot frame"
			W:use(1)
			if (user.get_inactive_hand()==src)
				user.before_take_item(src)
				user.put_in_inactive_hand(B)
			del(src)
		if (istype(W, /obj/item/robot_parts/l_leg))
			user.drop_item()
			W.loc = src
			src.l_leg = W
			src.updateicon()

		if (istype(W, /obj/item/robot_parts/r_leg))
			user.drop_item()
			W.loc = src
			src.r_leg = W
			src.updateicon()

		if (istype(W, /obj/item/robot_parts/l_arm))
			user.drop_item()
			W.loc = src
			src.l_arm = W
			src.updateicon()

		if (istype(W, /obj/item/robot_parts/r_arm))
			user.drop_item()
			W.loc = src
			src.r_arm = W
			src.updateicon()

		if (istype(W, /obj/item/robot_parts/chest))

			if (W:wires && W:cell)
				user.drop_item()
				W.loc = src
				src.chest = W
				src.updateicon()
			else if (!W:wires)
				user << "\blue You need to attach wires to it first!"
			else
				user << "\blue You need to attach a cell to it first!"

		if (istype(W, /obj/item/robot_parts/head))
			if (W:flash2 && W:flash1)
				user.drop_item()
				W.loc = src
				src.head = W
				src.updateicon()
			else
				user << "\blue You need to attach a flash to it first!"

		if (istype(W, /obj/item/device/mmi))
			var/obj/item/device/mmi/M = W
			if (check_completion())
				if (!istype(loc,/turf))
					user << "\red You can't put the MMI in, the frame has to be standing on the ground to be perfectly precise."
					return
				if (!M.brainmob)
					user << "\red Sticking an empty MMI into the frame would sort of defeat the purpose."
					return
				if (M.brainmob.stat == 2)
					user << "\red Sticking a dead brain into the frame would sort of defeat the purpose."
					return

				if (jobban_isbanned(M.brainmob, "Cyborg"))
					user << "\red This MMI does not seem to fit."
					return

				var/mob/living/silicon/robot/O = new /mob/living/silicon/robot(get_turf(loc))
				if (!O)	return

				user.drop_item()

				O.invisibility = 0
				O.name = created_name
				O.real_name = created_name

				if (M.brainmob && M.brainmob.mind)
					M.brainmob.mind.transfer_to(O)
				else
					for(var/mob/dead/observer/G in world)
						if (G.corpse == M.brainmob && G.client && G.corpse.mind)
							G.corpse.mind.transfer_to(O)
							del(G)
							break
				if (O.mind && O.mind.special_role)
					O.mind.store_memory("In case you look at this after being borged, the objectives are only here until I find a way to make them not show up for you, as I can't simply delete them without screwing up round-end reporting. --NeoFite")

				O << "<B>You are playing a Robot. The Robot can interact with most electronic objects in its view point.</B>"
				O << "<B>You must follow the laws that the AI has. You are the AI's assistant to the station basically.</B>"
				O << "To use something, simply double-click it."
				O << {"Use say ":s to speak to fellow cyborgs and the AI through binary."}

				O.job = "Cyborg"

				O.cell = chest.cell
				O.cell.loc = O
				W.loc = O//Should fix cybros run time erroring when blown up. It got deleted before, along with the frame.
				O.mmi = W

				del(src)
			else
				user << "\blue The MMI must go in after everything else!"

		if (istype(W, /obj/item/weapon/pen))
			var/t = input(user, "Enter new robot name", src.name, src.created_name) as text
			t = copytext(sanitize(t), 1, MAX_MESSAGE_LEN)
			if (!t)
				return
			if (!in_range(src, usr) && src.loc != usr)
				return

			src.created_name = t
		return

	proc
		updateicon()
			src.overlays = null
			if (src.l_arm)
				src.overlays += "l_arm+o"
			if (src.r_arm)
				src.overlays += "r_arm+o"
			if (src.chest)
				src.overlays += "chest+o"
			if (src.l_leg)
				src.overlays += "l_leg+o"
			if (src.r_leg)
				src.overlays += "r_leg+o"
			if (src.head)
				src.overlays += "head+o"

		check_completion()
			if (src.l_arm && src.r_arm)
				if (src.l_leg && src.r_leg)
					if (src.chest && src.head)
						return 1
			return 0
