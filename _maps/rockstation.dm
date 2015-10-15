/*
This is more or less copypasta from cyberiad except I assraped it and stuff so I guess it isn't anymore?
Blah blah blah >=7 z-levels blah blah blarg
Order is important, the order here means order ingame
Names irrelevant, order matters a shitload because revheads (n'stuff) might get fucked otherwise cuz game code looking at z1
current as of idunfukkenknoe
z1 = station
z2 = centcomm
z3 = telecommunications center
z4 = engineering ship*
z5 = mining
z6 = ruskie station and other spessdiver goodies
z7 = empty*
z8 = syndicate station*

*But high likelyhood ^that shit won't stay that way
*/

//This is for the next block of shit; only putting above it in case it doesn't like comments in its pingas (too lazy to test it)
//		#include "map_files\rockstation\(whatever Z is named goes here).dmm"

#if !defined(MAP_FILE)

		#include "map_files\rockstation\Rock2.dmm"
		#include "map_files\rockstation\z2.dmm"
        #include "map_files\rockstation\z3.dmm"
        #include "map_files\rockstation\z4.dmm"
        #include "map_files\rockstation\z5.dmm"
        #include "map_files\rockstation\z6.dmm"
        #include "map_files\rockstation\z7.dmm"
        #include "map_files\rockstation\z8.dmm"

		#define MAP_FILE "rockstation.dmm"
        #define MAP_NAME "NSS Rock"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring Rock2.

#endif


//I'M ABOUT TO KILL SOME MOTHERFUCKERS