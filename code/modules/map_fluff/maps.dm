var/datum/map/using_map = new USING_MAP_DATUM

/datum/map
	var/name = "Unnamed Map"
	var/full_name = "Unnamed Map"

	var/station_name  = "BAD Station"
	var/station_short = "Baddy"
	var/dock_name     = "THE PirateBay"
	var/company_name  = "BadMan"
	var/company_short = "BM"
	var/starsys_name  = "Dull Star"
	var/list/zLevels = list()
	var/zMainStation = 1
	var/zCentcomm = 2
	var/zTCommSat = 3
	var/zDerelict = 4
	var/zAsteroid = 5
	var/zSalvageYard = 6
	var/zDeepSpace = 7

	//Holomap offsets
	var/list/holomap_offset_x = list()
	var/list/holomap_offset_y = list()
