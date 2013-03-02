
/obj/item/robot_parts
	name = "robot parts"
	icon = 'robot_parts.dmi'
	item_state = "buildpipe"
	icon_state = "blank"
	flags = FPRINT | ONBELT | TABLEPASS | CONDUCT
	var
		construction_time = 100
		list/construction_cost = list("metal"=20000,"glass"=5000)
