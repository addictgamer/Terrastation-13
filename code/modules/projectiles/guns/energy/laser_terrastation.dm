//Gun

/obj/item/weapon/gun/energy/laser/shiper
	name = "Shiper"
	icon = 'icons/obj/terra/gunzor.dmi'
	icon_state = "shiper"
	desc = "A collapsible shotgun that fires... energy? Who the hell designed this thing?"
	//projectile_type = /obj/item/projectile/beam/shiper
//above is old and might be removable
	ammo_type = list(/obj/item/ammo_casing/energy/laser/shiper)
	origin_tech = null
	fire_sound = 'sound/weapons/shiperfire.ogg'
	update_icon()
		return

/obj/item/weapon/gun/energy/laser/shiper/chrome
	name = "Chrome Shiper"
	icon_state = "cshiper"
	desc = "A more rifle-like variant of the shotgun-sniper-thing. This one has a chrome finish."


//Beam


/obj/item/projectile/beam/shiper
	name = "shiper blast"
	icon = 'icons/obj/terra/bulletz.dmi'
	icon_state = "shipe"
	damage = 45

/obj/item/ammo_casing/energy/laser/shiper
	name = "shiper lens"
	desc = "ho ree fuk"
	e_cost = 0
	fire_sound = 'sound/weapons/shiperfire.ogg'