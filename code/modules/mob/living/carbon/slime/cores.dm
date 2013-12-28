
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

/obj/item/slime_extract/grey
	name = "grey slime extract"
	icon_state = "grey slime extract"
	color = "grey"

/obj/item/slime_extract/gold
	name = "gold slime extract"
	icon_state = "gold slime extract"
	color = "gold"

/obj/item/slime_extract/silver
	name = "silver slime extract"
	icon_state = "silver slime extract"
	color = "silver"

/obj/item/slime_extract/metal
	name = "metal slime extract"
	icon_state = "metal slime extract"
	color = "metal"

/obj/item/slime_extract/purple
	name = "purple slime extract"
	icon_state = "purple slime extract"
	color = "purple"

/obj/item/slime_extract/darkpurple
	name = "dark purple slime extract"
	icon_state = "dark purple slime extract"
	color = "darkpurple"

/obj/item/slime_extract/orange
	name = "orange slime extract"
	icon_state = "orange slime extract"
	color = "orange"

/obj/item/slime_extract/yellow
	name = "yellow slime extract"
	icon_state = "yellow slime extract"
	color = "yellow"

/obj/item/slime_extract/red
	name = "red slime extract"
	icon_state = "red slime extract"
	color = "red"

/obj/item/slime_extract/lightblue
	name = "light blue slime extract"
	icon_state = "light blue slime extract"
	color = "light blue"

/obj/item/slime_extract/blue
	name = "blue slime extract"
	icon_state = "blue slime extract"
	color = "blue"

/obj/item/slime_extract/green
	name = "green slime extract"
	icon_state = "green slime extract"
	color = "green"

/obj/item/slime_extract/lightpink
	name = "light pink slime extract"
	icon_state = "light pink slime extract"
	color = "light pink"

/obj/item/slime_extract/pink
	name = "pink slime extract"
	icon_state = "pink slime extract"
	color = "pink"

/obj/item/slime_extract/black
	name = "black slime extract"
	icon_state = "black slime extract"
	color = "black"

/obj/item/slime_extract/oil
	name = "oil slime extract"
	icon_state = "oil slime extract"
	color = "oil"

/obj/item/slime_extract/adamantine
	name = "adamantine slime extract"
	icon_state = "adamantine slime extract"
	color = "adamantine"

/obj/item/slime_extract/bluespace
	name = "bluespace slime extract"
	icon_state = "bluespace slime extract"
	color = "bluespace"

/obj/item/slime_extract/pyrite
	name = "pyrite slime extract"
	icon_state = "pyrite slime extract"
	color = "pyrite"

/obj/item/slime_extract/cerulean
	name = "cerulean slime extract"
	icon_state = "cerulean slime extract"
	color = "cerulean"

/obj/item/slime_extract/sepia
	name = "sepia slime extract"
	icon_state = "sepia slime extract"
	color = "sepia"


// TODO: Need uses in Chemistry-Recipes.dm

/obj/item/slime_extract/darkblue
	name = "dark blue slime extract"
	icon_state = "dark blue slime extract"
	color = "dark blue"

/obj/item/slime_extract/cueball
	name = "cueball slime extract"
	icon_state = "cueball slime extract"
	color = "cueball"

/obj/item/slime_extract/rainbow
	name = "rainbow slime extract"
	icon_state = "rainbow slime extract"
	color = "rainbow"

/obj/item/slime_extract/platinum
	name = "platinum slime extract"
	icon_state = "platinum slime extract"
	color = "platinum"

/obj/item/slime_extract/death
	name = "death slime extract"
	icon_state = "death slime extract"
	color = "death"

/obj/item/slime_extract/lightgreen
	name = "light green slime extract"
	icon_state = "light green slime extract"
	color = "light green"

/obj/item/slime_extract/darkgreen
	name = "dark green slime extract"
	icon_state = "dark green slime extract"
	color = "dark green"

/obj/item/slime_extract/glass
	name = "glass slime extract"
	icon_state = "glass slime extract"
	color = "glass"

/obj/item/slime_extract/master
	name = "master slime extract"
	icon_state = "master slime extract"
	color = "master"



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
		var/mob/living/simple_animal/slime/pet = new /mob/living/simple_animal/slime(M.loc)
		pet.icon_state = "[M.colour] baby slime"
		pet.icon_living = "[M.colour] baby slime"
		pet.icon_dead = "[M.colour] baby slime dead"
		pet.colour = "[M.colour]"
		user <<"You feed the slime the potion, removing it's powers and calming it."
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
		var/mob/living/simple_animal/adultslime/pet = new /mob/living/simple_animal/adultslime(M.loc)
		pet.icon_state = "[M.colour] adult slime"
		pet.icon_living = "[M.colour] adult slime"
		pet.icon_dead = "[M.colour] baby slime dead"
		pet.colour = "[M.colour]"
		user <<"You feed the slime the potion, removing it's powers and calming it."
		del (M)
		var/newname = copytext(sanitize(input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime") as null|text),1,MAX_NAME_LEN)

		if (!newname)
			newname = "pet slime"
		pet.name = newname
		pet.real_name = newname
		del (src)


/obj/item/weapon/slimesteroid
	name = "slime steroid"
	desc = "A potent chemical mix that will cause a slime to generate more extract."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle16"

	attack(mob/living/carbon/slime/M as mob, mob/user as mob)
		if(!istype(M, /mob/living/carbon/slime))//If target is not a slime.
			user << "\red The steroid only works on baby slimes!"
			return ..()
		if(istype(M, /mob/living/carbon/slime/adult)) //Can't tame adults
			user << "\red Only baby slimes can use the steroid!"
			return..()
		if(M.stat)
			user << "\red The slime is dead!"
			return..()
		if(M.cores == 3)
			user <<"\red The slime already has the maximum amount of extract!"
			return..()
		user <<"You feed the slime the steroid. It now has triple the amount of extract."
		M.cores = 3
		del (src)

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
			del (src)
*/
