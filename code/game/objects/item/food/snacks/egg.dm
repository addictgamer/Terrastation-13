
/obj/item/weapon/reagent_containers/food/snacks/egg
	name = "egg"
	desc = "An egg!"
	icon_state = "egg"
	New()
		..()
		reagents.add_reagent("nutriment", 1)

	throw_impact(atom/hit_atom)
		..()
		new/obj/decal/cleanable/egg_smudge(src.loc)
		src.visible_message("\red [src.name] has been squashed.","\red You hear a smack.")
		del(src)
