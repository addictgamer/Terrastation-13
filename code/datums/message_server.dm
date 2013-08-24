
/datum/data_pda_msg
	var/recipient = "Unspecified" //name of the person
	var/sender = "Unspecified" //name of the sender
	var/message = "Blank" //transferred message

/datum/data_pda_msg/New(var/param_rec = "",var/param_sender = "",var/param_message = "")
	if (param_rec)
		recipient = param_rec
	if (param_sender)
		sender = param_sender
	if (param_message)
		message = param_message

/datum/data_rc_msg
	var/rec_dpt = "Unspecified" //name of the person
	var/send_dpt = "Unspecified" //name of the sender
	var/message = "Blank" //transferred message
	var/stamp = "Unstamped"
	var/id_auth = "Unauthenticated"
	var/priority = "Normal"

/datum/data_rc_msg/New(var/param_rec = "",var/param_sender = "",var/param_message = "",var/param_stamp = "",var/param_id_auth = "",var/param_priority)
	if (param_rec)
		rec_dpt = param_rec
	if (param_sender)
		send_dpt = param_sender
	if (param_message)
		message = param_message
	if (param_stamp)
		stamp = param_stamp
	if (param_id_auth)
		id_auth = param_id_auth
	if (param_priority)
		switch(param_priority)
			if (1)
				priority = "Normal"
			if (2)
				priority = "High"
			if (3)
				priority = "Extreme"
			else
				priority = "Undetermined"

/datum/feedback_variable
	var/variable
	var/value

	New(var/param_variable,var/param_value = 0)
		variable = param_variable
		value = param_value

	proc/inc(var/num = 1)
		if (isnum(value))
			value += num
		else
			value = text2num(value)
			if (isnum(value))
				value += num
			else
				value = num

	proc/dec(var/num = 1)
		if (isnum(value))
			value -= num
		else
			value = text2num(value)
			if (isnum(value))
				value -= num
			else
				value = -num

	proc/set_value(var/num)
		if (isnum(num))
			value = num

	proc/get_value()
		return value

	proc/get_variable()
		return variable

	proc/get_parsed()
		return list(variable,value)

var/obj/machinery/blackbox_recorder/blackbox

proc/feedback_set(var/variable,var/value)
	if (!blackbox) return

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if (!FV) return

	FV.set_value(value)

proc/feedback_inc(var/variable,var/value)
	if (!blackbox) return

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if (!FV) return

	FV.inc(value)

proc/feedback_dec(var/variable,var/value)
	if (!blackbox) return

	var/datum/feedback_variable/FV = blackbox.find_feedback_datum(variable)

	if (!FV) return

	FV.dec(value)
