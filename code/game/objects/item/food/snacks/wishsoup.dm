
/obj/item/weapon/reagent_containers/food/snacks/wishsoup
	name = "Wish Soup"
	desc = "I wish this was soup."
	icon = 'janitor.dmi'
	icon_state = "bucket"
	New()
		..()
		reagents.add_reagent("water", 20)
		bitesize = 5
