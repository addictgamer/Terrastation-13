
/obj/machinery/computer/mech_bay_power_console
	name = "Mech Bay Power Control Console"
	density = 1
	anchored = 1
	icon = 'computer.dmi'
	icon_state = "recharge_comp"
	circuit = "/obj/item/weapon/circuitboard/mech_bay_power_console"
	var/autostart = 1
	var/voltage = 45
	var/turf/simulated/floor/mech_bay_recharge_floor/recharge_floor
	var/obj/machinery/mech_bay_recharge_port/recharge_port

	proc/mecha_in(var/obj/mecha/mecha)
		if(stat&(NOPOWER|BROKEN))
			mecha.occupant_message("<font color='red'>Control console not responding. Terminating...</font>")
			return
		if(recharge_port && autostart)
			var/answer = recharge_port.start_charge(mecha)
			if(answer)
				recharge_port.set_voltage(voltage)
				src.icon_state = initial(src.icon_state)+"_on"
		return

	proc/mecha_out()
		if(recharge_port)
			recharge_port.stop_charge()
		return


	power_change()
		if(stat & BROKEN)
			icon_state = initial(icon_state)+"_broken"
			if(recharge_port)
				recharge_port.stop_charge()
		else if(powered())
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
		else
			spawn(rand(0, 15))
				icon_state = initial(icon_state)+"_nopower"
				stat |= NOPOWER
				if(recharge_port)
					recharge_port.stop_charge()

	set_broken()
		icon_state = initial(icon_state)+"_broken"
		stat |= BROKEN
		if(recharge_port)
			recharge_port.stop_charge()

	attack_hand(mob/user as mob)
		if(..()) return
		var/output = "<html><head><title>[src.name]</title></head><body>"
		if(!recharge_floor)
			output += "<font color='red'>Mech Bay Recharge Station not initialized.</font><br>"
		else
			output += {"<b>Mech Bay Recharge Station Data:</b><div style='margin-left: 15px;'>
							<b>Mecha: </b>[recharge_floor.recharging_mecha||"None"]<br>"}
			if(recharge_floor.recharging_mecha)
				var/cell_charge = recharge_floor.recharging_mecha.get_charge()
				output += "<b>Cell charge: </b>[isnull(cell_charge)?"No powercell found":"[recharge_floor.recharging_mecha.cell.charge]/[recharge_floor.recharging_mecha.cell.maxcharge]"]<br>"
			output += "</div>"
		if(!recharge_port)
			output += "<font color='red'>Mech Bay Power Port not initialized.</font><br>"
		else
			output += "<b>Mech Bay Power Port Status: </b>[recharge_port.active()?"Now charging":"On hold"]<br>"

		/*
		output += {"<hr>
						<b>Settings:</b>
						<div style='margin-left: 15px;'>
						<b>Start sequence on succesful init: </b><a href='?src=\ref[src];autostart=1'>[autostart?"On":"Off"]</a><br>
						<b>Recharge Port Voltage: </b><a href='?src=\ref[src];voltage=30'>Low</a> - <a href='?src=\ref[src];voltage=45'>Medium</a> - <a href='?src=\ref[src];voltage=60'>High</a><br>
						</div>"}
		*/

		output += "</ body></html>"
		user << browse(output, "window=mech_bay_console")
		onclose(user, "mech_bay_console")
		return


	Topic(href, href_list)
		if(href_list["autostart"])
			autostart = !autostart
		if(href_list["voltage"])
			voltage = text2num(href_list["voltage"])
			if(recharge_port)
				recharge_port.set_voltage(voltage)
		updateUsrDialog()
		return
