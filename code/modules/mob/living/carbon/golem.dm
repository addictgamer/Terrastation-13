
////////Adamantine Golem stuff I dunno where else to put it

/obj/item/clothing/under/golem
	name = "adamantine skin"
	desc = "a golem's skin"
	icon_state = "golem"
	item_state = "golem"
	color = "golem"
	has_sensor = 0
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	canremove = 0

/obj/item/clothing/suit/golem
	name = "adamantine shell"
	desc = "a golem's thick outter shell"
	icon_state = "golem"
	item_state = "golem"
	w_class = 4//bulky item
	gas_transfer_coefficient = 0.90
	permeability_coefficient = 0.50
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS|HEAD
	slowdown = 1.0
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	flags = FPRINT | TABLEPASS | ONESIZEFITSALL | STOPSPRESSUREDMAGE
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS | HEAD
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS | HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECITON_TEMPERATURE
	canremove = 0
	armor = list(melee = 80, bullet = 20, laser = 20, energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/shoes/golem
	name = "golem's feet"
	desc = "sturdy adamantine feet"
	icon_state = "golem"
	item_state = null
	canremove = 0
	flags = NOSLIP
	slowdown = SHOES_SLOWDOWN+1


/obj/item/clothing/mask/gas/golem
	name = "golem's face"
	desc = "the imposing face of an adamantine golem"
	icon_state = "golem"
	item_state = "golem"
	canremove = 0
	siemens_coefficient = 0
	unacidable = 1

/obj/item/clothing/mask/gas/golem
	name = "golem's face"
	desc = "the imposing face of an adamantine golem"
	icon_state = "golem"
	item_state = "golem"
	canremove = 0
	siemens_coefficient = 0
	unacidable = 1


/obj/item/clothing/gloves/golem
	name = "golem's hands"
	desc = "strong adamantine hands"
	icon_state = "golem"
	item_state = null
	siemens_coefficient = 0
	canremove = 0


/obj/item/clothing/head/space/golem
	icon_state = "golem"
	item_state = "dermal"
	color = "dermal"
	name = "golem's head"
	desc = "a golem's head"
	canremove = 0
	unacidable = 1
	flags = FPRINT | TABLEPASS | STOPSPRESSUREDMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	armor = list(melee = 80, bullet = 20, laser = 20, energy = 10, bomb = 0, bio = 0, rad = 0)

/obj/effect/golemrune
	anchored = 1
	desc = "a strange rune used to create golems. It glows when spirits are nearby."
	name = "rune"
	icon = 'icons/obj/rune.dmi'
	icon_state = "golem"
	unacidable = 1
	layer = TURF_LAYER

	New()
		..()
		processing_objects.Add(src)

	process()
		var/mob/dead/observer/ghost
		for(var/mob/dead/observer/O in src.loc)
			if(!O.client)	continue
			if(O.mind && O.mind.current && O.mind.current.stat != DEAD)	continue
			ghost = O
			break
		if(ghost)
			icon_state = "golem2"
		else
			icon_state = "golem"

	attack_hand(mob/living/user as mob)
		var/mob/dead/observer/ghost
		for(var/mob/dead/observer/O in src.loc)
			if(!O.client)	continue
			if(O.mind && O.mind.current && O.mind.current.stat != DEAD)	continue
			ghost = O
			break
		if(!ghost)
			user << "The rune fizzles uselessly. There is no spirit nearby."
			return
		var/mob/living/carbon/human/G = new /mob/living/carbon/human
		G.dna.mutantrace = "adamantine"
		G.real_name = text("Adamantine Golem ([rand(1, 1000)])")
		G.equip_to_slot_or_del(new /obj/item/clothing/under/golem(G), slot_w_uniform)
		G.equip_to_slot_or_del(new /obj/item/clothing/suit/golem(G), slot_wear_suit)
		G.equip_to_slot_or_del(new /obj/item/clothing/shoes/golem(G), slot_shoes)
		G.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/golem(G), slot_wear_mask)
		G.equip_to_slot_or_del(new /obj/item/clothing/gloves/golem(G), slot_gloves)
		//G.equip_to_slot_or_del(new /obj/item/clothing/head/space/golem(G), slot_head)
		G.loc = src.loc
		G.key = ghost.key
		G << "You are an adamantine golem. You move slowly, but are highly resistant to heat and cold as well as blunt trauma. You are unable to wear clothes, but can still use most tools. Serve [user], and assist them in completing their goals at any cost."
		del (src)


	proc/announce_to_ghosts()
		for(var/mob/dead/observer/G in player_list)
			if(G.client)
				var/area/A = get_area(src)
				if(A)
					G << "Golem rune created in [A.name]."
