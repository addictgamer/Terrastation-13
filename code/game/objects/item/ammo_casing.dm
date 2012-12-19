
/obj/item/ammo_casing
	name = "bullet casing (.375)"
	desc = "A .357 bullet casing."
	icon = 'ammo.dmi'
	icon_state = "s-casing"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	throwforce = 1
	w_class = 1.0
	var
		caliber = "357" //Which kind of guns it can be loaded into
		obj/item/projectile/BB //The loaded bullet

	New()
		BB = new /obj/item/projectile(src)
		pixel_x = rand(-10.0, 10)
		pixel_y = rand(-10.0, 10)
		dir = pick(cardinal)

	attackby(obj/item/weapon/W as obj, mob/user as mob) //Adding this to the trash list. Nyoro~n --Agouri
		..()
		if (istype(W, /obj/item/weapon/trashbag))
			var/obj/item/weapon/trashbag/S = W
			if (S.mode == 1)
				for (var/obj/item/ammo_casing/AC in locate(src.x,src.y,src.z))
					if (S.contents.len < S.capacity)
						S.contents += AC;
					else
						user << "\blue The bag is full."
						break
				user << "\blue You pick up all trash."
			else
				if (S.contents.len < S.capacity)
					S.contents += src;
				else
					user << "\blue The bag is full."
			S.update_icon()
		return


	a418
		name = "bullet casing (.418)"
		desc = "A .418 bullet casing."
		caliber = "357"

		New()
			BB = new /obj/item/projectile/suffocationbullet(src)
			pixel_x = rand(-10.0, 10)
			pixel_y = rand(-10.0, 10)
			dir = pick(cardinal)

	a75
		name = "bullet casing (.75)"
		desc = "A .75 bullet casing."
		caliber = "75"

		New()
			BB = new /obj/item/projectile/gyro(src)
			pixel_x = rand(-10.0, 10)
			pixel_y = rand(-10.0, 10)
			dir = pick(cardinal)
	a666
		name = "bullet casing (.666)"
		desc = "A .666 bullet casing."
		caliber = "357"

		New()
			BB = new /obj/item/projectile/cyanideround(src)
			pixel_x = rand(-10.0, 10)
			pixel_y = rand(-10.0, 10)
			dir = pick(cardinal)

	c38
		name = "bullet casing (.38)"
		desc = "A .38 bullet casing."
		caliber = "38"

		New()
			BB = new /obj/item/projectile/weakbullet(src)
			pixel_x = rand(-10.0, 10)
			pixel_y = rand(-10.0, 10)
			dir = pick(cardinal)

	c9mm
		name = "bullet casing (9mm)"
		desc = "A 9mm bullet casing."
		caliber = "9mm"

		New()
			BB = new /obj/item/projectile/weakbullet(src)
			pixel_x = rand(-10.0, 10)
			pixel_y = rand(-10.0, 10)
			dir = pick(cardinal)

	c45
		name = "bullet casing (.45)"
		desc = "A .45 bullet casing."
		caliber = ".45"

		New()
			BB = new /obj/item/projectile/midbullet(src)
			pixel_x = rand(-10.0, 10)
			pixel_y = rand(-10.0, 10)
			dir = pick(cardinal)


	shotgun
		desc = "A 12gauge shell."
		name = "12 gauge shell"
		icon_state = "gshell"
		caliber = "shotgun"
		m_amt = 12500

		New()
			BB = new /obj/item/projectile
			src.pixel_x = rand(-10.0, 10)
			src.pixel_y = rand(-10.0, 10)
		blank
			desc = "A blank shell."
			name = "blank shell"
			icon_state = "blshell"
			m_amt = 250

			New()
				src.pixel_x = rand(-10.0, 10)
				src.pixel_y = rand(-10.0, 10)

		beanbag
			desc = "A weak beanbag shell."
			name = "beanbag shell"
			icon_state = "bshell"
			m_amt = 500

			New()
				BB = new /obj/item/projectile/weakbullet
				src.pixel_x = rand(-10.0, 10)
				src.pixel_y = rand(-10.0, 10)

		stunshell
			desc = "A stunning shell."
			name = "stun shell"
			icon_state = "stunshell"
			m_amt = 2500

			New()
				BB = new /obj/item/projectile/stunshot
				src.pixel_x = rand(-10.0, 10)
				src.pixel_y = rand(-10.0, 10)

		dart
			desc = "A dart for use in shotguns.."
			name = "shotgun darts"
			icon_state = "blshell" //someone, draw the icon, please.
			m_amt = 50000 //because it's like, instakill.

			New()
				BB = new /obj/item/projectile/dart
				src.pixel_x = rand(-10.0, 10)
				src.pixel_y = rand(-10.0, 10)
