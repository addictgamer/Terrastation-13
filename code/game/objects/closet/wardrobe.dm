
/obj/closet/wardrobe
	desc = "A bulky (yet mobile) wardrobe closet. Comes prestocked with three changes of clothes."
	name = "Wardrobe"
	icon_state = "blue"
	icon_closed = "blue"

/obj/closet/wardrobe/New()
	new /obj/item/clothing/under/color/blue(src)
	new /obj/item/clothing/under/color/blue(src)
	new /obj/item/clothing/under/color/blue(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/brown(src)
	return

/obj/closet/wardrobe/white
	name = "White Wardrobe"
	desc = "Basic plain white clothing. Boring..."
	icon_state = "white"
	icon_closed = "white"

/obj/closet/wardrobe/white/New()
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	return

/obj/closet/wardrobe/pink
	name = "Pink Wardrobe"
	desc = "Closet of soft clothing."
	icon_state = "pink"
	icon_closed = "pink"

/obj/closet/wardrobe/pink/New()
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/brown(src)
	return

/obj/closet/wardrobe/red
	name = "Red Wardrobe"
	desc = "This closer appears to contain clothing which are red."
	icon_state = "red"
	icon_closed = "red"

/obj/closet/wardrobe/red/New()
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/under/rank/security(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/head/secsoft(src)
	new /obj/item/clothing/head/secsoft(src)
	new /obj/item/clothing/head/secsoft(src)
	new /obj/item/clothing/head/secsoft(src)
	return

/obj/closet/wardrobe/orange
	name = "Prisoners Wardrobe"
	desc = "Prisoners now wear orange. The Security Officers kept thinking the Mime was an escapee."
	icon_state = "orange"
	icon_closed = "orange"

/obj/closet/wardrobe/orange/New()
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	return

/obj/closet/wardrobe/yellow
	name = "Yellow Wardrobe"
	desc = "Basic yellow clothing."
	icon_state = "wardrobe-y"
	icon_closed = "wardrobe-y"

/obj/closet/wardrobe/yellow/New()
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	return

/obj/closet/wardrobe/green
	name = "Green Wardrobe"
	desc = "Green is the new green."
	icon_state = "green"
	icon_closed = "green"

/obj/closet/wardrobe/green/New()
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	return

/obj/closet/wardrobe/grey
	name = "Grey Wardrobe"
	desc = "This contains the clothing of the Grey Shirts."
	icon_state = "grey"
	icon_closed = "grey"

/obj/closet/wardrobe/grey/New()
	new /obj/item/clothing/under/color/grey(src)
	new /obj/item/clothing/under/color/grey(src)
	new /obj/item/clothing/under/color/grey(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	return

/obj/closet/wardrobe/black
	name = "Black Wardrobe"
	desc = "This contains clothes which appears to be black."
	icon_state = "black"
	icon_closed = "black"

/obj/closet/wardrobe/black/New()
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/under/color/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/that(src)
	new /obj/item/clothing/head/that(src)
	return

/obj/closet/wardrobe/mixed
	name = "Mixed Wardrobe"
	desc = "This appears to contain two different sets of clothing."
	icon_state = "mixed"
	icon_closed = "mixed"

/obj/closet/wardrobe/mixed/New()
	new /obj/item/clothing/under/color/white(src)
	new /obj/item/clothing/under/color/blue(src)
	new /obj/item/clothing/under/color/yellow(src)
	new /obj/item/clothing/under/color/green(src)
	new /obj/item/clothing/under/color/orange(src)
	new /obj/item/clothing/under/color/pink(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/white(src)
	return

/obj/closet/wardrobe/atmospherics_yellow
	name = "Atmospherics Wardrobe"
	desc = "Clothing for the most dangerous job."
	icon_state = "yellow"
	icon_closed = "yellow"

/obj/closet/wardrobe/atmospherics_yellow/New()
	new /obj/item/clothing/under/rank/atmospheric_technician(src)
	new /obj/item/clothing/under/rank/atmospheric_technician(src)
	new /obj/item/clothing/under/rank/atmospheric_technician(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/shoes/black(src)
	return

/obj/closet/wardrobe/engineering_yellow
	name = "Engineering Wardrobe"
	desc = "The yellow Engineers loves."
	icon_state = "yellow"
	icon_closed = "yellow"

/obj/closet/wardrobe/engineering_yellow/New()
	new /obj/item/clothing/under/rank/engineer(src)
	new /obj/item/clothing/under/rank/engineer(src)
	new /obj/item/clothing/under/rank/engineer(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	new /obj/item/clothing/shoes/orange(src)
	return

/obj/closet/wardrobe/toxins_white
	name = "Toxins Wardrobe"
	desc = "Clothes for toxins."
	icon_state = "white"
	icon_closed = "white"

/obj/closet/wardrobe/toxins_white/New()
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/clothing/under/rank/scientist(src)
	new /obj/item/clothing/suit/labcoat(src)
	new /obj/item/clothing/suit/labcoat(src)
	new /obj/item/clothing/suit/labcoat(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	return

/obj/closet/wardrobe/genetics_white
	name = "Genetics Wardrobe"
	desc = "Clothes for genetics. They will need this when they are human."
	icon_state = "white"
	icon_closed = "white"

/obj/closet/wardrobe/genetics_white/New()
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/under/rank/geneticist(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/clothing/shoes/white(src)
	new /obj/item/weapon/storage/stma_kit(src)
	new /obj/item/clothing/suit/labcoat(src)
	new /obj/item/clothing/suit/labcoat(src)
	new /obj/item/clothing/suit/labcoat(src)
	return

/obj/closet/wardrobe/chaplain_black
	name = "Chaplain Wardrobe"
	desc = "Closet of chaplain clothes. Looks meh."
	icon_state = "black"
	icon_closed = "black"

/obj/closet/wardrobe/chaplain_black/New()
	//new /obj/item/clothing/suit/imperium_monk(src) //No. -- Urist
	new /obj/item/clothing/under/rank/chaplain(src)
	new /obj/item/clothing/shoes/black(src)
	new /obj/item/clothing/suit/nun(src)
	new /obj/item/clothing/suit/chaplain_hoodie(src)
	new /obj/item/clothing/head/chaplain_hood(src)
	new /obj/item/clothing/suit/holidaypriest(src)
	new /obj/item/clothing/suit/hastur (src)
	new /obj/item/clothing/head/hasturhood (src)
	new /obj/item/weapon/candlepack(src)
	new /obj/item/weapon/candlepack(src)
	return

/obj/closet/wardrobe/forensics_red
	name = "Forensics Wardrobe"
	desc = "Used by your local Forensics."
	icon_state = "red"
	icon_closed = "red"

/obj/closet/lawcloset
	desc = "A bulky (yet mobile) closet. Comes with lawyer apparel and items."
	name = "Legal Closet"

/obj/closet/lawcloset/New()
	new /obj/item/clothing/under/lawyer/black(src)
	new /obj/item/clothing/under/lawyer/red(src)
	new /obj/item/clothing/under/lawyer/bluesuit(src)
	new /obj/item/clothing/suit/lawyer/bluejacket(src)
	new /obj/item/clothing/under/lawyer/purpsuit(src)
	new /obj/item/clothing/suit/lawyer/purpjacket(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/clothing/shoes/black(src)
