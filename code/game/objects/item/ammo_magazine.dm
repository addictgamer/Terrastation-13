
/obj/item/ammo_magazine
	name = "ammo box (.357)"
	desc = "A box of .357 ammo"
	icon_state = "357"
	icon = 'ammo.dmi'
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	item_state = "syringe_kit"
	m_amt = 50000
	throwforce = 2
	w_class = 1.0
	throw_speed = 4
	throw_range = 20
	var
		list/stored_ammo = list()

	New()
		for(var/i = 1, i <= 7, i++)
			stored_ammo += new /obj/item/ammo_casing(src)
		update_icon()

	update_icon()
		icon_state = text("[initial(icon_state)]-[]", stored_ammo.len)
		desc = text("There are [] shell\s left!", stored_ammo.len)

	a75
		name = "ammo magazine (.75)"
		icon_state = "gyro"
		New()
			for(var/i = 1, i <= 8, i++)
				stored_ammo += new /obj/item/ammo_casing/a75(src)
			update_icon()

	c38
		name = "speed loader (.38)"
		icon_state = "38"
		New()
			for(var/i = 1, i <= 7, i++)
				stored_ammo += new /obj/item/ammo_casing/c38(src)
			update_icon()

	a418
		name = "ammo box (.418)"
		icon_state = "418"
		New()
			for(var/i = 1, i <= 7, i++)
				stored_ammo += new /obj/item/ammo_casing/a418(src)
			update_icon()

	a666
		name = "ammo box (.666)"
		icon_state = "666"
		New()
			for(var/i = 1, i <= 2, i++)
				stored_ammo += new /obj/item/ammo_casing/a666(src)
			update_icon()

	c9mm
		name = "Ammunition Box (9mm)"
		icon_state = "9mm"
		origin_tech = "combat=3;materials=2"
		New()
			for(var/i = 1, i <= 30, i++)
				stored_ammo += new /obj/item/ammo_casing/c9mm(src)
			update_icon()

		update_icon()
			desc = text("There are [] round\s left!", stored_ammo.len)

	c45
		name = "Ammunition Box (.45)"
		icon_state = "9mm"
		origin_tech = "combat=3;materials=2"
		New()
			for(var/i = 1, i <= 30, i++)
				stored_ammo += new /obj/item/ammo_casing/c45(src)
			update_icon()

		update_icon()
			desc = text("There are [] round\s left!", stored_ammo.len)

/*
	shotgun
		name = "ammo box (12gauge)"
		desc = "A box of 12 gauge shell"
		icon_state = "" //no sprite :'(
		caliber = "shotgun"
		m_amt = 25000

		New()
			BB = new /obj/item/projectile/shotgun(src)
			src.pixel_x = rand(-10.0, 10)
			src.pixel_y = rand(-10.0, 10)
*/
