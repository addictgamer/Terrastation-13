
/obj/secure_closet/courtroom
	name = "Courtroom Locker"
	req_access = list(access_court)

/obj/secure_closet/courtroom/New()
	..()
	sleep(2)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/paper/Court (src)
	new /obj/item/paper/Court (src)
	new /obj/item/paper/Court (src)
	new /obj/item/weapon/pen (src)
	new /obj/item/clothing/suit/judgerobe (src)
	new /obj/item/clothing/head/powdered_wig (src)
	new /obj/item/clothing/under/lawyer/red(src)
	new /obj/item/clothing/under/lawyer/blue(src)
	new /obj/item/clothing/under/lawyer/black(src)
	new /obj/item/weapon/storage/briefcase(src)
	return
