/*
You need to have 7 z-levels of the same size dimensions.
z-level order is important, the order you put them in inside this file will determine what z level number they are assigned ingame.
Names of z-level do not matter, but order does greatly, for instances such as checking alive status of revheads on z1
current as of 2015/05/11
z1 = station
z2 = centcomm
z3 = telecommunications center
z4 = engineering ship
z5 = mining
z6 = russian derelict
z7 = empty
z8 = syndicate station
*/

#if !defined(MAP_FILE)

        #include "map_files\complex\complex.dmm"
        #include "map_files\complex\z2.dmm"
        #include "map_files\complex\z3.dmm"
        #include "map_files\complex\z4.dmm"
        #include "map_files\complex\z5.dmm"
        #include "map_files\complex\z6.dmm"
        #include "map_files\complex\z7.dmm"
        #include "map_files\complex\z8.dmm"

        #define MAP_FILE "complex.dmm"
        #define MAP_NAME "NSS Complex"

/area/quartermaster/garage
	name = "\improper Cargo Garage"
	icon_state = "quartoffice"

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring Complex.

#endif