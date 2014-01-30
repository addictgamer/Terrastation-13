/*
// TODO: add in:
long sword
heavy sword
hammer
bow
longbow
shield
dagger
magic staff (fake)
magic wand
-basically any RP weapons. Will most likely be put in code\game\objects\items\toys.dm
RP clothes/armors, showy
*/

/obj/item/toy/sword
	name = "toy sword"
	desc = "A cheap, plastic replica of a sword. Ages 8 and up."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "sword"
	item_state = "sword"
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD
	attack_verb = list("attacked", "struck", "hit")

/obj/item/toy/sword/long
	name = "toy sword"
	desc = "A cheap, plastic replica of a longsword. Ages 8 and up."
	icon_state = "lsword"
	item_state = "lsword"

/obj/item/toy/axe
	name = "toy axe"
	desc = "A cheap, plastic replica of an axe. Ages 8 and up."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "axe"
	item_state = "axe"
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD
	attack_verb = list("attacked", "struck", "hit")
