
/obj/secure_closet/chemical
	name = "Chemical Closet"
	desc = "Store dangerous chemicals in here. This closet is full of cobwebs."
	icon_state = "medical1"
	icon_closed = "medical"
	icon_locked = "medical1"
	icon_opened = "medicalopen"
	icon_broken = "medicalbroken"
	icon_off = "medical1"
	req_access = list(access_medical)

/obj/secure_closet/chemtoxin
	name = "Chemistry Locker"

	req_access = list(access_medical)

/obj/secure_closet/chemtoxin/New()
	..()
	sleep(2)
	new /obj/item/weapon/storage/pillbottlebox(src)
	new /obj/item/weapon/storage/pillbottlebox(src)
	return