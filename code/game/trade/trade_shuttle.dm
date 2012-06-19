//Config stuff
#define TRADE_DOCKZ 2          //Z-level of the Dock.
#define TRADE_STATIONZ 1       //Z-level of the Station.
#define TRADE_MOVETIME 1800	//Time to station is milliseconds.
#define TRADE_SHUTTLE_DOCK_WAITTIME 600 //Time it waits at the dock in milliseconds. So, one minute in this case.
#define TRADE_SHUTTLE_STATION_WAITTIME 1800 //Time it waits at the station in milliseconds. So, 3 minutes in this case.
#define TRADE_STATION_AREATYPE "/area/trade/station" //Type of the trade shuttle area for station
#define TRADE_DOCK_AREATYPE "/area/trade/dock"	//Type of the trade shuttle area for dock

var/trade_shuttle_moving = 0
var/trade_shuttle_at_station = 0
var/list/trade_shuttle_shoppinglist = new/list()
var/list/trade_shuttle_requestlist = new/list()
var/list/trade_shuttle_bringinglist = new/list()
var/trade_shuttle_can_send = 1
var/trade_shuttle_time = 0
var/trade_shuttle_timeleft = 0
var/trade_shuttle_move_timerleft = TRADE_SHUTTLE_DOCK_WAITTIME
var/ordernum=0
var/already_processing_trade = 0
var/trade_shuttle_money_inserted = 0

/* The trade shuttle.
It comes to the station and lets you buy stuff. You can request items, too. You buy with coins.
Random chance of pirate shuttle arriving instead.
*/

/area/trade/station //DO NOT TURN THE SD_LIGHTING STUFF ON FOR SHUTTLES. IT BREAKS THINGS. //The ship docking at our station.
	name = "trade shuttle"
	icon_state = "shuttle3"
	luminosity = 1
	sd_lighting = 0
	requires_power = 0

/area/trade/dock //DO NOT TURN THE SD_LIGHTING STUFF ON FOR SHUTTLES. IT BREAKS THINGS.
	name = "trade shuttle trade station dock"
	icon_state = "shuttle3"
	luminosity = 1
	sd_lighting = 0
	requires_power = 0

//TRADE PACKS MOVED TO /code/defines/obj/tradepacks.dm

/area/tradeshuttle/
	name = "Trade Shuttle"
	icon_state = "supply"
	requires_power = 0

/datum/trade_order
	var/datum/trade_packs/object = null
	var/orderedby = null
	var/comment = null

/obj/marker/trade_dropoff_marker
	icon_state = "X"
	icon = 'mark.dmi'
	name = "Trade Dropoff Marker"
	invisibility = 101
	anchored = 1
	opacity = 0

/proc/trade_process()
	//world << "trade_process()"

	if(trade_shuttle_moving) //If the trade shuttle is moving.
		//world << "if(trade_shuttle_moving)"
		while(trade_shuttle_time - world.timeofday > 0)
			//world << "Ticking trade_shuttle_time"
			var/datum/radio_frequency/frequency = radio_controller.return_frequency(1435)

			if(!frequency) return

			var/datum/signal/status_signal = new
			status_signal.source = src
			status_signal.transmission_method = 1
			status_signal.data["command"] = "trade"

			frequency.post_signal(src, status_signal)
			var/ticksleft = trade_shuttle_time - world.timeofday

			if(ticksleft > 1e5)
				trade_shuttle_time = world.timeofday + 10	// midnight rollover


			trade_shuttle_timeleft = round( ((ticksleft / 10)/60) )
			sleep(10)
		//world << "Done ticking trade shuttle time"
		trade_shuttle_moving = 0 //Arrived!
		send_trade_shuttle()
	else
		//world << "else"
		while(trade_shuttle_move_timerleft - world.timeofday > 0)
			//world << "Ticking trade_shuttle_move_timerleft"
			var/datum/radio_frequency/frequency = radio_controller.return_frequency(1435)

			if(!frequency) return

			var/datum/signal/status_signal = new
			status_signal.source = src
			status_signal.transmission_method = 1
			status_signal.data["command"] = "trade"
			var/ticksleft = trade_shuttle_move_timerleft - world.timeofday

			if(ticksleft > 1e5)
				trade_shuttle_move_timerleft = world.timeofday + 10	// midnight rollover


			trade_shuttle_move_timerleft = round( ((ticksleft / 10)/60) )
			sleep(10)
		//if(trade_shuttle_move_timerleft <= 0) //If finished timing...
		//	world << "Trade shuttle now moving!"

		//	move_trade_shuttle() //SEND THE TRADE SHUTTLE.
		//world << "Trade shuttle now moving!"

		move_trade_shuttle() //SEND THE TRADE SHUTTLE.

	already_processing_trade = 0 //This function just ended, so, it can be run again.


/proc/trade_can_move()
	if(trade_shuttle_moving) return 0

	var/shuttleat = trade_shuttle_at_station ? TRADE_STATION_AREATYPE : TRADE_DOCK_AREATYPE

	for(var/turf/T in get_area_turfs(shuttleat) )
		//if((locate(/mob/living) in T) && (!locate(/mob/living/carbon/monkey) in T)) return 0  //old check for living excluded monkeys
		if((locate(/mob/living) in T)) return 0
		if((locate(/obj/item/device/radio/beacon) in T)) return 0
		for(var/atom/ATM in T)
			if((locate(/mob/living) in ATM)) return 0
			if((locate(/obj/item/device/radio/beacon) in ATM)) return 0


/proc/process_trade_order()
	//var/shuttleat = trade_shuttle_at_station ? TRADE_STATION_AREATYPE : TRADE_DOCK_AREATYPE

	if(!trade_shuttle_shoppinglist.len) return //If no items were ordered...

	//var/list/blocked_orders_list = new/list() //Orders to ignore as to not to give thema  second chance at being brought with the shuttle.

	/* IGNORE THIS, OLD IDEA; In this idea, you order products from the trade shuttle, and it brings a random ammount of those items when it next comes, and then you purchase from the trade shuttle comp.
	//SO, HERE'S HOW THIS WORKS.
	//First, make a list of the unique orders.
	//Second, randomally choose how much of each order to bring.


	for(var/S in trade_shuttle_shoppinglist) //For every order in the shopping list.
		var/datum/trade_order/SO = S //The order.
		var/datum/trade_packs/SP = SO.object //The pack.

		//Check to make sure the object is not already in the list.
		var/found = 0 //Did not find the entry yet
		for(var/datum/trade_packs/PACK in trade_shuttle_bringinglist) //Loop through the bring list.
			if(PACK == SP) //If the current pack in the bring list is equal to the pack we want to add
				found = 1 //The order already exists!

		for(var/datum/trade_packs/PACK in blocked_orders_list) //Check to make sure this order is not in the blocked orders list!
			if(PACK == SP) //Check to see if the oack we're looking for is the same as this pack.
				found = 1 //Found the order! That means it's blocked!

		if(!found) //If this is a unique order and not blocked...
			var/ammount_to_bring = rand(5) //Randomally choose how much to bring
			if(ammount_to_bring <= 5) //If the amount to bring is 5 or less. Anything above five means the market ain't got any o this stuff.
				var/i = 0
				while(i < ammount_to_bring) //Loop through this to get the right ammount of orders added.
					trade_shuttle_bringinglist += SP //Add the order.
			else
				blocked_orders_list += SP //Add this order to the blocked orders as to not give the item a second chance at being added.

	return */

	var/shuttleat = supply_shuttle_at_station ? TRADE_STATION_AREATYPE : TRADE_DOCK_AREATYPE

	var/list/markers = new/list()

	for(var/turf/T in get_area_turfs(shuttleat))
		for(var/obj/marker/trade_dropoff_marker/D in T)
			markers += D

	for(var/S in trade_shuttle_shoppinglist) //For every order in the shopping list.
		var/datum/trade_order/SO = S //The order.
		var/datum/trade_packs/SP = SO.object //The pack.

		trade_shuttle_bringinglist += SP //Add the order.

		var/pickedloc = 0
		var/found = 0
		for(var/C in markers)
			found = 1
			pickedloc = get_turf(C)
		if (!found) pickedloc = get_turf(pick(markers))

		var/atom/A = new SP.containertype ( pickedloc )
		A.name = "[SP.containername] [SO.comment ? "([SO.comment])":"" ]"

		//supply manifest generation begin

		if(ordernum)
			ordernum++
		else
			ordernum = rand(500,5000) //pick a random number to start with

		var/obj/item/weapon/paper/manifest/slip = new /obj/item/weapon/paper/manifest (A)
		slip.info = ""
		slip.info +="<h3>[command_name()] Receipt</h3><hr><br>"
		slip.info +="Purchase #: [ordernum]<br>"
		slip.info +="Destination: [station_name]<br>"
		slip.info +="[supply_shuttle_shoppinglist.len] PACKAGES IN THIS SHIPMENT<br>"
		slip.info +="CONTENTS:<br><ul>"

		//spawn the stuff, finish generating the manifest while you're at it
		if(SP.access)
			A:req_access = new/list()
			A:req_access += text2num(SP.access)
		for(var/B in SP.contains)
			if(!B)	continue
			var/thepath = text2path(B)
			var/atom/B2 = new thepath (A)
			if(SP.amount && B2:amount) B2:amount = SP.amount
			slip.info += "<li>[B2.name]</li>" //add the item to the manifest

		//manifest finalisation
		slip.info += "</ul><br>"
		slip.info += "CHECK CONTENTS AND STAMP BELOW THE LINE TO CONFIRM RECEIPT OF GOODS<hr>"




/proc/send_trade_shuttle() //This function copies the trade shuttle to the destination.

	//world << "Trade shuttle arrived!"

	if (trade_shuttle_moving)
		//world << "Trade shuttle already moving! Aborting /proc/send_trade_shuttle()"
		return

	//if (!trade_can_move())
	//	world << "\red The trade shuttle can not transport station employees or homing beacons."
	//	return

	//world << "send_trade_shuttle()"

	var/shuttleat = trade_shuttle_at_station ? TRADE_STATION_AREATYPE : TRADE_DOCK_AREATYPE
	var/shuttleto = !trade_shuttle_at_station ? TRADE_STATION_AREATYPE : TRADE_DOCK_AREATYPE

	var/area/from = locate(shuttleat)
	var/area/dest = locate(shuttleto)

	if(!from || !dest) return

	from.move_contents_to(dest)
	trade_shuttle_at_station = !trade_shuttle_at_station

	if(trade_shuttle_at_station) //If the trade shuttle is already at the station...
		trade_shuttle_move_timerleft = world.timeofday + TRADE_SHUTTLE_STATION_WAITTIME //Set the move wait timer to the station's wait time.
		//world << "Trade shuttle gonna wait at station."
	else //Ok...
		trade_shuttle_move_timerleft = world.timeofday + TRADE_SHUTTLE_DOCK_WAITTIME //Set the move wait timer to the dock's wait time.
		//world << "Trade shuttle gonna wait at dock."

	//trade_shuttle_time = TRADE_MOVETIME //Assign the time it will take for the shuttle to arrive.

	//trade_shuttle_moving = 1 //Trade shuttle now moving.

	trade_shuttle_time = 0
	trade_shuttle_timeleft = 0

/proc/move_trade_shuttle() //This function tells the trade shuttle it is now in flight.

	//world << "Moving trade shuttle!"

	if (trade_shuttle_moving)
		//world << "Trade shuttle already moving! Aborting /proc/send_trade_shuttle()"
		return

	//world << "move_trade_shuttle()"

	trade_shuttle_time = world.timeofday + TRADE_MOVETIME //Assign the time it will take for the shuttle to arrive.
	//trade_shuttle_timeleft = trade_shuttle_time //Blarg this.

	trade_shuttle_move_timerleft = 0 //Reset this blarg.

	trade_shuttle_moving = 1 //Trade shuttle now moving.

