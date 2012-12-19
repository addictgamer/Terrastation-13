
/obj/machinery/blackbox_recorder
	icon = 'stationobjs.dmi'
	icon_state = "blackbox"
	name = "Blackbox Recorder"
	density = 1
	anchored = 1.0
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 100
	var/messages = list()
	var/messages_admin = list()

	var/msg_common = list()
	var/msg_science = list()
	var/msg_command = list()
	var/msg_medical = list()
	var/msg_engineering = list()
	var/msg_security = list()
	var/msg_deathsquad = list()
	var/msg_syndicate = list()
	var/msg_mining = list()
	var/msg_cargo = list()

	var/list/datum/feedback_variable/feedback = new()

	//Only one can exsist in the world!
	New()
		for(var/obj/machinery/blackbox_recorder/BR in world)
			if(BR != src)
				del(src)
		blackbox = src

	proc/find_feedback_datum(var/variable)
		for(var/datum/feedback_variable/FV in feedback)
			if(FV.get_variable() == variable)
				return FV
		var/datum/feedback_variable/FV = new(variable)
		feedback += FV
		return FV

	proc/get_round_feedback()
		return feedback
