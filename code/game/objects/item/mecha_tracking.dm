
/obj/item/mecha_tracking
	name = "Exosuit tracking beacon"
	desc = "Device used to transmit exosuit data."
	icon = 'device.dmi'
	icon_state = "motion2"
	origin_tech = "programming=2;magnets=2"
	var/construction_time = 50
	var/list/construction_cost = list("metal"=500)

	proc/get_mecha_info()
		if (!in_mecha())
			return 0
		var/obj/mecha/M = src.loc
		var/cell_charge = M.get_charge()
		var/answer = {"<b>Name:</b> [M.name]<br>
							<b>Integrity:</b> [M.health/initial(M.health)*100]%<br>
							<b>Cell charge:</b> [isnull(cell_charge)?"Not found":"[M.cell.percent()]%"]<br>
							<b>Airtank:</b> [M.return_pressure()]kPa<br>
							<b>Pilot:</b> [M.occupant||"None"]<br>
							<b>Location:</b> [get_area(M)||"Unknown"]<br>
							<b>Active equipment:</b> [M.selected||"None"]"}
		if (istype(M, /obj/mecha/working/ripley))
			var/obj/mecha/working/ripley/RM = M
			answer += "<b>Used cargo space:</b> [RM.cargo.len/RM.cargo_capacity*100]%<br>"

		return answer

	emp_act()
		del src
		return

	ex_act()
		del src
		return

	proc/in_mecha()
		if (istype(src.loc, /obj/mecha))
			return 1
		return 0

	proc/shock()
		if (src.in_mecha())
			var/obj/mecha/M = src.loc
			M.emp_act(3)
		del(src)

	proc/get_mecha_log()
		if (!src.in_mecha())
			return 0
		var/obj/mecha/M = src.loc
		return M.get_log_html()
