/*
CONTAINS:
WOOD PLANKS
*/

var/global/list/datum/stack_recipe/wood_recipes = list ( \
	new/datum/stack_recipe("table parts", /obj/item/weapon/table_parts/wood, 2), \
	new/datum/stack_recipe("wooden barricade", /obj/barricade/wooden, 5, time = 30, one_per_turf = 1, on_floor = 1),\
	)

/obj/item/stack/sheet/wood
	name = "Wood Planks"
	desc = "One can only guess that this is a bunch of wood."
	singular_name = "wood plank"
	icon_state = "sheet-wood"
	force = 5.0
	throwforce = 5
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=1;biotech=1"

/obj/item/stack/sheet/wood/New(var/loc, var/amount=null)
		recipes = wood_recipes
		return ..()
