//Gun

/obj/item/weapon/gun/energy/laser/shiper
	name = "Shiper"
	icon = 'icons/obj/terra/gunzor.dmi'
	icon_state = "shiper"
	desc = "A collapsible shotgun that fires... energy? Who the hell designed this thing?"
	projectile_type = /obj/item/projectile/beam/shiper
	charge_cost = 0
	origin_tech = null
	fire_sound = 'sound/weapons/shiperfire.ogg'
	update_icon()
		return


//Beam

/obj/item/projectile/beam/shiper
	name = "shiper blast"
	icon = 'icons/obj/terra/bulletz.dmi'
	icon_state = "shipe"
	damage = 45