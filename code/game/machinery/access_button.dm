
obj/machinery/access_button
	icon = 'airlock_machines.dmi'
	icon_state = "access_button_standby"
	name = "Access Button"

	anchored = 1

	var/master_tag
	var/frequency = 1449
	var/command = "cycle"

	var/datum/radio_frequency/radio_connection

	var/on = 1

	update_icon()
		if (on)
			icon_state = "access_button_standby"
		else
			icon_state = "access_button_off"

	attack_hand(mob/user)
		if (radio_connection)
			var/datum/signal/signal = new
			signal.transmission_method = 1 //radio signal
			signal.data["tag"] = master_tag
			signal.data["command"] = command

			radio_connection.post_signal(src, signal, range = AIRLOCK_CONTROL_RANGE, filter = RADIO_AIRLOCK)
		flick("access_button_cycle", src)

	proc
		set_frequency(new_frequency)
			radio_controller.remove_object(src, frequency)
			frequency = new_frequency
			radio_connection = radio_controller.add_object(src, frequency, RADIO_AIRLOCK)

	initialize()
		set_frequency(frequency)

	New()
		..()

		if (radio_controller)
			set_frequency(frequency)
