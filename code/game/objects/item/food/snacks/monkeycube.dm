
/obj/item/weapon/reagent_containers/food/snacks/monkeycube
	name = "monkey cube"
	desc = "Just add water!"
	icon_state = "monkeycube"
	bitesize = 12
	var/wrapped = 0

	New()
		..()
		reagents.add_reagent("nutriment",12)

	afterattack(obj/O as obj, mob/user as mob)
		if(istype(O,/obj/machinery/sink) && !wrapped)
			user << "You place [name] under a stream of water..."
			loc = get_turf(O)
			return Expand()
		..()

	attack_self(mob/user as mob)
		if(wrapped)
			Unwrap(user)

	proc/Expand()
		for(var/mob/M in viewers(src,7))
			M << "\red The monkey cube expands!"
		new /mob/living/carbon/monkey(get_turf(src))
		del(src)

	proc/Unwrap(mob/user as mob)
		icon_state = "monkeycube"
		desc = "Just add water!"
		user << "You unwrap the cube."
		wrapped = 0
		return

	wrapped
		desc = "Still wrapped in some paper."
		icon_state = "monkeycubewrap"
		wrapped = 1
