
#define ui_dropbutton "SOUTH-1,7"
#define ui_swapbutton "SOUTH-1,7"
#define ui_iclothing "SOUTH-1,2"
#define ui_oclothing "SOUTH,2"
//#define ui_headset "SOUTH,8"
#define ui_rhand "SOUTH,1"
#define ui_lhand "SOUTH,3"
#define ui_id "SOUTH-1,1"
#define ui_mask "SOUTH+1,1"
#define ui_back "SOUTH+1,3"
#define ui_storage1 "SOUTH-1,4"
#define ui_storage2 "SOUTH-1,5"
#define ui_sstore1 "SOUTH+1,4"
#define ui_hstore1 "SOUTH+1,5"
#define ui_resist "EAST+1,SOUTH-1"
#define ui_gloves "SOUTH,5"
#define ui_glasses "SOUTH,7"
#define ui_ears "SOUTH,6"
#define ui_head "SOUTH+1,2"
#define ui_shoes "SOUTH,4"
#define ui_belt "SOUTH-1,3"
#define ui_throw "SOUTH-1,8"
#define ui_oxygen "EAST+1, NORTH-4"
#define ui_toxin "EAST+1, NORTH-6"
#define ui_internal "EAST+1, NORTH-2"
#define ui_fire "EAST+1, NORTH-8"
#define ui_temp "EAST+1, NORTH-10"
#define ui_health "EAST+1, NORTH-11"
#define ui_nutrition "EAST+1, NORTH-12"
#define ui_pull "SOUTH-1,10"
#define ui_hand "SOUTH-1,6"
#define ui_sleep "EAST+1, NORTH-13"
#define ui_rest "EAST+1, NORTH-14"

#define ui_acti "SOUTH-1,12"
#define ui_movi "SOUTH-1,14"

#define ui_iarrowleft "SOUTH-1,11"
#define ui_iarrowright "SOUTH-1,13"

#define ui_inv1 "SOUTH-1,1"
#define ui_inv2 "SOUTH-1,2"
#define ui_inv3 "SOUTH-1,3"


///////////
////Hud////
///////////

/obj/hud
	name = "hud"
	unacidable = 1
	var/mob/mymob = null

	var/list/adding = null
	var/list/other = null
	var/list/intents = null
	var/list/mov_int = null
	var/list/mon_blo = null
	var/list/m_ints = null

	var/vimpaired = null

	var/obj/screen/druggy = null
	var/obj/screen/alien_view = null
	var/obj/screen/g_dither = null
	var/obj/screen/blurry = null
	var/obj/screen/action_intent
	var/obj/screen/move_intent
	var/obj/screen/station_explosion = null

	var/list/darkMask = null

	var/h_type = /obj/screen

	var/show_otherinventory = 1

obj/hud/New(var/type = 0)
	instantiate(type)
	..()
	return


/obj/hud/proc/other_update()

	if(!mymob) return
	if(show_otherinventory)
		if(mymob:shoes) mymob:shoes:screen_loc = ui_shoes
		if(mymob:gloves) mymob:gloves:screen_loc = ui_gloves
		if(mymob:ears) mymob:ears:screen_loc = ui_ears
		if(mymob:s_store) mymob:s_store:screen_loc = ui_sstore1
		if(mymob:glasses) mymob:glasses:screen_loc = ui_glasses
		if(mymob:h_store) mymob:h_store:screen_loc = ui_hstore1
	else
		if(istype(mymob, /mob/living/carbon/human))
			if(mymob:shoes) mymob:shoes:screen_loc = null
			if(mymob:gloves) mymob:gloves:screen_loc = null
			if(mymob:ears) mymob:ears:screen_loc = null
			if(mymob:s_store) mymob:s_store:screen_loc = null
			if(mymob:glasses) mymob:glasses:screen_loc = null
			if(mymob:h_store) mymob:h_store:screen_loc = null

/obj/hud/proc/instantiate(var/type = 0)

	mymob = loc
	ASSERT(istype(mymob, /mob))

	if(ishuman(mymob))
		human_hud(mymob.UI) // Pass the player the UI style chosen in preferences

	else if(ismonkey(mymob))
		monkey_hud(mymob.UI)

	else if(isbrain(mymob))
		brain_hud(mymob.UI)

	else if(islarva(mymob))
		larva_hud()

	else if(isalien(mymob))
		alien_hud()

	else if(isAI(mymob))
		ai_hud()

	else if(isrobot(mymob))
		robot_hud()

//	else if(ishivebot(mymob))
//		hivebot_hud()

//	else if(ishivemainframe(mymob))
//		hive_mainframe_hud()

	else if(isobserver(mymob))
		ghost_hud()

	return

/////////////////
////Ghost Hud////
/////////////////

/obj/hud/proc/ghost_hud()
	station_explosion = new h_type( src )
	station_explosion.icon = 'station_explosion.dmi'
	station_explosion.icon_state = "start"
	station_explosion.layer = 20
	station_explosion.mouse_opacity = 0
	station_explosion.screen_loc = "1,3"
	return

/////////////////
////Alien Hud////
/////////////////
/obj/hud/proc/alien_hud()

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.g_dither.name = "Mask"
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.g_dither.mouse_opacity = 0

	src.alien_view = new src.h_type(src)
	src.alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.alien_view.name = "Alien"
	src.alien_view.icon_state = "alien"
	src.alien_view.layer = 18
	src.alien_view.mouse_opacity = 0

	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.blurry.name = "Blurry"
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	src.blurry.mouse_opacity = 0

	src.druggy = new src.h_type( src )
	src.druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.druggy.name = "Druggy"
	src.druggy.icon_state = "druggy"
	src.druggy.layer = 17
	src.druggy.mouse_opacity = 0

	// station explosion cinematic
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"

	var/obj/screen/using

	using = new src.h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = 'screen1_alien.dmi'
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

	using = new src.h_type( src )
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon = 'screen1_alien.dmi'
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using
	move_intent = using

	using = new src.h_type(src) //Right hud bar
	using.dir = SOUTH
	using.icon = 'screen1_alien.dmi'
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Lower hud bar
	using.dir = EAST
	using.icon = 'screen1_alien.dmi'
	using.screen_loc = "WEST,SOUTH-1 to EAST,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Corner Button
	using.dir = NORTHWEST
	using.icon = 'screen1_alien.dmi'
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowleft"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowright"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "drop"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "act_drop"
	using.screen_loc = ui_dropbutton
	using.layer = 19
	src.adding += using



//equippable shit
	//suit
	using = new src.h_type( src )
	using.name = "o_clothing"
	using.dir = SOUTH
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "equip"
	using.screen_loc = ui_iclothing
	using.layer = 19
	src.adding += using

	//r hand
	using = new src.h_type( src )
	using.name = "r_hand"
	using.dir = WEST
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "equip"
	using.screen_loc = ui_id
	using.layer = 19
	src.adding += using

	//l hand
	using = new src.h_type( src )
	using.name = "l_hand"
	using.dir = EAST
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "equip"
	using.screen_loc = ui_belt
	using.layer = 19
	src.adding += using

	//pocket 1
	using = new src.h_type( src )
	using.name = "storage1"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "pocket"
	using.screen_loc = ui_storage1
	using.layer = 19
	src.adding += using

	//pocket 2
	using = new src.h_type( src )
	using.name = "storage2"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "pocket"
	using.screen_loc = ui_storage2
	using.layer = 19
	src.adding += using

	//head
	using = new src.h_type( src )
	using.name = "head"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "hair"
	using.screen_loc = ui_oclothing
	using.layer = 19
	src.adding += using
//end of equippable shit

	using = new src.h_type( src )
	using.name = "resist"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "act_resist"
	using.screen_loc = ui_resist
	using.layer = 19
	src.adding += using



	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	mymob.throw_icon = new /obj/screen(null)
	mymob.throw_icon.icon = 'screen1_alien.dmi'
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = ui_throw

	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon = 'screen1_alien.dmi'
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

	mymob.toxin = new /obj/screen( null )
	mymob.toxin.icon = 'screen1_alien.dmi'
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin

	mymob.fire = new /obj/screen( null )
	mymob.fire.icon = 'screen1_alien.dmi'
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire

	mymob.healths = new /obj/screen( null )
	mymob.healths.icon = 'screen1_alien.dmi'
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon = 'screen1_alien.dmi'
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon = 'screen1_alien.dmi'
	mymob.blind.icon_state = "black"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon = 'screen1_alien.dmi'
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.hands = new /obj/screen( null )
	mymob.hands.icon = 'screen1_alien.dmi'
	mymob.hands.icon_state = "hand"
	mymob.hands.name = "hand"
	mymob.hands.screen_loc = ui_hand
	mymob.hands.dir = NORTH

	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon = 'screen1_alien.dmi'
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon = 'screen1_alien.dmi'
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest


	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'zone_sel.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.toxin, mymob.fire, mymob.hands, mymob.healths, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += src.adding + src.other

///////////////////////
////Alien Larva Hud////
///////////////////////

/obj/hud/proc/larva_hud()

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.g_dither.name = "Mask"
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.g_dither.mouse_opacity = 0

	src.alien_view = new src.h_type(src)
	src.alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.alien_view.name = "Alien"
	src.alien_view.icon_state = "alien"
	src.alien_view.layer = 18
	src.alien_view.mouse_opacity = 0

	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.blurry.name = "Blurry"
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	src.blurry.mouse_opacity = 0

	src.druggy = new src.h_type( src )
	src.druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.druggy.name = "Druggy"
	src.druggy.icon_state = "druggy"
	src.druggy.layer = 17
	src.druggy.mouse_opacity = 0

	// station explosion cinematic
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"

	var/obj/screen/using

	using = new src.h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = 'screen1_alien.dmi'
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

	using = new src.h_type( src )
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon = 'screen1_alien.dmi'
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using
	move_intent = using

	using = new src.h_type(src) //Right hud bar
	using.dir = SOUTH
	using.icon = 'screen1_alien.dmi'
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Lower hud bar
	using.dir = EAST
	using.icon = 'screen1_alien.dmi'
	using.screen_loc = "WEST,SOUTH-1 to EAST,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Corner Button
	using.dir = NORTHWEST
	using.icon = 'screen1_alien.dmi'
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowleft"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowright"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	src.adding += using


	using = new src.h_type( src )
	using.name = "resist"
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "act_resist"
	using.screen_loc = ui_resist
	using.layer = 19
	src.adding += using



	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = 'screen1_alien.dmi'
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon = 'screen1_alien.dmi'
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

	mymob.toxin = new /obj/screen( null )
	mymob.toxin.icon = 'screen1_alien.dmi'
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin


	mymob.fire = new /obj/screen( null )
	mymob.fire.icon = 'screen1_alien.dmi'
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire


	mymob.healths = new /obj/screen( null )
	mymob.healths.icon = 'screen1_alien.dmi'
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon = 'screen1_alien.dmi'
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon = 'screen1_alien.dmi'
	mymob.blind.icon_state = "black"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon = 'screen1_alien.dmi'
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17


	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon = 'screen1_alien.dmi'
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon = 'screen1_alien.dmi'
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest


	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'zone_sel.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	mymob.client.screen += list( mymob.zone_sel, mymob.oxygen, mymob.toxin, mymob.fire, mymob.healths, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += src.adding + src.other

/////////////////
////Brain Hud////
/////////////////

/obj/hud/proc/brain_hud(var/ui_style='screen1_old.dmi')
	station_explosion = new h_type( src )
	station_explosion.icon = 'station_explosion.dmi'
	station_explosion.icon_state = "start"
	station_explosion.layer = 20
	station_explosion.mouse_opacity = 0
	station_explosion.screen_loc = "1,3"

	blurry = new h_type( src )
	blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	blurry.name = "Blurry"
	blurry.icon = ui_style
	blurry.icon_state = "blurry"
	blurry.layer = 17
	blurry.mouse_opacity = 0

	druggy = new h_type( src )
	druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	druggy.name = "Druggy"
	druggy.icon = ui_style
	druggy.icon_state = "druggy"
	druggy.layer = 17
	druggy.mouse_opacity = 0

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon = ui_style
	mymob.blind.icon_state = "black"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0

/////////////////
////Human Hud////
/////////////////

/obj/hud/proc/human_hud(var/ui_style='screen1_old.dmi')

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.g_dither.name = "Mask"
	src.g_dither.icon = ui_style
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.g_dither.mouse_opacity = 0

	src.alien_view = new src.h_type(src)
	src.alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.alien_view.name = "Alien"
	src.alien_view.icon = ui_style
	src.alien_view.icon_state = "alien"
	src.alien_view.layer = 18
	src.alien_view.mouse_opacity = 0

	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.blurry.name = "Blurry"
	src.blurry.icon = ui_style
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	src.blurry.mouse_opacity = 0

	src.druggy = new src.h_type( src )
	src.druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.druggy.name = "Druggy"
	src.druggy.icon = ui_style
	src.druggy.icon_state = "druggy"
	src.druggy.layer = 17
	src.druggy.mouse_opacity = 0

	// station explosion cinematic
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"

	var/obj/screen/using

	using = new src.h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

	using = new src.h_type( src )
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using
	move_intent = using

	using = new src.h_type(src) //Right hud bar
	using.dir = SOUTH
	using.icon = ui_style
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Lower hud bar
	using.dir = EAST
	using.icon = ui_style
	using.screen_loc = "WEST,SOUTH-1 to EAST,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Corner Button
	using.dir = NORTHWEST
	using.icon = ui_style
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowleft"
	using.icon = ui_style
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowright"
	using.icon = ui_style
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "drop"
	using.icon = ui_style
	using.icon_state = "act_drop"
	using.screen_loc = ui_dropbutton
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "i_clothing"
	using.dir = SOUTH
	using.icon = ui_style
	using.icon_state = "center"
	using.screen_loc = ui_iclothing
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "o_clothing"
	using.dir = SOUTH
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_oclothing
	using.layer = 19
	src.adding += using

/*	using = new src.h_type( src )
	using.name = "headset"
	using.dir = SOUTHEAST
	using.icon_state = "equip"
	using.screen_loc = ui_headset
	using.layer = 19
	if(istype(mymob,/mob/living/carbon/monkey)) using.overlays += blocked
	src.other += using*/

	using = new src.h_type( src )
	using.name = "r_hand"
	using.dir = WEST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_rhand
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "l_hand"
	using.dir = EAST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_lhand
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "id"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_id
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "mask"
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_mask
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "back"
	using.dir = NORTHEAST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_back
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "storage1"
	using.icon = ui_style
	using.icon_state = "pocket"
	using.screen_loc = ui_storage1
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "storage2"
	using.icon = ui_style
	using.icon_state = "pocket"
	using.screen_loc = ui_storage2
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "suit storage"
	using.icon = ui_style
	using.icon_state = "belt"
	using.screen_loc = ui_sstore1
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "hat storage"
	using.icon = ui_style
	using.icon_state = "hair"
	using.screen_loc = ui_hstore1
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "resist"
	using.icon = ui_style
	using.icon_state = "act_resist"
	using.screen_loc = ui_resist
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "other"
	using.icon = ui_style
	using.icon_state = "other"
	using.screen_loc = ui_shoes
	using.layer = 20
	src.adding += using

/*
	using = new src.h_type( src )
	using.name = "intent"
	using.icon_state = "intent"
	using.screen_loc = "15,15"
	using.layer = 20
	src.adding += using

	using = new src.h_type( src )
	using.name = "m_intent"
	using.icon_state = "move"
	using.screen_loc = "15,14"
	using.layer = 20
	src.adding += using
*/

	using = new src.h_type( src )
	using.name = "gloves"
	using.icon = ui_style
	using.icon_state = "gloves"
	using.screen_loc = ui_gloves
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "eyes"
	using.icon = ui_style
	using.icon_state = "glasses"
	using.screen_loc = ui_glasses
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "ears"
	using.icon = ui_style
	using.icon_state = "ears"
	using.screen_loc = ui_ears
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "head"
	using.icon = ui_style
	using.icon_state = "hair"
	using.screen_loc = ui_head
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "shoes"
	using.icon = ui_style
	using.icon_state = "shoes"
	using.screen_loc = ui_shoes
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "belt"
	using.icon = ui_style
	using.icon_state = "belt"
	using.screen_loc = ui_belt
	using.layer = 19
	src.adding += using

/*
	using = new src.h_type( src )
	using.name = "grab"
	using.icon_state = "grab"
	using.screen_loc = "12:-11,15"
	using.layer = 19
	src.intents += using
	//ICONS
	using = new src.h_type( src )
	using.name = "hurt"
	using.icon_state = "harm"
	using.screen_loc = "15:-11,15"
	using.layer = 19
	src.intents += using
	src.m_ints += using

	using = new src.h_type( src )
	using.name = "disarm"
	using.icon_state = "disarm"
	using.screen_loc = "14:-10,15"
	using.layer = 19
	src.intents += using

	using = new src.h_type( src )
	using.name = "help"
	using.icon_state = "help"
	using.screen_loc = "13:-10,15"
	using.layer = 19
	src.intents += using
	src.m_ints += using

	using = new src.h_type( src )
	using.name = "face"
	using.icon_state = "facing"
	using.screen_loc = "15:-11,14"
	using.layer = 19
	src.mov_int += using

	using = new src.h_type( src )
	using.name = "walk"
	using.icon_state = "walking"
	using.screen_loc = "14:-11,14"
	using.layer = 19
	src.mov_int += using

	using = new src.h_type( src )
	using.name = "run"
	using.icon_state = "running"
	using.screen_loc = "13:-11,14"
	using.layer = 19
	src.mov_int += using
*/

	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "3,3 to 5,13"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "5,3 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,13"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "11,3 to 13,13"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "black"
	using.screen_loc = "1,1 to 15,2"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "black"
	using.screen_loc = "1,3 to 2,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "black"
	using.screen_loc = "14,3 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "black"
	using.screen_loc = "3,14 to 13,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.darkMask += using

	mymob.throw_icon = new /obj/screen(null)
	mymob.throw_icon.icon = ui_style
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = ui_throw

	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon = ui_style
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

/*
	mymob.i_select = new /obj/screen( null )
	mymob.i_select.icon_state = "selector"
	mymob.i_select.name = "intent"
	mymob.i_select.screen_loc = "16:-11,15"

	mymob.m_select = new /obj/screen( null )
	mymob.m_select.icon_state = "selector"
	mymob.m_select.name = "moving"
	mymob.m_select.screen_loc = "16:-11,14"
*/

	mymob.toxin = new /obj/screen( null )
	mymob.toxin.icon = ui_style
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin

	mymob.internals = new /obj/screen( null )
	mymob.internals.icon = ui_style
	mymob.internals.icon_state = "internal0"
	mymob.internals.name = "internal"
	mymob.internals.screen_loc = ui_internal

	mymob.fire = new /obj/screen( null )
	mymob.fire.icon = ui_style
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire

	mymob.bodytemp = new /obj/screen( null )
	mymob.bodytemp.icon = ui_style
	mymob.bodytemp.icon_state = "temp1"
	mymob.bodytemp.name = "body temperature"
	mymob.bodytemp.screen_loc = ui_temp

	mymob.healths = new /obj/screen( null )
	mymob.healths.icon = ui_style
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.nutrition_icon = new /obj/screen( null )
	mymob.nutrition_icon.icon = ui_style
	mymob.nutrition_icon.icon_state = "nutrition0"
	mymob.nutrition_icon.name = "nutrition"
	mymob.nutrition_icon.screen_loc = ui_nutrition

	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon = ui_style
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon = ui_style
	mymob.blind.icon_state = "black"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon = ui_style
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.hands = new /obj/screen( null )
	mymob.hands.icon = ui_style
	mymob.hands.icon_state = "hand"
	mymob.hands.name = "hand"
	mymob.hands.screen_loc = ui_hand
	mymob.hands.dir = NORTH

	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon = ui_style
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon = ui_style
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest

	/*/Monkey blockers

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_ears
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_belt
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_shoes
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_storage2
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_glasses
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_gloves
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_storage1
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_headset
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_oclothing
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_iclothing
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_id
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_head
	using.layer = 20
	src.mon_blo += using
//Monkey blockers
*/

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'zone_sel.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	//, mymob.i_select, mymob.m_select
	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.toxin, mymob.bodytemp, mymob.internals, mymob.fire, mymob.hands, mymob.healths, mymob.nutrition_icon, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += src.adding + src.other

	//if(istype(mymob,/mob/living/carbon/monkey)) mymob.client.screen += src.mon_blo

	return

/*
	using = new src.h_type( src )
	using.dir = WEST
	using.screen_loc = "1,3 to 2,3"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = NORTHEAST
	using.screen_loc = "3,3"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = NORTH
	using.screen_loc = "3,2"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = SOUTHEAST
	using.screen_loc = "3,1"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = SOUTHWEST
	using.screen_loc = "1,1 to 2,2"
	using.layer = 19
	src.adding += using
*/

///////////////////
////Metroid Hud////
///////////////////

/mob/living/carbon/metroid/proc/regular_hud_updates()
	if(client)
		for(var/hud in client.screen)
			del(hud)

/*
/obj/hud/proc/metroid_hud()

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.g_dither.name = "Mask"
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.g_dither.mouse_opacity = 0

	src.alien_view = new src.h_type(src)
	src.alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.alien_view.name = "Alien"
	src.alien_view.icon_state = "alien"
	src.alien_view.layer = 18
	src.alien_view.mouse_opacity = 0

	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.blurry.name = "Blurry"
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	src.blurry.mouse_opacity = 0

	src.druggy = new src.h_type( src )
	src.druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.druggy.name = "Druggy"
	src.druggy.icon_state = "druggy"
	src.druggy.layer = 17
	src.druggy.mouse_opacity = 0

	// station explosion cinematic
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"
*/

//////////////////
////Monkey Hud////
//////////////////

/obj/hud/proc/monkey_hud(var/ui_style='screen1_old.dmi')

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	var/icon/blocked = icon(ui_style,"blocked")

	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.g_dither.name = "Mask"
	src.g_dither.icon = ui_style
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.g_dither.mouse_opacity = 0

	src.alien_view = new src.h_type(src)
	src.alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.alien_view.name = "Alien"
	src.alien_view.icon = ui_style
	src.alien_view.icon_state = "alien"
	src.alien_view.layer = 18
	src.alien_view.mouse_opacity = 0

	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.blurry.name = "Blurry"
	src.blurry.icon = ui_style
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	src.blurry.mouse_opacity = 0

	src.druggy = new src.h_type( src )
	src.druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.druggy.name = "Druggy"
	src.druggy.icon = ui_style
	src.druggy.icon_state = "druggy"
	src.druggy.layer = 17
	src.druggy.mouse_opacity = 0

	// station explosion cinematic
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"

	var/obj/screen/using

	using = new src.h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

	using = new src.h_type( src )
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using
	move_intent = using

	using = new src.h_type(src) //Right hud bar
	using.dir = SOUTH
	using.icon = ui_style
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Lower hud bar
	using.dir = EAST
	using.icon = ui_style
	using.screen_loc = "WEST,SOUTH-1 to EAST,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Corner Button
	using.dir = NORTHWEST
	using.icon = ui_style
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowleft"
	using.icon = ui_style
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowright"
	using.icon = ui_style
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "drop"
	using.icon = ui_style
	using.icon_state = "act_drop"
	using.screen_loc = ui_dropbutton
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "i_clothing"
	using.dir = SOUTH
	using.icon = ui_style
	using.icon_state = "center"
	using.screen_loc = ui_iclothing
	using.layer = 19
	using.overlays += blocked
	src.adding += using

	using = new src.h_type( src )
	using.name = "o_clothing"
	using.dir = SOUTH
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_oclothing
	using.layer = 19
	using.overlays += blocked
	src.adding += using

/*	using = new src.h_type( src )
	using.name = "headset"
	using.dir = SOUTHEAST
	using.icon_state = "equip"
	using.screen_loc = ui_headset
	using.layer = 19
	if(istype(mymob,/mob/living/carbon/monkey)) using.overlays += blocked
	src.other += using*/

	using = new src.h_type( src )
	using.name = "r_hand"
	using.dir = WEST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_rhand
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "l_hand"
	using.dir = EAST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_lhand
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "id"
	using.dir = SOUTHWEST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_id
	using.layer = 19
	using.overlays += blocked
	src.adding += using

	using = new src.h_type( src )
	using.name = "mask"
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_mask
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "back"
	using.dir = NORTHEAST
	using.icon = ui_style
	using.icon_state = "equip"
	using.screen_loc = ui_back
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "storage1"
	using.icon = ui_style
	using.icon_state = "pocket"
	using.screen_loc = ui_storage1
	using.layer = 19
	using.overlays += blocked
	src.adding += using

	using = new src.h_type( src )
	using.name = "storage2"
	using.icon = ui_style
	using.icon_state = "pocket"
	using.screen_loc = ui_storage2
	using.layer = 19
	using.overlays += blocked
	src.adding += using

	using = new src.h_type( src )
	using.name = "resist"
	using.icon = ui_style
	using.icon_state = "act_resist"
	using.screen_loc = ui_resist
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "other"
	using.icon = ui_style
	using.icon_state = "other"
	using.screen_loc = ui_shoes
	using.layer = 20
	src.adding += using

	using = new src.h_type( src )
	using.name = "gloves"
	using.icon = ui_style
	using.icon_state = "gloves"
	using.screen_loc = ui_gloves
	using.layer = 19
	using.overlays += blocked
	src.other += using

	using = new src.h_type( src )
	using.name = "eyes"
	using.icon = ui_style
	using.icon_state = "glasses"
	using.screen_loc = ui_glasses
	using.layer = 19
	using.overlays += blocked
	src.other += using

	using = new src.h_type( src )
	using.name = "ears"
	using.icon = ui_style
	using.icon_state = "ears"
	using.screen_loc = ui_ears
	using.layer = 19
	using.overlays += blocked
	src.other += using

	using = new src.h_type( src )
	using.name = "head"
	using.icon = ui_style
	using.icon_state = "hair"
	using.screen_loc = ui_head
	using.layer = 19
	using.overlays += blocked
	src.adding += using

	using = new src.h_type( src )
	using.name = "shoes"
	using.icon = ui_style
	using.icon_state = "shoes"
	using.screen_loc = ui_shoes
	using.layer = 19
	using.overlays += blocked
	src.other += using

	using = new src.h_type( src )
	using.name = "belt"
	using.icon = ui_style
	using.icon_state = "belt"
	using.screen_loc = ui_belt
	using.layer = 19
	using.overlays += blocked
	src.adding += using

/*
	using = new src.h_type( src )
	using.name = "grab"
	using.icon_state = "grab"
	using.screen_loc = "12:-11,15"
	using.layer = 19
	src.intents += using
	//ICONS
	using = new src.h_type( src )
	using.name = "hurt"
	using.icon_state = "harm"
	using.screen_loc = "15:-11,15"
	using.layer = 19
	src.intents += using
	src.m_ints += using

	using = new src.h_type( src )
	using.name = "disarm"
	using.icon_state = "disarm"
	using.screen_loc = "14:-10,15"
	using.layer = 19
	src.intents += using

	using = new src.h_type( src )
	using.name = "help"
	using.icon_state = "help"
	using.screen_loc = "13:-10,15"
	using.layer = 19
	src.intents += using
	src.m_ints += using

	using = new src.h_type( src )
	using.name = "face"
	using.icon_state = "facing"
	using.screen_loc = "15:-11,14"
	using.layer = 19
	src.mov_int += using

	using = new src.h_type( src )
	using.name = "walk"
	using.icon_state = "walking"
	using.screen_loc = "14:-11,14"
	using.layer = 19
	src.mov_int += using

	using = new src.h_type( src )
	using.name = "run"
	using.icon_state = "running"
	using.screen_loc = "13:-11,14"
	using.layer = 19
	src.mov_int += using
*/

	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon = ui_style
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	mymob.throw_icon = new /obj/screen(null)
	mymob.throw_icon.icon = ui_style
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = ui_throw

	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon = ui_style
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

/*
	mymob.i_select = new /obj/screen( null )
	mymob.i_select.icon_state = "selector"
	mymob.i_select.name = "intent"
	mymob.i_select.screen_loc = "16:-11,15"

	mymob.m_select = new /obj/screen( null )
	mymob.m_select.icon_state = "selector"
	mymob.m_select.name = "moving"
	mymob.m_select.screen_loc = "16:-11,14"
*/

	mymob.toxin = new /obj/screen( null )
	mymob.toxin.icon = ui_style
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin

	mymob.internals = new /obj/screen( null )
	mymob.internals.icon = ui_style
	mymob.internals.icon_state = "internal0"
	mymob.internals.name = "internal"
	mymob.internals.screen_loc = ui_internal

	mymob.fire = new /obj/screen( null )
	mymob.fire.icon = ui_style
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire

	mymob.bodytemp = new /obj/screen( null )
	mymob.bodytemp.icon = ui_style
	mymob.bodytemp.icon_state = "temp1"
	mymob.bodytemp.name = "body temperature"
	mymob.bodytemp.screen_loc = ui_temp

	mymob.healths = new /obj/screen( null )
	mymob.healths.icon = ui_style
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon = ui_style
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon = ui_style
	mymob.blind.icon_state = "black"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon = ui_style
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.hands = new /obj/screen( null )
	mymob.hands.icon = ui_style
	mymob.hands.icon_state = "hand"
	mymob.hands.name = "hand"
	mymob.hands.screen_loc = ui_hand
	mymob.hands.dir = NORTH

	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon = ui_style
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon = ui_style
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest

	/*/Monkey blockers

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_ears
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_belt
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_shoes
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_storage2
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_glasses
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_gloves
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_storage1
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_headset
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_oclothing
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_iclothing
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_id
	using.layer = 20
	src.mon_blo += using

	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "blocked"
	using.screen_loc = ui_head
	using.layer = 20
	src.mon_blo += using
//Monkey blockers
*/

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'zone_sel.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	//, mymob.i_select, mymob.m_select
	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.toxin, mymob.bodytemp, mymob.internals, mymob.fire, mymob.hands, mymob.healths, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += src.adding + src.other

	//if(istype(mymob,/mob/living/carbon/monkey)) mymob.client.screen += src.mon_blo

	return

/*
	using = new src.h_type( src )
	using.dir = WEST
	using.screen_loc = "1,3 to 2,3"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = NORTHEAST
	using.screen_loc = "3,3"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = NORTH
	using.screen_loc = "3,2"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = SOUTHEAST
	using.screen_loc = "3,1"
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.dir = SOUTHWEST
	using.screen_loc = "1,1 to 2,2"
	using.layer = 19
	src.adding += using
*/

//////////////
////AI Hud////
//////////////

/obj/hud/proc/ai_hud()

	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"

	return

/////////////////
////Robot Hud////
/////////////////

/obj/hud/proc/robot_hud()

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.g_dither.name = "Mask"
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.g_dither.mouse_opacity = 0
//
	src.alien_view = new src.h_type(src)
	src.alien_view.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.alien_view.name = "Alien"
	src.alien_view.icon_state = "alien"
	src.alien_view.layer = 18
	src.alien_view.mouse_opacity = 0

	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.blurry.name = "Blurry"
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	src.blurry.mouse_opacity = 0

	src.druggy = new src.h_type( src )
	src.druggy.screen_loc = "WEST,SOUTH to EAST,NORTH"
	src.druggy.name = "Druggy"
	src.druggy.icon_state = "druggy"
	src.druggy.layer = 17
	src.druggy.mouse_opacity = 0

	// station explosion cinematic
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"

	var/obj/screen/using


//Radio
	using = new src.h_type( src )
	using.name = "radio"
	using.dir = SOUTHWEST
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "radio"
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using

//Generic overlays

	using = new src.h_type(src) //Right hud bar
	using.dir = SOUTH
	using.icon = 'screen1_robot.dmi'
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Lower hud bar
	using.dir = EAST
	using.icon = 'screen1_robot.dmi'
	using.screen_loc = "WEST,SOUTH-1 to EAST,SOUTH-1"
	using.layer = 19
	src.adding += using

	using = new src.h_type(src) //Corner Button
	using.dir = NORTHWEST
	using.icon = 'screen1_robot.dmi'
	using.screen_loc = "EAST+1,SOUTH-1"
	using.layer = 19
	src.adding += using


//Module select

	using = new src.h_type( src )
	using.name = "module1"
	using.dir = SOUTHWEST
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "inv1"
	using.screen_loc = ui_inv1
	using.layer = 20
	src.adding += using
	mymob:inv1 = using

	using = new src.h_type( src )
	using.name = "module2"
	using.dir = SOUTHWEST
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "inv2"
	using.screen_loc = ui_inv2
	using.layer = 20
	src.adding += using
	mymob:inv2 = using

	using = new src.h_type( src )
	using.name = "module3"
	using.dir = SOUTHWEST
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "inv3"
	using.screen_loc = ui_inv3
	using.layer = 20
	src.adding += using
	mymob:inv3 = using

//End of module select

//Intent
	using = new src.h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon = 'screen1_robot.dmi'
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

	using = new src.h_type( src )
	using.name = "arrowleft"
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowright"
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	src.adding += using
//End of Intent

//Cell
	mymob:cells = new /obj/screen( null )
	mymob:cells.icon = 'screen1_robot.dmi'
	mymob:cells.icon_state = "charge-empty"
	mymob:cells.name = "cell"
	mymob:cells.screen_loc = ui_toxin

//Health
	mymob.healths = new /obj/screen( null )
	mymob.healths.icon = 'screen1_robot.dmi'
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

//Installed Module
	mymob.hands = new /obj/screen( null )
	mymob.hands.icon = 'screen1_robot.dmi'
	mymob.hands.icon_state = "nomod"
	mymob.hands.name = "module"
	mymob.hands.screen_loc = ui_dropbutton

//Module Panel
	using = new src.h_type( src )
	using.name = "panel"
	using.icon = 'screen1_robot.dmi'
	using.icon_state = "panel"
	using.screen_loc = ui_throw
	using.layer = 19
	src.adding += using

//Store
	mymob.throw_icon = new /obj/screen(null)
	mymob.throw_icon.icon = 'screen1_robot.dmi'
	mymob.throw_icon.icon_state = "store"
	mymob.throw_icon.name = "store"
	mymob.throw_icon.screen_loc = ui_hand

//Temp
	mymob.bodytemp = new /obj/screen( null )
	mymob.bodytemp.icon_state = "temp0"
	mymob.bodytemp.name = "body temperature"
	mymob.bodytemp.screen_loc = ui_temp


	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon = 'screen1_robot.dmi'
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

	mymob.fire = new /obj/screen( null )
	mymob.fire.icon = 'screen1_robot.dmi'
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire



	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon = 'screen1_robot.dmi'
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon = 'screen1_robot.dmi'
	mymob.blind.icon_state = "black"
	mymob.blind.name = " "
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 0

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon = 'screen1_robot.dmi'
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon = 'screen1_robot.dmi'
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon = 'screen1_robot.dmi'
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest


	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'zone_sel.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.fire, mymob.hands, mymob.healths, mymob:cells, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += src.adding + src.other

	return

///////////////////////
////Not-playing Hud////
///////////////////////

/obj/hud/proc/unplayer_hud()
	src.station_explosion = new src.h_type( src )
	src.station_explosion.icon = 'station_explosion.dmi'
	src.station_explosion.icon_state = "start"
	src.station_explosion.layer = 20
	src.station_explosion.mouse_opacity = 0
	src.station_explosion.screen_loc = "1,3"
	return

///////////////
////pAI Hud////
///////////////

// Not sure why it's like this, but better here than anywhere else! -Tauka Usanake

/mob/living/silicon/pai/proc/regular_hud_updates()
	if(client)
		for(var/image/hud in client.images)
			if(copytext(hud.icon_state,1,4) == "hud")
				del(hud)

/mob/living/silicon/pai/proc/securityHUD()
	if(client)
		var/icon/tempHud = 'hud.dmi'
		var/turf/T = get_turf_or_move(src.loc)
		for(var/mob/living/carbon/human/perp in view(T))
			if(perp.wear_id)
				client.images += image(tempHud,perp,"hud[ckey(perp:wear_id:GetJobName())]")
				var/perpname = "wot"
				if(istype(perp.wear_id,/obj/item/weapon/card/id))
					perpname = perp.wear_id:registered
				else if(istype(perp.wear_id,/obj/item/device/pda))
					var/obj/item/device/pda/tempPda = perp.wear_id
					perpname = tempPda.owner
				for (var/datum/data/record/E in data_core.general)
					if (E.fields["name"] == perpname)
						for (var/datum/data/record/R in data_core.security)
							if ((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "*Arrest*"))
								client.images += image(tempHud,perp,"hudwanted")
								break
							else if((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "Incarcerated"))
								client.images += image(tempHud,perp,"hudprisoner")
								break
			else
				client.images += image(tempHud,perp,"hudunknown")

/mob/living/silicon/pai/proc/medicalHUD()
	if(client)
		var/icon/tempHud = 'hud.dmi'
		var/turf/T = get_turf_or_move(src.loc)
		for(var/mob/living/carbon/human/patient in view(T))

			var/foundVirus = 0
			for(var/datum/disease/D in patient.viruses)
				if(!D.hidden[SCANNER])
					foundVirus = 1

			client.images += image(tempHud,patient,"hud[RoundHealth(patient.health)]")
			if(patient.stat == 2)
				client.images += image(tempHud,patient,"huddead")
			else if(patient.alien_egg_flag)
				client.images += image(tempHud,patient,"hudxeno")
			else if(foundVirus)
				client.images += image(tempHud,patient,"hudill")
			else
				client.images += image(tempHud,patient,"hudhealthy")

/mob/living/silicon/pai/proc/RoundHealth(health)
	switch(health)
		if(100 to INFINITY)
			return "health100"
		if(70 to 100)
			return "health80"
		if(50 to 70)
			return "health60"
		if(30 to 50)
			return "health40"
		if(20 to 30)
			return "health25"
		if(5 to 15)
			return "health10"
		if(1 to 5)
			return "health1"
		if(-99 to 0)
			return "health0"
		else
			return "health-100"
	return "0"
