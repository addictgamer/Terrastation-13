
/obj/secure_closet/brig
	name = "Brig Locker"
	req_access = list(access_brig)
	var/id = null

/obj/secure_closet/brig/New()
	new /obj/item/clothing/under/color/orange( src )
	new /obj/item/clothing/under/color/orange( src )
	new /obj/item/clothing/shoes/orange( src )
	new /obj/item/clothing/shoes/orange( src )
	return
