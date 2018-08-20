/datum/event/cargo_bonus
	announceWhen	= 5

/datum/event/cargo_bonus/announce()
	event_announcement.Announce("Congratulations! [station_name()] was chosen for a supply limit increase. Please contact the local cargo department for details!", "Supply Alert")

/datum/event/cargo_bonus/start()
	shuttle_master.points += rand(100,500)