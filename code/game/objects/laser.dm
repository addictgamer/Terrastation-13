
/obj/laser
	name = "laser"
	desc = "IT BURNS!!!"
	icon = 'projectiles.dmi'
	var/damage = 0.0
	var/range = 10.0

/obj/laser/Bump()
	src.range--
	return

/obj/laser/Move()
	src.range--
	return
