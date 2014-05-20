
/obj/item/slime_extract
	name = "slime extract"
	desc = "Goo extracted from a slime. Legends claim these to have \"magical powers\"."
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey slime extract"
	flags = TABLEPASS | FPRINT
	force = 1.0
	w_class = 1.0
	throwforce = 1.0
	throw_speed = 3
	throw_range = 6
	origin_tech = "biotech=4"
	color = ""
	var/Uses = 1	// uses before it goes inert
	var/enhanced = 0	// has it been enhanced before?

	New()
		..()
		create_reagents(100)

	attackby(obj/item/O as obj, mob/user as mob)
		if(istype(O, /obj/item/weapon/slimesteroid2))
			if(enhanced == 1)
				user << "\red This extract has already been enhanced!"
				return ..()
			if(Uses == 0)
				user << "\red You can't enhance a used extract!"
				return ..()
			user <<"You apply the enhancer. It now has triple the amount of uses."
			Uses = 3
			enhanced = 1
			del (O)
<<<<<<< HEAD
=======
		if(istype(O, /obj/item/weapon/slimepotion3))
		// inb4 giant slimes
/*			if(enhanced == 1 && Uses == 3)
				for(var/mob/O in viewers(get_turf_loc(src), null))
					O.show_message(text("\red The core begins to quiver and grow, and soon a huge slime emerges from it!"), 1)

				var/mob/living/simple_animal/hugeslime/pet = new /mob/living/simple_animal/hugeslime(src.loc)
				pet.icon_state = "huge [color] slime"
				pet.icon_living = "huge [color] slime"
				pet.icon_dead = "huge [color] slime dead"
				pet.colour = "[color]"
				step_away(pet,user)

			var/newname = copytext(sanitize(input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime") as null|text),1,MAX_NAME_LEN)
			if (!newname)
				newname = "pet slime"
			pet.name = newname
			pet.real_name = newname
*/
		// unused core, makes adult
			if(enhanced == 0 && Uses == 1)
				for(var/mob/M in viewers(get_turf_loc(src), null))
					M.show_message(text("\red The core begins to quiver and grow, and soon a new baby slime emerges from it!"), 1)

				var/mob/living/simple_animal/adultslime/pet = new /mob/living/simple_animal/adultslime(src.loc)
				pet.icon_state = "[color] adult slime"
				pet.icon_living = "[color] adult slime"
				pet.icon_dead = "[color] adult slime dead"
				pet.colour = "[color]"
				step_away(pet,user)

				var/newname = copytext(sanitize(input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime") as null|text),1,MAX_NAME_LEN)
				if (!newname)
					newname = "pet slime"
				pet.name = newname
				pet.real_name = newname
		// Used up core, makes baby
			else if(Uses == 0)
				for(var/mob/M in viewers(get_turf_loc(src), null))
					M.show_message(text("\red The core begins to quiver and grow, and soon a new baby slime emerges from it!"), 1)

				var/mob/living/simple_animal/slime/pet = new /mob/living/simple_animal/slime(src.loc)
				pet.icon_state = "[color] baby slime"
				pet.icon_living = "[color] baby slime"
				pet.icon_dead = "[color] baby slime dead"
				pet.colour = "[color]"
				step_away(pet,user)

				var/newname = copytext(sanitize(input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime") as null|text),1,MAX_NAME_LEN)
				if (!newname)
					newname = "pet slime"
				pet.name = newname
				pet.real_name = newname
			else
				for(var/mob/M in viewers(get_turf_loc(src), null))
					M.show_message(text("\red The slime core jiggles a little as it farts, and then looks completely useless..."), 1)
				Uses = 0
				enhanced = 0
				name = "used [color] slime extract"
			del (O)
>>>>>>> origin/master

// Tier 1

/obj/item/slime_extract/grey
	name = "grey slime extract"
	icon_state = "grey slime extract"
	color = "grey"

// Tier 2

/obj/item/slime_extract/orange
	name = "orange slime extract"
	icon_state = "orange slime extract"
	color = "orange"

/obj/item/slime_extract/metal
	name = "metal slime extract"
	icon_state = "metal slime extract"
	color = "metal"

/obj/item/slime_extract/lightblue
	name = "light blue slime extract"
	icon_state = "light blue slime extract"
	color = "light blue"

/obj/item/slime_extract/lightgreen
	name = "light green slime extract"
	icon_state = "light green slime extract"
	color = "light green"

// Tier 3

/obj/item/slime_extract/blue
	name = "blue slime extract"
	icon_state = "blue slime extract"
	color = "blue"

/obj/item/slime_extract/green
	name = "green slime extract"
	icon_state = "green slime extract"
	color = "green"

/obj/item/slime_extract/silver
	name = "silver slime extract"
	icon_state = "silver slime extract"
	color = "silver"

/obj/item/slime_extract/red
	name = "red slime extract"
	icon_state = "red slime extract"
	color = "red"

/obj/item/slime_extract/yellow
	name = "yellow slime extract"
	icon_state = "yellow slime extract"
	color = "yellow"

/obj/item/slime_extract/oil
	name = "oil slime extract"
	icon_state = "oil slime extract"
	color = "oil"

/obj/item/slime_extract/glass
	name = "glass slime extract"
	icon_state = "glass slime extract"
	color = "glass"

// Tier 4

/obj/item/slime_extract/darkblue
	name = "dark blue slime extract"
	icon_state = "dark blue slime extract"
	color = "dark blue"

/obj/item/slime_extract/darkgreen
	name = "dark green slime extract"
	icon_state = "dark green slime extract"
	color = "dark green"

/obj/item/slime_extract/gold
	name = "gold slime extract"
	icon_state = "gold slime extract"
	color = "gold"

/obj/item/slime_extract/purple
	name = "purple slime extract"
	icon_state = "purple slime extract"
	color = "purple"

/obj/item/slime_extract/pink
	name = "pink slime extract"
	icon_state = "pink slime extract"
	color = "pink"

/obj/item/slime_extract/plasglass
	name = "plasglass slime extract"
	icon_state = "plasglass slime extract"
	color = "plasglass"

// Tier 5

/obj/item/slime_extract/darkpurple
	name = "dark purple slime extract"
	icon_state = "dark purple slime extract"
	color = "darkpurple"

/obj/item/slime_extract/lightpink
	name = "light pink slime extract"
	icon_state = "light pink slime extract"
	color = "light pink"

<<<<<<< HEAD
/obj/item/slime_extract/black
	name = "black slime extract"
	icon_state = "black slime extract"
	color = "black"

=======
>>>>>>> origin/master
/obj/item/slime_extract/cerulean
	name = "cerulean slime extract"
	icon_state = "cerulean slime extract"
	color = "cerulean"

/obj/item/slime_extract/adamantine
	name = "adamantine slime extract"
	icon_state = "adamantine slime extract"
	color = "adamantine"

// Tier 6

<<<<<<< HEAD
/obj/item/slime_extract/death
	name = "death slime extract"
	icon_state = "death slime extract"
	color = "death"
=======
/obj/item/slime_extract/black
	name = "black slime extract"
	icon_state = "black slime extract"
	color = "black"
>>>>>>> origin/master

/obj/item/slime_extract/white
	name = "white slime extract"
	icon_state = "white slime extract"
	color = "white"

<<<<<<< HEAD
=======
// Tier 7

/obj/item/slime_extract/death
	name = "death slime extract"
	icon_state = "death slime extract"
	color = "death"

/obj/item/slime_extract/life
	name = "life slime extract"
	icon_state = "life slime extract"
	color = "life"

>>>>>>> origin/master
// Side tiers

// 1
/obj/item/slime_extract/cueball
	name = "cueball slime extract"
	icon_state = "cueball slime extract"
	color = "cueball"

<<<<<<< HEAD
=======
/obj/item/slime_extract/plasma
	name = "plasma slime extract"
	icon_state = "plasma slime extract"
	color = "plasma"

>>>>>>> origin/master
// 2
/obj/item/slime_extract/bluespace
	name = "bluespace slime extract"
	icon_state = "bluespace slime extract"
	color = "bluespace"

/obj/item/slime_extract/pyrite
	name = "pyrite slime extract"
	icon_state = "pyrite slime extract"
	color = "pyrite"

/obj/item/slime_extract/sepia
	name = "sepia slime extract"
	icon_state = "sepia slime extract"
	color = "sepia"

// 3
/obj/item/slime_extract/platinum
	name = "platinum slime extract"
	icon_state = "platinum slime extract"
	color = "platinum"

// No tiers

/obj/item/slime_extract/rainbow
	name = "rainbow slime extract"
	icon_state = "rainbow slime extract"
	color = "rainbow"

/obj/item/slime_extract/master
	name = "master slime extract"
	icon_state = "master slime extract"
	color = "master"
	attackby(obj/item/O as obj, mob/user as mob)
		if(istype(O, /obj/item/weapon/slimesteroid2))
			user << "\red The extract regects the steriod!"
			del (O)


// Pet Slime Creation

/obj/item/weapon/slimepotion
	name = "docility potion"
	desc = "A potent chemical mix that will nullify a slime's powers, causing it to become docile and tame."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle19"

	attack(mob/living/carbon/slime/M as mob, mob/user as mob)
		if(!istype(M, /mob/living/carbon/slime))	// If target is not a slime.
			user << "\red The potion only works on baby slimes!"
			return ..()
		if(istype(M, /mob/living/carbon/slime/adult))	// Can't tame adults
			user << "\red Only baby slimes can be tamed!"
			return..()
		if(M.stat)
			user << "\red The slime is dead!"
			return..()
		if(M.mind)
			user << "\red The slime resists!"
			return ..()
<<<<<<< HEAD
=======
		user <<"You feed the slime the potion, removing it's powers and calming it."
>>>>>>> origin/master
		var/mob/living/simple_animal/slime/pet = new /mob/living/simple_animal/slime(M.loc)
		pet.icon_state = "[M.colour] baby slime"
		pet.icon_living = "[M.colour] baby slime"
		pet.icon_dead = "[M.colour] baby slime dead"
		pet.colour = "[M.colour]"
<<<<<<< HEAD
		user <<"You feed the slime the potion, removing it's powers and calming it."
=======
>>>>>>> origin/master
		del (M)
		var/newname = copytext(sanitize(input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime") as null|text),1,MAX_NAME_LEN)

		if (!newname)
			newname = "pet slime"
		pet.name = newname
		pet.real_name = newname
		del (src)

/obj/item/weapon/slimepotion2
	name = "advanced docility potion"
	desc = "A potent chemical mix that will nullify a slime's powers, causing it to become docile and tame. This one is meant for adult slimes."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle19"

	attack(mob/living/carbon/slime/adult/M as mob, mob/user as mob)
		if(!istype(M, /mob/living/carbon/slime/adult))	// If target is not a slime.
			user << "\red The potion only works on adult slimes!"
			return ..()
		if(M.stat)
			user << "\red The slime is dead!"
			return..()
		if(M.mind)
			user << "\red The slime resists!"
			return ..()
<<<<<<< HEAD
=======
		user <<"You feed the slime the potion, removing it's powers and calming it."
>>>>>>> origin/master
		var/mob/living/simple_animal/adultslime/pet = new /mob/living/simple_animal/adultslime(M.loc)
		pet.icon_state = "[M.colour] adult slime"
		pet.icon_living = "[M.colour] adult slime"
		pet.icon_dead = "[M.colour] baby slime dead"
		pet.colour = "[M.colour]"
<<<<<<< HEAD
		user <<"You feed the slime the potion, removing it's powers and calming it."
=======
>>>>>>> origin/master
		del(M)
		var/newname = copytext(sanitize(input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime") as null|text),1,MAX_NAME_LEN)

		if (!newname)
			newname = "pet slime"
		pet.name = newname
		pet.real_name = newname
		del(src)

<<<<<<< HEAD
=======
/obj/item/weapon/slimepotion3
	name = "slime regenerative potion"
	desc = "A very potent chemical mix that will grow a slime from a core and nullify its powers, causing it to become docile and tame."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle19"

>>>>>>> origin/master
// Slime steriods

/obj/item/weapon/slimesteroid
	name = "slime steroid"
<<<<<<< HEAD
	desc = "A potent chemical mix that will cause a slime to generate more extract."
=======
	desc = "A potent chemical mix that will cause a slime to generate more extract. Has a chance to turn it rabid."
>>>>>>> origin/master
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle16"

	attack(mob/living/carbon/slime/M as mob, mob/user as mob)
		if(!istype(M, /mob/living/carbon/slime))	// If target is not a slime.
			user << "\red The steroid only works on slimes!"
			return ..()
		if(istype(M, /mob/living/carbon/slime/adult))	// Can't tame adults
			user << "\red Only baby slimes can use the steroid!"
			return..()
		if(istype(M, /mob/living/carbon/slime/master))	// Doesn't work on master slimes
			user << "\red The slime rejects it!"
			return..()
		if(M.stat)
			user << "\red The slime is dead!"
			return..()
		if(M.cores == 3)
			user <<"\red The slime already has the maximum amount of extract!"
			return..()
		user <<"You feed the slime the steroid. It now has triple the amount of extract."
		M.cores = 3
<<<<<<< HEAD
=======
		M.rabid = rand(0,1)
		if (M.rabid)
			for(var/mob/O in viewers(get_turf_loc(src), null))
				O.show_message(text("\red The [M] is driven into a frenzy!"), 1)
>>>>>>> origin/master
		del(src)

/obj/item/weapon/slimesteroid2
	name = "extract enhancer"
	desc = "A potent chemical mix that will give a slime extract three uses."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle17"

/*	// used in /obj/item/slime_extract/attackby()
	afterattack(obj/item/target, mob/user , flag)
		if(istype(target, /obj/item/slime_extract))
			if(target.enhanced == 1)
				user << "\red This extract has already been enhanced!"
				return ..()
			if(target.Uses == 0)
				user << "\red You can't enhance a used extract!"
				return ..()
			user <<"You apply the enhancer. It now has triple the amount of uses."
			target.Uses = 3
			target.enahnced = 1
			del(src)
*/

<<<<<<< HEAD
/obj/item/weapon/slimeinsta
	name = "slime growth enhancer"
	desc = "A potent chemical mix that will instantly cause a slime to grow to adulthood."
=======
/obj/item/weapon/slimesteroid3	// slimeinsta
	name = "slime growth enhancer"
	desc = "A potent chemical mix that will instantly cause a slime to grow to adulthood, but make it rabid."
>>>>>>> origin/master
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle16"

	attack(mob/living/carbon/slime/M as mob, mob/user as mob)
		if(!istype(M, /mob/living/carbon/slime))	// If target is not a slime.
			user << "\red The steroid only works on slimes!"
			return ..()
		if(istype(M, /mob/living/carbon/slime/adult))	// Can't tame adults
			user << "\red Only baby slimes can use the steroid!"
			return..()
		if(istype(M, /mob/living/carbon/slime/master))	// Doesn't work on master slimes
			user << "\red The slime rejects it!"
			return..()
		if(M.stat)
			user << "\red The slime is dead!"
			return..()
		user <<"You feed the slime the steroid. It instantly grows into an adult slime."
		var/mob/living/carbon/slime/adult/A = new M.adulttype(loc)
		A.powerlevel = max(0, M.powerlevel-1)
		A.amount_grown = 10
		A.Friends = M.Friends
<<<<<<< HEAD
		A.tame = M.tame
		A.rabid = M.rabid
=======
		A.tame = 0
		A.rabid = 1
		for(var/mob/O in viewers(get_turf_loc(src), null))
			O.show_message(text("\red The [A] is driven into a frenzy!"), 1)
>>>>>>> origin/master
		A.Discipline = M.Discipline
		del(M)
		del(src)
