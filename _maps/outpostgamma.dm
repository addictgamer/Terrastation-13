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

        #include "map_files\outpostgamma\outpostgamma.dmm"
        #include "map_files\outpostgamma\z2.dmm"
        #include "map_files\outpostgamma\z3.dmm"
        #include "map_files\outpostgamma\z4.dmm"
        #include "map_files\outpostgamma\z5.dmm"
        #include "map_files\outpostgamma\z6.dmm"
        #include "map_files\outpostgamma\z7.dmm"
        #include "map_files\outpostgamma\z8.dmm"

        #define MAP_FILE "outpostgamma.dmm"
        #define MAP_NAME "Outpost Gamma"


#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring outpostgamma.

#endif


/*
Begin Design Logic

Science and Engie close together
Sec more involved with other areas; more checkpoints (arrivals and escape)
crew quarters/recreation/cafeteria near each other
"antag area" in upper left, randomize if feasible
Turn ruskie station into a functioning syndicate structure
roundish shape
AI onboard
Substation use
'assembly' and tech storage betwixt engie and sci with access to both
RD and CE have view of tech storage
Colored lighting:
	blue around engi hardsuit storage and EVA
	yellow around rest of engi
	red/yellow lights around airlocks

*/