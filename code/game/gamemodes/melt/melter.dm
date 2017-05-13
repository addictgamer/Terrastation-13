//Melterling mobs. This is going to be a new iteration of them entirely; don't expect the same behaviour.
//What is this, a.... third(?) generation of this mob? 		--LZ

/mob/living/simple_animal/hostile/melterling
	name = "melterling"
	desc = "What the god-loving fuck is this?!"
	icon = 'code/game/gamemodes/melt/melter.dmi'
	icon_state = "melterling"
	icon_living = "melterling"
	icon_dead = "melterling"
	health = 2
	maxHealth = 5
	melee_damage_lower = 2
	melee_damage_upper = 3
	attacktext = "flails against"
	attack_sound = 'sound/weapons/thudswoosh.ogg'
	projectilesound = 'sound/effects/meltscream.ogg'
	projectiletype = /obj/item/projectile/melterblast
	faction = list("melter")
	check_friendly_fire = 1
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	speak_emote = list("whines")
	gold_core_spawnable = CHEM_MOB_SPAWN_HOSTILE
	loot = list(/obj/effect/gibspawner/human, /obj/effect/decal/cleanable/molten_object)
	deathmessage = "melts!"
	del_on_death = 1


/obj/item/projectile/melterblast
	name = "wtf"
	desc = "WTF?!"
	icon_state = "ion"
	damage = 5
	damage_type = BURN
	flag = "energy"


/mob/living/simple_animal/hostile/melterling/range
	desc = "Oh god, it has laz0r breath?!"
	ranged = 1
	retreat_distance = 6
	minimum_distance = 8

/mob/living/simple_animal/hostile/melterling/crazy
	desc = "Get armor."
	icon_state = "cMelterling"
	icon_living = "cMelterling"
	icon_dead = "cMelterling"
	icon_resting = "cMelterling"
	ranged = 1
	rapid = 1
	retreat_distance = 2
	minimum_distance = 4
	health = 35
	maxHealth = 35
	check_friendly_fire = 0




//This is an exact copy of the other one, but is a 'neutral' mob. This is more or less the old behavior of this mob.
//No range variants here tho. 		--LZ
/mob/living/simple_animal/hostile/retaliate/melterling
	name = "melterling"
	desc = "What the god-loving fuck is this?!"
	icon = 'code/game/gamemodes/melt/melter.dmi'
	icon_state = "melterling"
	icon_living = "melterling"
	icon_dead = "melterling"
	health = 10
	maxHealth = 10
	melee_damage_lower = 4
	melee_damage_upper = 9
	attacktext = "flails against"
	attack_sound = 'sound/weapons/thudswoosh.ogg'
	projectilesound = 'sound/effects/meltscream.ogg'
	projectiletype = /obj/item/projectile/melterblast
	faction = list("melter")
	check_friendly_fire = 1
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	speak_emote = list("whines")
	gold_core_spawnable = CHEM_MOB_SPAWN_HOSTILE
	loot = list(/obj/effect/gibspawner/human, /obj/effect/decal/cleanable/dirt/blackpowder)
	deathmessage = "melts!"
	del_on_death = 1



//WIP for an intermediary mob

/mob/living/simple_animal/hostile/meltar
	name = "Avatar of Meltion"
	desc = "A crude manifestation of eons of Meltion's infernal agony. Suffice it to say, it is not a nice thing."
	icon = 'code/game/gamemodes/melt/melter.dmi'
	icon_state = "avatar"
	icon_living = "avatar"
	health = 100
	maxHealth = 100
	melee_damage_lower = 2
	melee_damage_upper = 50
	speed = 3
	ranged = 1
	attacktext = "banlances"
	attack_sound = 'sound/weapons/Kenetic_accel.ogg'
	projectilesound = 'sound/weapons/marauder.ogg'
	projectiletype = /obj/item/projectile/heavymelt
	faction = list("melter")
	check_friendly_fire = 1
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	speak_emote = list("murmurs")
	gold_core_spawnable = CHEM_MOB_SPAWN_HOSTILE
	loot = list(/obj/effect/gibspawner/human, /obj/effect/decal/cleanable/dirt/blackpowder)
	deathmessage = "melts!"
	del_on_death = 1


//bullet for above
/obj/item/projectile/heavymelt
	name = "wtf"
	desc = "WTF?!"
	icon_state = "pulse1_bl"
	damage = 25
	damage_type = BURN
	flag = "energy"


/mob/living/simple_animal/hostile/meltar/proc/ban(mob/living/target as mob)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, 200, 4)

/mob/living/simple_animal/hostile/meltar/AttackingTarget()
	..()
	if(isliving(target))
		ban(target)

//motherfucker will torso flail your bitch ass
