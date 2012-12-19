
/obj/item/device/radio/headset
	name = "Radio Headset"
	desc = "An intercom that fits over the head."
	icon_state = "headset"
	item_state = "headset"
	g_amt = 0
	m_amt = 75
	var
		protective_temperature = 0
		translate_binary = 0
		translate_hive = 0

/obj/item/device/radio/headset/traitor
	translate_binary = 1
	channels = list("Syndicate" = 1)
	origin_tech = "syndicate=3"

/obj/item/device/radio/headset/headset_sec // -- TLE
	name = "Security Radio Headset"
	desc = "This is used by your elite security force. To access the security channel, use :s."
	icon_state = "sec_headset"
	item_state = "headset"
	channels = list("Security" = 1)

/obj/item/device/radio/headset/headset_eng // -- TLE
	name = "Engineering Radio Headset"
	desc = "When the engineers wish to chat like girls. To access the engineering channel, use :e. "
	icon_state = "eng_headset"
	item_state = "headset"
	channels = list("Engineering" = 1)

/obj/item/device/radio/headset/headset_rob // -- DH
	name = "Robotics Radio Headset"
	desc = "Made specifically for the roboticists who cannot decide between departments. To access the engineering channel, use :e. For research, use :n."
	icon_state = "rob_headset"
	item_state = "headset"
	channels = list("Engineering" = 1, "Science" = 1)

/obj/item/device/radio/headset/headset_med // -- TLE
	name = "Medical Radio Headset"
	desc = "A headset for the trained staff of the medbay. To access the medical channel, use :m."
	icon_state = "med_headset"
	item_state = "headset"
	channels = list("Medical" = 1)

/obj/item/device/radio/headset/headset_sci // -- Bar
	name = "Science Radio Headset"
	desc = "A sciency headset. Like usual. To access the science channel, use :n."
	icon_state = "com_headset"
	item_state = "headset"
	channels = list("Science" = 1)

/obj/item/device/radio/headset/headset_medsci // -- Micro
	name = "Medical Research Radio Headset"
	desc = "A headset that is a result of the mating between medical and science. To access the medical channel, use :m. For science, use :n."
	icon_state = "med_headset"
	item_state = "headset"
	channels = list("Medical" = 1, "Science" = 1)

/obj/item/device/radio/headset/headset_com // -- TLE
	name = "Command Radio Headset"
	desc = "A headset with a commanding channel. To access the command channel, use :c."
	icon_state = "com_headset"
	item_state = "headset"
	channels = list("Command" = 1)

/obj/item/device/radio/headset/headset_mine // -- rastaf0
	name = "Mining Radio Headset"
	desc = "Headset used by miners. How useless. To access the mining channel, use :d."
	icon_state = "mine_headset"
	item_state = "headset"
	channels = list("Mining" = 1)

/obj/item/device/radio/headset/headset_cargo // -- rastaf0
	name = "Cargo Radio Headset"
	desc = "Headset used by the QM's slaves. To access the cargo channel, use :q."
	icon_state = "cargo_headset"
	item_state = "headset"
	channels = list("Cargo" = 1)

/obj/item/device/radio/headset/space_pirate
	name = "Space Pirate's Headset."
	desc = "Every space pirate has one of these headsets."
	icon_state = "sec_headset"
	item_state = "headset"
	channels = list("Space Pirate" = 1)
