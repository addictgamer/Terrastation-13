
/obj/secure_closet/animal
	name = "Animal Control"
	req_access = list(access_medical)

/obj/secure_closet/animal/New()
	..()
	sleep(2)
	new /obj/item/device/radio/signaler( src )
	new /obj/item/device/radio/electropack( src )
	new /obj/item/device/radio/electropack( src )
	new /obj/item/device/radio/electropack( src )
	new /obj/item/device/radio/electropack( src )
	new /obj/item/device/radio/electropack( src )
	return
