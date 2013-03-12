
/obj/new_year_tree
	name = "The fir"
	desc = "This is a fir. Real fir on dammit spess station. You smell pine-needles."
	icon = '160x160.dmi'
	icon_state = "new-year-tree"
	anchored = 1
	opacity = 1
	density = 1
	layer = 5
	pixel_x = -64
	//pixel_y = -64

	attackby(obj/item/W, mob/user)
		if (istype(W, /obj/item/weapon/grab))
			return
		W.loc = src
		if (user.client)
			user.client.screen -= W
		user.u_equip(W)
		var/const/bottom_right_x = 115.0
		var/const/bottom_right_y = 150.0
		var/const/top_left_x = 15.0
		var/const/top_left_y = 15.0
		var/const/bottom_med_x = top_left_x+(bottom_right_x-top_left_x)/2
		var/x = rand(top_left_x,bottom_med_x) //point in half of circumscribing rectangle
		var/y = rand(top_left_y,bottom_right_y)
/*
		y1=a*x1+b
		y2=a*x2+b   	b = y2-a*x2
		y1=a*x1+ y2-a*x2
		a*(x1-x2)+y2-y1=0
		a = (y1-y2)/(x1-x2)
*/
		var/a = (top_left_y-bottom_right_y)/(top_left_x-bottom_med_x)
		var/b = bottom_right_y-a*bottom_med_x
		if (a*x+b < y) //if point is above diagonal top_left -> bottom_median
			x = bottom_med_x + x - top_left_x
			y = bottom_right_y - y + top_left_y
		var/image/I = image(W.icon, W, icon_state = W.icon_state)
		I.pixel_x = x
		I.pixel_y = y
		overlays += I

/*
/datum/supply_packs/new_year
	name = "New Year Celebration Equipment"
	contains = list("/obj/item/weapon/firbang",
					"/obj/item/weapon/firbang",
					"/obj/item/weapon/firbang",
					"/obj/item/weapon/wrapping_paper",
					"/obj/item/weapon/wrapping_paper",
					"/obj/item/weapon/wrapping_paper")
	cost = 20
	containertype = "/obj/crate"
	containername = "New Year Celebration crate"
*/
