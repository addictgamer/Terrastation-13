
// ***********************************************************
// Foods that are produced from hydroponics ~~~~~~~~~~
// Data from the seeds carry over to these grown foods
// ***********************************************************

//Grown foods

/obj/item/weapon/reagent_containers/food/snacks/grown //New subclass so we can pass on values
	var/seed = ""
	var/plantname = ""
	var/productname = ""
	var/species = ""
	var/lifespan = 0
	var/endurance = 0
	var/maturation = 0
	var/production = 0
	var/yield = 0
	var/potency = -1
	var/plant_type = 0
	icon = 'harvest.dmi'
	New(newloc,newpotency)
		if (!isnull(newpotency))
			potency = newpotency
		..()
		src.pixel_x = rand(-5.0, 5)
		src.pixel_y = rand(-5.0, 5)

/obj/item/weapon/reagent_containers/food/snacks/grown/attackby(var/obj/item/O as obj, var/mob/user as mob)
	..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "This is a \blue [name]"
		switch(plant_type)
			if (0)
				user << "- Plant type: \blue Normal plant"
			if (1)
				user << "- Plant type: \blue Weed"
			if (2)
				user << "- Plant type: \blue Mushroom"
		user << "- Potency: \blue [potency]"
		user << "- Yield: \blue [yield]"
		user << "- Maturation speed: \blue [maturation]"
		user << "- Production speed: \blue [production]"
		user << "- Endurance: \blue [endurance]"
		user << "- Healing properties: \blue [reagents.get_reagent_amount("nutriment")]"
		return

/obj/item/weapon/reagent_containers/food/snacks/grown/corn
	seed = "/obj/item/seeds/cornseed"
	name = "Corn"
	desc = "I like corm!"
	icon_state = "corn"
	potency = 40
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/poppy
	seed = "/obj/item/seeds/poppyseed"
	name = "Poppy"
	icon_state = "poppy"
	potency = 30
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("opium", 1+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 3, 1)


/obj/item/weapon/reagent_containers/food/snacks/grown/potato
	seed = "/obj/item/seeds/potatoseed"
	name = "Potato"
	desc = "Starchy!"
	icon_state = "potato"
	potency = 25
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = reagents.total_volume

	/*attackby(obj/item/weapon/W as obj, mob/user as mob)
		if (istype(W, /obj/item/cable_coil))
			if (W:amount >= 5)
				W:amount -= 5
				if (!W:amount) del(W)
				user << "\blue You add cable to the potato."
				new /obj/item/weapon/cell/potato(src.loc)
				del(src)*/


/obj/item/weapon/reagent_containers/food/snacks/grown/grapes
	seed = "/obj/item/seeds/grapeseed"
	name = "Grapes"
	desc = "Nutritious!"
	icon_state = "grapes"
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		reagents.add_reagent("sugar", 1+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/greengrapes
	seed = "/obj/item/seeds/greengrapeseed"
	name = "Green Grapes"
	desc = "Nutritious!"
	icon_state = "greengrapes"
	potency = 25
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		reagents.add_reagent("kelotane", 3+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/cabbage
	seed = "/obj/item/seeds/cabbageseed"
	name = "Cabbage"
	desc = "Ewwwwwwwwww"
	icon_state = "cabbage"
	potency = 25
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = reagents.total_volume

/obj/item/weapon/reagent_containers/food/snacks/grown/berries
	seed = "/obj/item/seeds/berryseed"
	name = "Berries"
	desc = "Nutritious!"
	icon_state = "berrypile"
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/glowberries
	seed = "/obj/item/seeds/glowberryseed"
	name = "Glow Berries"
	desc = "Nutritious!"
	var/on = 1
	var/brightness_on = 2 //luminosity when on
	icon_state = "glowberrypile"
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 10), 1))
		reagents.add_reagent("radium", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/glowberries/Del()
	if (istype(loc,/mob))
		loc.sd_SetLuminosity(loc.luminosity - potency/5)
	..()

/obj/item/weapon/reagent_containers/food/snacks/grown/glowberries/pickup(mob/user)
	src.sd_SetLuminosity(0)
	user.total_luminosity += potency/5

/obj/item/weapon/reagent_containers/food/snacks/grown/glowberries/dropped(mob/user)
	user.total_luminosity -= potency/5
	src.sd_SetLuminosity(potency/5)

/obj/item/weapon/reagent_containers/food/snacks/grown/cocoapod
	seed = "/obj/item/seeds/cocoapodseed"
	name = "Cocoa Pod"
	desc = "Fattening"
	icon_state = "cocoapod"
	potency = 50
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		reagents.add_reagent("coco", 4+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/grass
	seed = "/obj/item/seeds/grassseed"
	name = "Grass"
	desc = "Greeny"
	icon_state = "grass"
	potency = 20
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/sugarcane
	seed = "/obj/item/seeds/sugarcaneseed"
	name = "Sugarcane"
	desc = "Sugary"
	icon_state = "sugarcane"
	potency = 50
	New()
		..()
		reagents.add_reagent("sugar", 4+round((potency / 5), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/poisonberries
	seed = "/obj/item/seeds/poisonberryseed"
	name = "Poison Berries"
	desc = "Nutritious in a deadly way."
	icon_state = "poisonberrypile"
	potency = 15
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		reagents.add_reagent("toxin", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/deathberries
	seed = "/obj/item/seeds/deathberryseed"
	name = "Death Berries"
	desc = "Nutritious in a deadly way."
	icon_state = "deathberrypile"
	potency = 50
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		reagents.add_reagent("toxin", 3+round(potency / 3, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/ambrosiavulgaris
	seed = "/obj/item/seeds/ambrosiavulgaris"
	name = "Ambrosia Vulgaris"
	desc = "A plant containing various healing chemicals."
	icon_state = "ambrosiavulgaris"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1)
		reagents.add_reagent("space_drugs", 3+round(potency / 5, 1))
		reagents.add_reagent("kelotane", 3+round(potency / 5, 1))
		reagents.add_reagent("bicaridine", 3+round(potency / 5, 1))
		reagents.add_reagent("toxin", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/apple
	seed = "/obj/item/seeds/appleseed"
	name = "Apple"
	desc = "A piece of Eden."
	icon_state = "apple"
	potency = 15
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/watermelon
	seed = "/obj/item/seeds/watermelonseed"
	name = "Watermelon"
	desc = "A melon full of watery goodness"
	icon_state = "watermelon"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 5), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/pumpkin
	seed = "/obj/item/seeds/pumpkinseed"
	name = "Pumpkin"
	desc = "A large and scary pumpkin"
	icon_state = "pumpkin"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 5), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/lime
	seed = "/obj/item/seeds/limeseed"
	name = "Lime"
	desc = "A fruit so sour it twists your face."
	icon_state = "lime"
	potency = 20
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/lemon
	seed = "/obj/item/seeds/lemonseed"
	name = "Lemon"
	desc = "A sour fruit that makes your mouth bleed."
	icon_state = "lemon"
	potency = 20
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/orange
	seed = "/obj/item/seeds/orangeseed"
	name = "Orange"
	desc = "A sweet and sour fruit."
	icon_state = "orange"
	potency = 20
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))

/obj/item/weapon/reagent_containers/food/snacks/grown/whitebeet
	seed = "/obj/item/seeds/whitebeetseed"
	name = "White Beet"
	desc = "A beeting of white."
	icon_state = "whitebeet"
	potency = 15
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("sugar", 1+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/banana
	seed = "/obj/item/seeds/bananaseed"
	name = "Banana"
	desc = "A banana. Excellent clown weapon."
	icon = 'items.dmi'
	icon_state = "banana"
	item_state = "banana"
	On_Consume()
		if (!reagents.total_volume)
			var/mob/M = usr
			var/obj/item/weapon/bananapeel/W = new /obj/item/weapon/bananapeel( M )
			M << "\blue You peel the banana."
			M.put_in_hand(W)
			W.add_fingerprint(M)
	New()
		..()
		reagents.add_reagent("banana", 1+round((potency / 10), 1))
		bitesize = 5
		src.pixel_x = rand(-5.0, 5)
		src.pixel_y = rand(-5.0, 5)

/obj/item/weapon/reagent_containers/food/snacks/grown/chili
	seed = "/obj/item/seeds/chiliseed"
	name = "Chili"
	desc = "Spicy! Wait...ITS BURNING ME!"
	icon_state = "chilipepper"
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("capsaicin", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/chili/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "- Capsaicin: \blue [reagents.get_reagent_amount("capsaicin")]%"

/obj/item/weapon/reagent_containers/food/snacks/grown/eggplant
	seed = "/obj/item/seeds/eggplantseed"
	name = "Eggplant"
	desc = "Yum!"
	icon_state = "eggplant"
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/soybeans
	seed = "/obj/item/seeds/soyaseed"
	name = "Soybeans"
	desc = "Pretty bland, but the possibilities..."
	icon_state = "soybeans"
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/tomato
	seed = "/obj/item/seeds/tomatoseed"
	name = "Tomato"
	desc = "Tom-mae-to or to-mah-to? You decide."
	icon_state = "tomato"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

	throw_impact(atom/hit_atom)
		..()
		new/obj/decal/cleanable/tomato_smudge(src.loc)
		src.visible_message("\red [src.name] has been squashed.","\red You hear a smack.")
		del(src)
		return

/obj/item/weapon/reagent_containers/food/snacks/grown/killertomato
	seed = "/obj/item/seeds/killertomatoseed"
	name = "Killer Tomato"
	desc = "Tom-mae-to or to-mah-to? You decide."
	icon_state = "killertomato"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)
		if (istype(src.loc,/mob))
			pickup(src.loc)
	lifespan = 120
	endurance = 30
	maturation = 15
	production = 1
	yield = 3
	potency = 30
	plant_type = 2

/obj/item/weapon/reagent_containers/food/snacks/grown/killertomato/attack_self(mob/user as mob)
	if (istype(user.loc,/turf/space))
		return
	new /obj/critter/killertomato(user.loc)

	del(src)

	user << "You plant the killertomato."

/obj/item/weapon/reagent_containers/food/snacks/grown/bloodtomato
	seed = "/obj/item/seeds/bloodtomatoseed"
	name = "Blood Tomato"
	desc = "So bloody...so...very...bloody....AHHHH!!!!"
	icon_state = "bloodtomato"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 10), 1))
		reagents.add_reagent("blood", 1+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/bluetomato
	seed = "/obj/item/seeds/bluetomatoseed"
	name = "Blue Tomato"
	desc = "Tom-mae-to or to-mah-to? You decide."
	icon_state = "bluetomato"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", 1+round((potency / 20), 1))
		reagents.add_reagent("lube", 1+round((potency / 5), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)


/obj/item/weapon/reagent_containers/food/snacks/grown/wheat
	seed = "/obj/item/seeds/wheatseed"
	name = "Wheat"
	desc = "I wouldn't eat this, unless you're one of those health freaks.."
	icon_state = "wheat"
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/icepepper
	seed = "/obj/item/seeds/icepepperseed"
	name = "Icepepper"
	desc = "A mutant strain of chile"
	icon_state = "icepepper"
	potency = 20
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("frostoil", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/icepepper/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "- Frostoil: \blue [reagents.get_reagent_amount("frostoil")]%"

/obj/item/weapon/reagent_containers/food/snacks/grown/carrot
	seed = "/obj/item/seeds/carrotseed"
	name = "Carrot"
	desc = "Good for the eyes!"
	icon_state = "carrot"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 10), 1))
		reagents.add_reagent("imidazoline", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita
	seed = "/obj/item/seeds/amanitamycelium"
	name = "Fly amanita"
	desc = "<I>Amanita Muscaria</I>: Learn poisonous mushrooms by heart. Only pick mushrooms you know."
	icon_state = "amanita"
	potency = 10
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("amatoxin", 3+round(potency / 3, 1))
		reagents.add_reagent("psilocybin", 1+round(potency / 25, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "- Amatoxins: \blue [reagents.get_reagent_amount("amatoxin")]%"
		user << "- Psilocybin: \blue [reagents.get_reagent_amount("psilocybin")]%"

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/angel
	seed = "/obj/item/seeds/angelmycelium"
	name = "Destroying angel"
	desc = "<I>Amanita Virosa</I>: Deadly poisonous basidiomycete fungus filled with alpha amatoxins."
	icon_state = "angel"
	potency = 35
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("amatoxin", 13+round(potency / 3, 1))
		reagents.add_reagent("psilocybin", 1+round(potency / 25, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/angel/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "- Amatoxins: \blue [reagents.get_reagent_amount("amatoxin")]%"
		user << "- Psilocybin: \blue [reagents.get_reagent_amount("psilocybin")]%"

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap
	seed = "/obj/item/seeds/libertymycelium"
	name = "Liberty cap"
	desc = "<I>Psilocybe Semilanceata</I>: Liberate yourself!"
	icon_state = "libertycap"
	potency = 15
	New()
		..()
		reagents.add_reagent("nutriment", round((potency / 20), 1))
		reagents.add_reagent("psilocybin", 3+round(potency / 5, 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap/attackby(var/obj/item/O as obj, var/mob/user as mob)
	. = ..()
	if (istype(O, /obj/item/device/analyzer/plant_analyzer))
		user << "- Psilocybin: \blue [reagents.get_reagent_amount("psilocybin")]%"

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/plumphelmet
	seed = "/obj/item/seeds/plumpmycelium"
	name = "Plump Helmet"
	desc = "<I>Plumus Hellmus</I>: Plump, soft and s-so inviting~"
	icon_state = "plumphelmet"
	New()
		..()
		reagents.add_reagent("nutriment", 2+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/walkingmushroom
	seed = "/obj/item/seeds/walkingmushroom"
	name = "Walking Mushroom"
	desc = "The beginging of the great walk."
	icon_state = "walkingmushroom"
	New()
		..()
		reagents.add_reagent("nutriment", 2+round((potency / 10), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)
		if (istype(src.loc,/mob))
			pickup(src.loc)
	lifespan = 120
	endurance = 30
	maturation = 15
	production = 1
	yield = 3
	potency = 30
	plant_type = 2

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/walkingmushroom/attack_self(mob/user as mob)
	if (istype(user.loc,/turf/space))
		return
	new /obj/critter/walkingmushroom(user.loc)

	del(src)

	user << "You plant the walking mushroom."

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/chanterelle
	seed = "/obj/item/seeds/chantermycelium"
	name = "Chanterelle"
	desc = "<I>Cantharellus Cibarius</I>: These jolly yellow little shrooms sure look tasty! There's a lot!"
	icon_state = "chanterelle"
	New()
		..()
		reagents.add_reagent("nutriment",round((potency / 20), 1))
		bitesize = 1+round(reagents.total_volume / 2, 1)

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/glowshroom
	seed = "/obj/item/seeds/glowshroom"
	name = "Glowshroom"
	desc = "<i>Glowshroom</i>: These species of mushrooms glown in the dark. OR DO THEY?"
	icon_state = "glowshroom"
	New()
		..()
		reagents.add_reagent("radium",1+round((potency / 20), 1))
		if (istype(src.loc,/mob))
			pickup(src.loc)
		else
			src.sd_SetLuminosity(potency/10)
	lifespan = 120 //ten times that is the delay
	endurance = 30
	maturation = 15
	production = 1
	yield = 3
	potency = 30
	plant_type = 2

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/glowshroom/attack_self(mob/user as mob)
	if (istype(user.loc,/turf/space))
		return
	var/obj/glowshroom/planted = new /obj/glowshroom(user.loc)

	planted.delay = lifespan * 50
	planted.endurance = endurance
	planted.yield = yield
	planted.potency = potency

	del(src)

	user << "You plant the glowshroom."

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/glowshroom/Del()
	if (istype(loc,/mob))
		loc.sd_SetLuminosity(loc.luminosity - potency/10)
	..()

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/glowshroom/pickup(mob/user)
	src.sd_SetLuminosity(0)
	user.total_luminosity += potency/10

/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/glowshroom/dropped(mob/user)
	user.total_luminosity -= potency/10
	src.sd_SetLuminosity(potency/10)

/obj/item/weapon/reagent_containers/food/snacks/grown/watermelon
	name = "Watermelon"
	icon_state = "A juicy watermelon"
	icon_state = "watermelon"
	slice_path = /obj/item/weapon/reagent_containers/food/snacks/watermelonslice
	slices_num = 5
	New()
		..()
		reagents.add_reagent("nutriment", 10)
		bitesize = 2
