/datum/material
	var/mat_key
	var/mat_name //Options are SOLID, LIQUID, GAS, GRANULAR, VAPOR, and DEFAULT. Like so: mat_name = "SOLID="Ice":LIQUID="Water":GAS="Steam""
	var/mat_color //Same scheme
	var/mat_icon //Ditto
	var/melting_point
	var/boiling_point
	var/ignite_point
	var/heat_fusion
	var/heat_vaporization
	var/heat_capacity
	var/density_solid
	var/density_liquid
	var/molar_mass
	var/vapor_pressure
	var/ductility
	var/malleability
	var/DBTT //Ductile-Brittle Transition Temperature
	var/elasticity
	var/conductivity_electric
	var/conductivity_thermal
	var/magnetism
	var/transparency
	var/reflectance
	var/stability_heat //Minimum temperature for decomposition.
	var/stability_force //Ditto, but for force.

	var/list/constituent_mats //E.g. ("hydrogen" = 67, "oxygen" = 33) where the numeric value equals a component's percentage of the whole.
	                          //This has many uses, not least among them being explosives.


//Radioactive !!FUN!!
	var/rad_type
	var/halflife
	var/stability
	var/child_mat //What the material decays into.

//Time-saving variables, calculated at run-time.
	var/viscosity
	var/list/reactions = list()

/datum/material/oxygen
	mat_key = "oxygen"
	mat_name = list("DEFAULT" = "oxygen", "GAS" = "oxygen")
	melting_point = 54.36
	boiling_point = 90.188
	heat_fusion = 0.444
	heat_vaporization = 6.82
	heat_capacity = 29.378
	density_solid = 22.25
	density_liquid = 1.141
	molar_mass = 15.999