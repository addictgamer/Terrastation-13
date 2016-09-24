//This is for shuttle functionality that is exclusive to us	--LZ


//BEGIN ADDED FUCNTIONALITY FOR EXISTING SHUTTLES
//trade

/obj/machinery/computer/shuttle/trade/sol/terra //just to separate ours from theirs
	docking_request_message = "A trading ship of Sol origin has requested docking aboard Terrastation for trading. This request can be accepted or denied using a communications console."

/obj/machinery/computer/shuttle/trade/sol/terra/rock2 //Rock2 stuff
	possible_destinations_dock = "trade_sol_base;trade_sol_offstation;trade_dock;trade_dock_salvage;trade_dock_ruskie"
	possible_destinations_nodock = "trade_sol_base;trade_sol_offstation;trade_dock_salvage;trade_dock_ruskie"
	docking_request_message = "A trading ship of Sol origin has requested docking aboard NSS Rockstation for trading. This request can be accepted or denied using a communications console."


//white ship

/obj/machinery/computer/shuttle/white_ship/terra //again, to separate

/obj/item/weapon/circuitboard/white_ship/rock2 //Needed for below

/obj/machinery/computer/shuttle/white_ship/terra/rock2 //unowot
	circuit = /obj/item/weapon/circuitboard/white_ship/rock2
	possible_destinations = "whiteship_away;whiteship_home;whiteship_z4;whiteship_salvage"





//BEGIN NEW SHUTTLE COCK

//Salvage Jumper

/obj/machinery/computer/shuttle/salvage
	req_access = list(access_salvage_captain)
	name = "Salvage Shuttle Console"
	desc = "Used to jump around the salvage yard and to dock at the main/salvage stations"
	shuttleId = "salvage"
	possible_destinations = "salvage_home;salvage_ss13"