/obj/structure/flora
	burn_state = FLAMMABLE
	burntime = 30

//trees
/obj/structure/flora/tree
	name = "tree"
	anchored = 1
	density = 1
	pixel_x = -16
	layer = 9
	var/icon_count = 1
	var/icon_prefix
	var/fruit = null
	var/fruit_yield = 0
	var/wood = /obj/item/weapon/grown/log
	var/wood_yield = 2
	var/chops = 0 //How many times it's been chopped. Gotta make them work for it!
	var/chops_needed = 6 //Number of chops needed to fell it.
	var/fell_tool = /obj/item/weapon/hatchet //Item needed to fell it.
	var/fruitless //Icon_state to use when tree runs out of fruit.

/obj/structure/flora/tree/New()
	..()
	icon_state = "[icon_prefix][rand(1, icon_count)]"


/obj/structure/flora/tree/attackby(var/obj/item/I, mob/user as mob)
	if(istype(I, fell_tool))
		user.show_message("<span class='notice'>You chop [src] with [I].</span>")

		playsound(src.loc, 'sound/effects/chopchop.ogg', 100, 1)

		sleep(5)


		chops += 1

		if(chops == chops_needed)
			user.show_message("<span class='notice'>[src] comes crashing down!</span>")
			playsound(src.loc, 'sound/effects/treefalling.ogg', 100, 1)
			var/displacement = 0
			while(wood_yield)
				var/obj/item/L = new wood(loc)
				L.Move(get_step(src, NORTH), NORTH)
				L.y += displacement
				displacement += 0.1
				wood_yield -= 1
			if(fruit)
				displacement = 0
				while(fruit_yield)
					var/obj/item/F = new fruit(loc)
					F.Move(get_step(src, NORTH), NORTH)
					F.y += displacement
					displacement += 0.1
					fruit_yield -= 1

			qdel(src)

	return

/obj/structure/flora/tree/attack_hand(mob/user)
	if(fruit)
		var/obj/item/F = new fruit
		if(fruit_yield)
			fruit_yield -= 1
			user.show_message("<span class='notice'>You pick the [F] from [src]</span>")
			user.put_in_hands(F)
			if(!fruit_yield && fruitless)
				icon_state = fruitless
		else
			user.show_message("<span class='notice'>[src] has nothing left to pick!</span>")
	return

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_prefix = "pine_"
	icon_state = "pine_1"
	icon_count = 3


/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_prefix = "tree_"
	icon_state = "tree_1"
	icon_count = 6


/obj/structure/flora/tree/palm
	icon = 'icons/misc/beach2.dmi'
	icon_prefix = "palm"
	icon_state = "palm1"
	icon_count = 2

/obj/structure/flora/tree/palm/New()
	..()
	pixel_x = 0

/obj/structure/flora/tree/apple
	name = "apple tree"
	icon = 'icons/obj/flora/appletree.dmi'
	icon_state = "apple"
	fruit = /obj/item/weapon/reagent_containers/food/snacks/grown/apple
	fruit_yield = 10

/obj/structure/flora/tree/apple/New()
	..()
	icon_state = "apple"

//grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'
	anchored = 1

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]bb"


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	..()
	icon_state = "snowgrass[rand(1, 3)]gb"

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	..()
	icon_state = "snowgrassall[rand(1, 3)]"


//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = 1

/obj/structure/flora/bush/New()
	..()
	icon_state = "snowbush[rand(1, 6)]"

//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"
	anchored = 1

/obj/structure/flora/ausbushes/New()
	..()
	icon_state = "firstbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	..()
	icon_state = "reedbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	..()
	icon_state = "leafybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	..()
	icon_state = "palebush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	..()
	icon_state = "stalkybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	..()
	icon_state = "grassybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	..()
	icon_state = "fernybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	..()
	icon_state = "sunnybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	..()
	icon_state = "genericbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	..()
	icon_state = "pointybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	..()
	icon_state = "lavendergrass_[rand(1, 4)]"

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	..()
	icon_state = "ywflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	..()
	icon_state = "brflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	..()
	icon_state = "ppflowers_[rand(1, 4)]"

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	..()
	icon_state = "sparsegrass_[rand(1, 3)]"

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	..()
	icon_state = "fullgrass_[rand(1, 3)]"


/obj/item/weapon/twohanded/required/kirbyplants
	name = "potted plant"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "plant-1"
	anchored = 0
	layer = 5
	w_class = WEIGHT_CLASS_HUGE
	force = 10
	throwforce = 13
	throw_speed = 2
	throw_range = 4

/obj/item/weapon/twohanded/required/kirbyplants/New()
	..()
	icon_state = "plant-[rand(1,35)]"
	if(prob(1))
		icon_state = "plant-36"

/obj/item/weapon/twohanded/required/kirbyplants/equipped(mob/living/user)
	var/image/I = image(icon = 'icons/obj/flora/plants.dmi' , icon_state = src.icon_state, loc = user)
	I.override = 1
	user.add_alt_appearance("sneaking_mission", I, player_list)

/obj/item/weapon/twohanded/required/kirbyplants/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("sneaking_mission")

/obj/item/weapon/twohanded/required/kirbyplants/dead
	name = "\improper RD's potted plant"
	desc = "A gift from the botanical staff, presented after the RD's reassignment. There's a tag on it that says \"Y'all come back now, y'hear?\"\nIt doesn't look very healthy..."
	icon_state = "plant-dead"

//a rock is flora according to where the icon file is
//and now these defines
/obj/structure/flora/rock
	name = "rock"
	desc = "a rock"
	icon_state = "rock1"
	icon = 'icons/obj/flora/rocks.dmi'
	burn_state = FIRE_PROOF
	anchored = 1

/obj/structure/flora/rock/New()
	icon_state = "rock[rand(1,5)]"

/obj/structure/flora/rock/pile
	name = "rocks"
	desc = "some rocks"
	icon_state = "rockpile1"

/obj/structure/flora/rock/pile/New()
	icon_state = "rockpile[rand(1,5)]"
//a rock is flora according to where the icon file is
//and now these defines

/obj/structure/flora/rock/basalt
	icon_state = "basalt"
	desc = "A volcanic rock"
	icon = 'icons/obj/flora/rocks2.dmi'
	burn_state = FIRE_PROOF
	density = 1

/obj/structure/flora/rock/basalt/New()
	icon_state = "[icon_state][rand(1,3)]"

/obj/structure/flora/rock/basalt/pile
	icon_state = "lavarocks"
	desc = "A pile of rocks"

/obj/structure/flora/rock/basalt/pile/New()
	icon_state = "[icon_state][rand(1,3)]"

/obj/structure/flora/rock/basalt/icy
	name = "icy rock"
	color = rgb(114,228,250)

/obj/structure/flora/rock/pile/basalt/icy
	name = "icy rocks"
	color = rgb(114,228,250)

/obj/structure/flora/rock/jungle
	icon_state = "pile of rocks"
	desc = "A pile of rocks."
	icon_state = "rock"
	icon = 'icons/obj/flora/jungleflora.dmi'
	density = FALSE

/obj/structure/flora/rock/jungle/New()
	..()
	icon_state = "[initial(icon_state)][rand(1,5)]"


//Jungle bushes

/obj/structure/flora/junglebush
	name = "bush"
	icon = 'icons/obj/flora/jungleflora.dmi'
	icon_state = "busha"

/obj/structure/flora/junglebush/New()
	icon_state = "[icon_state][rand(1, 3)]"
	..()

/obj/structure/flora/junglebush/b
	icon_state = "bushb"

/obj/structure/flora/junglebush/c
	icon_state = "bushc"

/obj/structure/flora/junglebush/large
	icon_state = "bush"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	pixel_x = -16
	pixel_y = -12
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/flora/rock/pile/largejungle
	name = "rocks"
	icon_state = "rocks"
	icon = 'icons/obj/flora/largejungleflora.dmi'
	density = FALSE
	pixel_x = -16
	pixel_y = -16

/obj/structure/flora/rock/pile/largejungle/New()
	..()
	icon_state = "[initial(icon_state)][rand(1,3)]"

/obj/structure/flora/corn_stalk
	name = "corn stalk"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "cornstalk1"
	anchored = 0
	layer = 5

/obj/structure/flora/corn_stalk/alt_1
	icon_state = "cornstalk2"

/obj/structure/flora/corn_stalk/alt_2
	icon_state = "cornstalk3"

/obj/structure/flora/straw_bail
	name = "straw bail"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "strawbail1"
	density = 1
	climbable = 1 // you can climb all over them.

/obj/structure/flora/straw_bail/alt_1
	icon_state = "strawbail2"

/obj/structure/flora/straw_bail/alt_2
	icon_state = "strawbail3"

/obj/structure/bush
	name = "foliage"
	desc = "Pretty thick scrub, it'll take something sharp and a lot of determination to clear away."
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "bush1"
	density = 1
	anchored = 1
	layer = 3.2
	var/indestructable = 0
	var/stump = 0

/obj/structure/bush/New()
	if(prob(20))
		opacity = 1

/*
/obj/structure/bush/Bumped(M as mob)
	if(istype(M, /mob/living/simple_animal))
		var/mob/living/simple_animal/A = M
		A.loc = get_turf(src)
	else if(istype(M, /mob/living/carbon/monkey))
		var/mob/living/carbon/monkey/A = M
		A.loc = get_turf(src)
*/

/obj/structure/bush/attackby(var/obj/I as obj, var/mob/user as mob, params)
	//hatchets can clear away undergrowth
	if(istype(I, /obj/item/weapon/hatchet) && !stump)
		if(indestructable)
			//this bush marks the edge of the map, you can't destroy it
			to_chat(user, "<span class='warning'>You flail away at the undergrowth, but it's too thick here.</span>")
		else
			user.visible_message("<span class='danger'>[user] begins clearing away [src].</b>","<span class='warning'><b>You begin clearing away [src].</span></span>")
			spawn(rand(15,30))
				if(get_dist(user,src) < 2)
					to_chat(user, "<span class='notice'>You clear away [src].</span>")
					var/obj/item/stack/sheet/wood/W = new(src.loc)
					W.amount = rand(3,15)
					if(prob(50))
						icon_state = "stump[rand(1,2)]"
						name = "cleared foliage"
						desc = "There used to be dense undergrowth here."
						density = 0
						stump = 1
						pixel_x = rand(-6,6)
						pixel_y = rand(-6,6)
					else
						qdel(src)
	else
		return ..()
