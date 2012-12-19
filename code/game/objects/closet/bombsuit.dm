
/obj/closet/bombcloset
	desc = "A bulky (yet mobile) closet. Comes prestocked with a level 4 bombsuit."
	name = "EOD closet"
	icon_state = "bombsuit"
	icon_closed = "bombsuit"
	icon_opened = "bombsuitopen"

/obj/closet/bombcloset/New()
	..()
	sleep(2)
	new /obj/item/clothing/suit/bomb_suit( src )
	new /obj/item/clothing/under/color/black( src )
	new /obj/item/clothing/shoes/black( src )
	new /obj/item/clothing/head/bomb_hood( src )

/obj/closet/bombclosetsecurity
	desc = "A bulky (yet mobile) closet. Comes prestocked with a level 4 bombsuit."
	name = "EOD closet"
	icon_state = "bombsuitsec"
	icon_closed = "bombsuitsec"
	icon_opened = "bombsuitsecopen"

/obj/closet/bombclosetsecurity/New()
	..()
	sleep(2)
	new /obj/item/clothing/suit/bomb_suit/security( src )
	new /obj/item/clothing/under/rank/security( src )
	new /obj/item/clothing/shoes/brown( src )
	new /obj/item/clothing/head/bomb_hood/security( src )
