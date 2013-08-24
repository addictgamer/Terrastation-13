
/obj/item/weapon/reagent_containers/food/snacks/popcorn
	name = "Popcorm" //not a typo
	desc = "Now let's find some cinema."
	icon_state = "popcorn"
	trash = "popcorn"
	var/unpopped = 0
	New()
		..()
		unpopped = rand(1,10)
		reagents.add_reagent("nutriment", 2)
		bitesize = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	On_Consume()
		if (prob(unpopped))
			usr << "\red You bite down on an un-popped kernel!"
			unpopped = max(0, unpopped-1)
		..()
