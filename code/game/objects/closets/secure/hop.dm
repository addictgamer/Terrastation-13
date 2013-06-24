/*
AT SOME POINT, this closet will only be openable by someone who knows the four-digit code to unlock it.
This code will be in the HoP's memory unless some kind of shenanigans prevent that from happenbing.
For the time being, however, this locker is just locked with HoP access level.
*/

/obj/secure_closet/hop/New()
	..()
	sleep(2)
	new /obj/item/clothing/mask/owl_mask(src) //mask
	new /obj/item/clothing/under/owl(src) //suit
	new /obj/item/weapon/cloaking_device(src) //cloaker BUT WE NEED AN OWL VARIANT THAT DOES THIS SO THAT PEOPLE DON'T KILL THE HOP FOR HAVING THIS IN THEORY
	new /obj/item/clothing/gloves/stungloves(src) //stungloves
	new /obj/item/weapon/gun/energy/shockgun(src) //shock gun
	new /obj/item/clothing/shoes/galoshes(src) //dem shooz