
/obj/laser
	name = "laser"
	desc = "IT BURNS!!!"
	icon = 'projectiles.dmi'
	var
		damage = 0.0
		range = 10.0

	Bump()
		src.range--
		return

	Move()
		src.range--
		return
