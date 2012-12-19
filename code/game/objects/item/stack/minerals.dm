/*
CONTAINS:
SANDSTONE
DIAMOND
URANIUM
PLASMA
GOLD
SILVER
*/

/////////////////
////Sandstone////
/////////////////

var/global/list/datum/stack_recipe/sandstone_recipes = list ( \
	new/datum/stack_recipe("sandstone door", /obj/mineral_door/sandstone, 10), \
/*	new/datum/stack_recipe("sandstone wall", ???), \
		new/datum/stack_recipe("sandstone floor", ???),\*/
	)

/obj/item/stack/sheet/sandstone
	name = "Sandstone Bricks"
	desc = "This appears to be a combination of both sand and stone."
	singular_name = "sandstone brick"
	icon_state = "sheet-sandstone"
	force = 5.0
	throwforce = 5
	throw_speed = 4
	throw_range = 5
	origin_tech = "materials=1"

/obj/item/stack/sheet/sandstone/New(var/loc, var/amount=null)
		recipes = sandstone_recipes
		return ..()

///////////////
////Diamond////
///////////////

var/global/list/datum/stack_recipe/diamond_recipes = list ( \
	new/datum/stack_recipe("diamond door", /obj/mineral_door/transparent/diamond, 10), \
	)

/obj/item/stack/sheet/diamond
	name = "diamond"
	icon_state = "sheet-diamond"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_range = 3
	origin_tech = "materials=6"
	perunit = 3750

/obj/item/stack/sheet/diamond/New(loc,amount)
	..()
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4

/obj/item/stack/sheet/diamond/New(var/loc, var/amount=null)
		recipes = diamond_recipes
		return ..()

///////////////
////Uranium////
///////////////

var/global/list/datum/stack_recipe/uranium_recipes = list ( \
	new/datum/stack_recipe("uranium door", /obj/mineral_door/uranium, 10), \
	)

/obj/item/stack/sheet/uranium
	name = "Uranium block"
	icon_state = "sheet-uranium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 2000

/obj/item/stack/sheet/uranium
	New(var/loc, var/amount=null)
		recipes = uranium_recipes
		return ..()

//////////////////////////////
////Enriched uranium block////
//////////////////////////////

/obj/item/stack/sheet/enruranium
	name = "Enriched Uranium block"
	icon_state = "sheet-enruranium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 1000

//////////////
////Plasma////
//////////////

var/global/list/datum/stack_recipe/plasma_recipes = list ( \
	new/datum/stack_recipe("plasma door", /obj/mineral_door/transparent/plasma, 10), \
	)

/obj/item/stack/sheet/plasma
	name = "solid plasma"
	icon_state = "sheet-plasma"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "plasmatech=2;materials=2"
	perunit = 2000

/obj/item/stack/sheet/plasma/New(var/loc, var/amount=null)
		recipes = plasma_recipes
		return ..()

////////////
////Gold////
////////////

var/global/list/datum/stack_recipe/gold_recipes = list ( \
	new/datum/stack_recipe("golden door", /obj/mineral_door/gold, 10), \
	)

/obj/item/stack/sheet/gold
	name = "gold"
	icon_state = "sheet-gold"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000

/obj/item/stack/sheet/gold/New(loc,amount)
	..()
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
/*	recipes = gold_recipes          //Commenting out until there's a proper sprite. The golden plaque is supposed to be a special item dedicated to a really good player. -Agouri

	var/global/list/datum/stack_recipe/gold_recipes = list ( \
	new/datum/stack_recipe("Plaque", /obj/item/weapon/plaque_assembly, 2), \
	)*/

/obj/item/stack/sheet/gold/New(var/loc, var/amount=null)
		recipes = gold_recipes
		return ..()

//////////////
////Silver////
//////////////

var/global/list/datum/stack_recipe/silver_recipes = list ( \
	new/datum/stack_recipe("silver door", /obj/mineral_door/silver, 10), \
	)

/obj/item/stack/sheet/silver
	name = "silver"
	icon_state = "sheet-silver"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=3"
	perunit = 2000

/obj/item/stack/sheet/silver/New(loc,amount)
	..()
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4

/obj/item/stack/sheet/silver/New(var/loc, var/amount=null)
		recipes = silver_recipes
		return ..()

//////////////////
////Adamantine////
//////////////////

/obj/item/stack/sheet/adamantine
	name = "adamantine"
	icon_state = "sheet-adamantine"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000

////////////////
////Bananium////
////////////////

/obj/item/stack/sheet/clown
	name = "bananium"
	icon_state = "sheet-clown"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000

/obj/item/stack/sheet/clown/New(loc,amount)
	..()
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
