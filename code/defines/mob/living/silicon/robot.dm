/mob/living/silicon/robot
	name = "Robot"
	icon = 'robots.dmi'//
	icon_state = "robot"
	health = 300

#define BORGMESON 1
#define BORGTHERM 2
#define BORGXRAY  4

	var/sight_mode = 0

//Hud stuff

	var/obj/screen/cells = null
	var/obj/screen/inv1 = null
	var/obj/screen/inv2 = null
	var/obj/screen/inv3 = null

//3 Modules can be activated at any one time.
	var/obj/item/weapon/robot_module/module = null
	var/module_active = null
	var/module_state_1 = null
	var/module_state_2 = null
	var/module_state_3 = null
	var/module_state_4 = null //Left hand.
	var/module_state_5 = null //Right hand.

	//var/obj/item/l_hand = null//Living
	//var/obj/item/r_hand = null//Living

	var/obj/item/device/radio/radio = null
	var/mob/living/silicon/ai/connected_ai = null
	var/obj/item/weapon/cell/cell = null
	var/obj/machinery/camera/camera = null

	var/obj/item/device/mmi/mmi = null

	var/opened = 0
	var/emagged = 0
	var/wiresexposed = 0
	var/locked = 1
	//var/list/req_access = list(access_robotics)
	var/list/req_access = list(access_security, access_brig, access_armory, access_forensics_lockers, access_court,
	            access_medical, access_medlab, access_morgue, access_rd,
	            access_tox, access_tox_storage, access_chemistry, access_engine, access_engine_equip, access_maint_tunnels,
	            access_external_airlocks, access_emergency_storage, access_change_ids, access_ai_upload,
	            access_teleporter, access_eva, access_heads, access_captain, access_all_personal_lockers,
	            access_tech_storage, access_chapel_office, access_atmospherics, access_kitchen,
	            access_bar, access_janitor, access_crematorium, access_robotics, access_cargo, access_cargo_bot, access_construction,
	            access_hydroponics, access_library, access_manufacturing, access_lawyer, access_virology, access_cmo, access_qm, access_clown, access_mime, access_surgery,
	            access_theatre, access_research, access_mining, access_mailsorting, access_mint_vault, access_mint,
	            access_heads_vault, access_mining_station, access_xenobiology, access_ce, access_hop, access_hos, access_RC_announce)
	//var/list/laws = list()
	var/alarms = list("Motion"=list(), "Fire"=list(), "Atmosphere"=list(), "Power"=list())
	var/viewalerts = 0
	var/modtype = null
	var/lower_mod = 0
	var/jetpack = 0
	var/datum/effects/system/ion_trail_follow/ion_trail = null
	var/datum/effects/system/spark_spread/spark_system//So they can initialize sparks whenever/N
	var/jeton = 0
	var/borgwires = 15
	var/killswitch = 0
	var/killswitch_time = 60
	var/weapon_lock = 0
	var/weaponlock_time = 120
	var/lawupdate = 1 //Cyborgs will sync their laws with their AI by default
	var/lockcharge //Used when locking down a borg to preserve cell charge
