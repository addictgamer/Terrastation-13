var/global/datum/controller/game_controller/master_controller //Set in world.New()
var/global/controllernum = "no"

datum/controller/game_controller
	var/processing = 1

	proc
		setup()
		setup_objects()
		process()

	setup()
		if(master_controller && (master_controller != src))
			del(src)
			return
			//There can be only one master.

		if(!air_master)
			air_master = new /datum/controller/air_system()
			air_master.setup()

		world.tick_lag = 0.9

		setup_objects()

		setupgenetics()

		//setupcorpses() Not used any more.
		syndicate_code_phrase = generate_code_phrase()//Sets up code phrase for traitors, for the round.
		syndicate_code_response = generate_code_phrase()

		emergency_shuttle = new /datum/shuttle_controller/emergency_shuttle()

		if(!ticker)
			ticker = new /datum/controller/gameticker()

		/*for(var/client/c in world)
			if(!c.playing_lobby_music)
				c.music = sound('lobby3.mid')
				c << sound(c.music,1)
				c.playing_lobby_music = 1
				world << "Playing lobby music. (from master controller startup)"*/

		spawn
			ticker.pregame()

	setup_objects()

		//if(ticker.current_state == GAME_STATE_PREGAME || ticker.current_state == GAME_STATE_SETTING_UP)
		/*for(var/client/c in world)
			if(!c.playing_lobby_music)
				c.music = sound('lobby3.mid')
				c << sound(c.music,1)
				c.playing_lobby_music = 1
				world << "Playing lobby music. (from master controller)"*/
		world << "\red \b Initializing objects"
		sleep(-1)

		for(var/obj/object in world)
			object.initialize()



		//if(ticker.current_state == GAME_STATE_PREGAME || ticker.current_state == GAME_STATE_SETTING_UP)
		/*for(var/client/c in world)
			if(!c.playing_lobby_music)
				c.music = sound('lobby3.mid')
				c << sound(c.music,1)
				c.playing_lobby_music = 1
				world << "Playing lobby music. (from master controller)"*/

		world << "\red \b Initializing pipe networks"
		sleep(-1)



		//if(ticker.current_state == GAME_STATE_PREGAME || ticker.current_state == GAME_STATE_SETTING_UP)
		/*for(var/client/c in world)
			if(!c.playing_lobby_music)
				c.music = sound('lobby3.mid')
				c << sound(c.music,1)
				c.playing_lobby_music = 1
				world << "Playing lobby music. (from master controller)"*/

		for(var/obj/machinery/atmospherics/machine in world)
			machine.build_network()



		//if(ticker.current_state == GAME_STATE_PREGAME || ticker.current_state == GAME_STATE_SETTING_UP)
		/*for(var/client/c in world)
			if(!c.playing_lobby_music)
				c.music = sound('lobby3.mid')
				c << sound(c.music,1)
				c.playing_lobby_music = 1
				world << "Playing lobby music. (from master controller)"*/

		world << "\red \b Initializing atmos machinery."
		sleep(-1)
		for(var/obj/machinery/atmospherics/unary/vent_pump/T in world)
			T.broadcast_status()
		for(var/obj/machinery/atmospherics/unary/vent_scrubber/T in world)
			T.broadcast_status()

		/*world << "\red \b Initializing atmos machinery"
		sleep(-1)

		find_air_alarms()*/



		//if(ticker.current_state == GAME_STATE_PREGAME || ticker.current_state == GAME_STATE_SETTING_UP)
		/*for(var/client/c in world)
			if(!c.playing_lobby_music)
				c.music = sound('lobby3.mid')
				c << sound(c.music,1)
				c.playing_lobby_music = 1
				world << "Playing lobby music. (from master controller)"*/

		world << "\red \b Initializations complete."


	process()

		if(!processing)
			return 0
		//world << "Processing"

		/*if(ticker.current_state == GAME_STATE_PREGAME || ticker.current_state == GAME_STATE_SETTING_UP)
			//world << "GAME_STATE_PREGAME || GAME_STATE_SETTING_UP"
			var/num = 0
			for(var/client/c in world)
				//world << "num = [num]"
				if(!c.playing_lobby_music)
					c.music = sound('lobby3.mid')
					c << sound(c.music,1)
					c.playing_lobby_music = 1
					world << "Playing lobby music. (from master controller process)"
				num++*/

		controllernum = "yes"
		spawn (100) controllernum = "no"

		var/start_time = world.timeofday

		air_master.process()

		sleep(1)

		sun.calc_position()

		sleep(-1)

		for(var/mob/M in world)
			M.Life()

		sleep(-1)

		for(var/datum/disease/D in active_diseases)
			D.process()

		for(var/obj/machinery/machine in machines)
			if(machine)
				machine.process()
				if(machine && machine.use_power)
					machine.auto_use_power()


		sleep(-1)
		sleep(1)

		for(var/obj/object in processing_objects)
//			spawn(0)Still need to test the spawn ticker
			object.process()

		for(var/datum/pipe_network/network in pipe_networks)
			network.process()

		for(var/datum/powernet/P in powernets)
			P.reset()

		//for(var/obj/item in processing_items) //Update all items that need updating.


		sleep(-1)

		ticker.process()

		sleep(world.timeofday+10-start_time)

		spawn process()

		if(!already_processing_trade)
			already_processing_trade = 1
			tradeshuttleprocess()



		return 1



/proc/tradeshuttleprocess()

	//So here's what's up. This thing sends the shuttle automatically.

	//world << "Processing Trade Shuttle"

	/*if(trade_shuttle_moving)//If the trade shuttle is moving.
		world << "Trade shuttle alreayd moving."
		return

	if(trade_shuttle_move_timerleft <= 0) //If finished timing...
		world << "Trade shuttle now moving!"

		trade_process()

		return

	world << "Trade shuttle docked somewhere..."

	trade_shuttle_move_timerleft-- *///Deincrement the timer.

	trade_process()
	already_processing_trade = 0
	return