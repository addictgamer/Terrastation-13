/obj/effect/spawner/lootdrop/hazfluff
	name = "random terraform vest"
	lootdoubles = 0
	color = "#00FFFF"

//Note: my vest has lower weight becuase it is probably underpowered compared to the others. --LZ
	loot = list(
				/obj/item/clothing/suit/storage/hazardvest/lz = 1,
				/obj/item/clothing/suit/storage/hazardvest/terraform/armed = 2,
				/obj/item/clothing/suit/storage/hazardvest/tauka = 2,
			//	/obj/item/clothing/suit/storage/hazardvest/terraform/addict = 2,//not yet implemented
				/obj/item/clothing/suit/storage/hazardvest/qui/armed = 2,//not yet implemented
				)
				//no bast vest because it doesn't have any potential OP traits... yet anyway

/obj/effect/spawner/lootdrop/hazfluff/safe
	loot = list(
				/obj/item/clothing/suit/storage/hazardvest/lz = 1,
				/obj/item/clothing/suit/storage/hazardvest/terraform = 1,
				/obj/item/clothing/suit/storage/hazardvest/bast = 1,
			//	/obj/item/clothing/suit/storage/hazardvest/terraform/addict = 1,//not yet implemented
				/obj/item/clothing/suit/storage/hazardvest/qui = 1,//not yet implemented
				)
				//no tauka vest because a) no safe variant coded and b) fuck him lol