//This is for shuttle functionality that is exclusive to us	--LZ


//BEGIN ADDED FUCNTIONALITY FOR EXISTING SHUTTLES
//trade

/obj/machinery/computer/shuttle/trade/sol/terra //just to separate ours from theirs
	docking_request_message = "A trading ship of Sol origin has requested docking aboard Terrastation for trading. This request can be accepted or denied using a communications console."

/obj/machinery/computer/shuttle/trade/sol/terra/rock2 //Rock2 stuff
	possible_destinations_dock = "trade_sol_base;trade_sol_offstation;trade_dock_ruskie;trade_dock_junk;trade_dock"
	possible_destinations_nodock = "trade_sol_base;trade_sol_offstation;trade_dock_ruskie;trade_dock_junk"
	docking_request_message = "A trading ship of Sol origin has requested docking aboard NSS Rockstation for trading. This request can be accepted or denied using a communications console."


//white ship

/obj/machinery/computer/shuttle/white_ship/terra //again, to separate

/obj/item/weapon/circuitboard/white_ship/rock2 //Needed for below, since this console needs to be built to exist ingame without adminhax
	build_path = /obj/machinery/computer/shuttle/white_ship/terra/rock2

/obj/machinery/computer/shuttle/white_ship/terra/rock2 //unowot
	circuit = /obj/item/weapon/circuitboard/white_ship/rock2
	possible_destinations = "whiteship_away;whiteship_home;whiteship_z4;whiteship_junk"





//BEGIN NEW SHUTTLE COCK

//Salvage Jumper

/obj/machinery/computer/shuttle/salvage
	req_access = list(access_salvage_captain)
	name = "Salvage Shuttle Console"
	desc = "Used to jump around the salvage yard and to dock at the main/salvage stations"
	shuttleId = "salvage"
	possible_destinations = "salvage_home;salvage_dock2;salvage_ss13;salvage_p_SW;salvage_p_NE;salvage_out_se;salvage_out_sou"