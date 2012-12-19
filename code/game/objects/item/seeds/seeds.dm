
// ********************************************************
// Here's all the seeds (=plants) that can be used in hydro
// ********************************************************

/obj/item/seeds
	name = "seed"
	icon = 'seeds.dmi'
	icon_state = "seed" // unknown plant seed - these shouldn't exist in-game
	flags = FPRINT | TABLEPASS
	w_class = 1.0 // Makes them pocketable
	var/mypath = "/obj/item/seeds"
	var/plantname = ""
	var/productname = ""
	var/species = ""
	var/lifespan = 0
	var/endurance = 0
	var/maturation = 0
	var/production = 0
	var/yield = 0 // If is -1, the plant/shroom/weed is never meant to be harvested
	var/oneharvest = 0
	var/potency = -1
	var/growthstages = 0
	var/plant_type = 0 // 0 = 'normal plant'; 1 = weed; 2 = shroom


/obj/item/seeds/chiliseed
	name = "Chili plant seeds"
	desc = "HOT! HOT! HOT!"
	icon_state = "seed-chili"
	mypath = "/obj/item/seeds/chiliseed"
	species = "chili"
	plantname = "Chili plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/chili"
	lifespan = 20
	endurance = 15
	maturation = 5
	production = 5
	yield = 4
	potency = 20
	plant_type = 0
	growthstages = 6

/obj/item/seeds/replicapod
	name = "Replica pod seeds"
	desc = "They say these are used to harvest humans."
	icon_state = "seed-replicapod"
	mypath = "/obj/item/seeds/replicapod"
	species = "replicapod"
	plantname = "Replica pod"
	productname = "/mob/living/carbon/human" //verrry special -- Urist
	lifespan = 50 //no idea what those do
	endurance = 8
	maturation = 10
	production = 10
	yield = 1 //seeds if there isn't a dna inside
	oneharvest = 1
	potency = 30
	plant_type = 0
	growthstages = 6
	var/ui = null //for storing the guy
	var/se = null
	var/ckey = null
	var/realName = null
	var/datum/mind/mind = null
	gender = "male"

/obj/item/seeds/grapeseed
	name = "Grape seeds"
	desc = "Seeds that grows into grapes"
	icon_state = "seed-grapes"
	mypath = "/obj/item/seeds/grapeseed"
	species = "grape"
	plantname = "Grape Vine"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/grapes"
	lifespan = 50
	endurance = 25
	maturation = 3
	production = 5
	yield = 4
	potency = 10
	plant_type = 0
	growthstages = 2

/obj/item/seeds/greengrapeseed
	name = "Green Grape seeds"
	desc = "Seeds that grows into green grapes"
	icon_state = "seed-greengrapes"
	mypath = "/obj/item/seeds/greengrapeseed"
	species = "greengrape"
	plantname = "Gren Grape Vine"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/greengrapes"
	lifespan = 50
	endurance = 25
	maturation = 3
	production = 5
	yield = 4
	potency = 10
	plant_type = 0
	growthstages = 2

/obj/item/seeds/cabbageseed
	name = "Cabbage seeds"
	desc = "Seeds that grows into cabbages"
	icon_state = "seed-cabbage"
	mypath = "/obj/item/seeds/cabbageseed"
	species = "cabbage"
	plantname = "Cabbage Plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/cabbage"
	lifespan = 50
	endurance = 25
	maturation = 3
	production = 5
	yield = 4
	potency = 10
	plant_type = 0
	growthstages = 1

/obj/item/seeds/berryseed
	name = "Berry seeds"
	desc = "Seeds that grows into berries."
	icon_state = "seed-berry"
	mypath = "/obj/item/seeds/berryseed"
	species = "berry"
	plantname = "Berry bush"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/berries"
	lifespan = 20
	endurance = 15
	maturation = 5
	production = 5
	yield = 2
	potency = 10
	plant_type = 0
	growthstages = 6

/obj/item/seeds/glowberryseed
	name = "Glow Berry seeds"
	desc = "Seeds that grows into glow berries."
	icon_state = "seed-glowberry"
	mypath = "/obj/item/seeds/glowberryseed"
	species = "glowberry"
	plantname = "Glow Berry bush"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/glowberries"
	lifespan = 30
	endurance = 25
	maturation = 5
	production = 5
	yield = 2
	potency = 10
	plant_type = 0
	growthstages = 6

/obj/item/seeds/bananaseed
	name = "Banana seeds"
	desc = "When grown, keep away from clown."
	icon_state = "seed-banana"
	mypath = "/obj/item/seeds/bananaseed"
	species = "banana"
	plantname = "Banana tree"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/banana"
	lifespan = 50
	endurance = 30
	maturation = 6
	production = 6
	yield = 3
	plant_type = 0
	growthstages = 6

/obj/item/seeds/eggplantseed
	name = "Eggplant seeds"
	desc = "These seeds grows into plants in the form of eggs."
	icon_state = "seed-eggplant"
	mypath = "/obj/item/seeds/eggplantseed"
	species = "eggplant"
	plantname = "Eggplant plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/eggplant"
	lifespan = 25
	endurance = 15
	maturation = 6
	production = 6
	yield = 2
	plant_type = 0
	growthstages = 6

/obj/item/seeds/eggyseed
	name = "Egg Plant seeds"
	desc = "These seeds grows into plants in the form of eggs."
	icon_state = "seed-eggy"
	mypath = "/obj/item/seeds/eggy"
	species = "eggy"
	plantname = "Egg Plant plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/egg"
	lifespan = 75
	endurance = 15
	maturation = 6
	production = 12
	yield = 2
	plant_type = 0
	growthstages = 6

/obj/item/seeds/bloodtomatoseed
	name = "Blood Tomato seeds"
	desc = "Used to grow blood tomotoes."
	icon_state = "seed-bloodtomato"
	mypath = "/obj/item/seeds/bloodtomatoseed"
	species = "bloodtomato"
	plantname = "Blood Tomato plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/bloodtomato"
	lifespan = 25
	endurance = 20
	maturation = 8
	production = 6
	yield = 3
	potency = 10
	plant_type = 0
	growthstages = 6

/obj/item/seeds/tomatoseed
	name = "Tomato seeds"
	desc = "Used to grow tomotoes."
	icon_state = "seed-tomato"
	mypath = "/obj/item/seeds/tomatoseed"
	species = "tomato"
	plantname = "Tomato plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/tomato"
	lifespan = 25
	endurance = 15
	maturation = 8
	production = 6
	yield = 2
	potency = 10
	plant_type = 0
	growthstages = 6

/obj/item/seeds/killertomatoseed
	name = "Killer Tomato seeds"
	desc = "Used to grow killer tomotoes."
	icon_state = "seed-killertomato"
	mypath = "/obj/item/seeds/killertomatoseed"
	species = "killertomato"
	plantname = "Killer Tomato plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/killertomato"
	lifespan = 25
	endurance = 15
	maturation = 8
	production = 6
	yield = 2
	potency = 10
	plant_type = 0
	oneharvest = 1
	growthstages = 2

/obj/item/seeds/bluetomatoseed
	name = "Blue Tomato seeds"
	desc = "Used to grow blue tomotoes."
	icon_state = "seed-bluetomato"
	mypath = "/obj/item/seeds/bluetomatoseed"
	species = "bluetomato"
	plantname = "Blue Tomato plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/bluetomato"
	lifespan = 25
	endurance = 15
	maturation = 8
	production = 6
	yield = 2
	potency = 10
	plant_type = 0
	growthstages = 6

/obj/item/seeds/cornseed
	name = "Corn seeds"
	desc = "I don't mean to sound corny..."
	icon_state = "seed-corn"
	mypath = "/obj/item/seeds/cornseed"
	species = "corn"
	plantname = "Corn plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/corn"
	lifespan = 25
	endurance = 15
	maturation = 8
	production = 6
	yield = 3
	plant_type = 0
	oneharvest = 1
	growthstages = 3

/obj/item/seeds/poppyseed
	name = "Poppy seeds"
	icon_state = "seed-poppy"
	mypath = "/obj/item/seeds/poppyseed"
	species = "poppy"
	plantname = "Poppy plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/poppy"
	lifespan = 25
	endurance = 10
	potency = 20
	maturation = 8
	production = 6
	yield = 6
	plant_type = 0
	oneharvest = 1
	growthstages = 3

/obj/item/seeds/potatoseed
	name = "Potato Seeds"
	desc = "This will one day grow into potatoes."
	icon_state = "seed-potato"
	mypath = "/obj/item/seeds/potatoseed"
	species = "potato"
	plantname = "Potato Plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/potato"
	lifespan = 30
	endurance = 15
	maturation = 10
	production = 1
	yield = 4
	plant_type = 0
	oneharvest = 1
	potency = 10
	growthstages = 4

/obj/item/seeds/icepepperseed
	name = "Ice pepper seeds"
	desc = "This will soon become chilly..."
	icon_state = "seed-icepepper"
	mypath = "/obj/item/seeds/icepepperseed"
	species = "chiliice"
	plantname = "Ice pepper plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/icepepper"
	lifespan = 25
	endurance = 15
	maturation = 4
	production = 4
	yield = 4
	potency = 20
	plant_type = 0
	growthstages = 6

/obj/item/seeds/soyaseed
	name = "Soybean seeds"
	desc = "This grows into Soy."
	icon_state = "seed-soybean"
	mypath = "/obj/item/seeds/soyaseed"
	species = "soybean"
	plantname = "Soybean plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/soybeans"
	lifespan = 25
	endurance = 15
	maturation = 4
	production = 4
	yield = 3
	potency = 0
	plant_type = 0
	growthstages = 6

/obj/item/seeds/wheatseed
	name = "Wheat seeds"
	desc = "This may or may not grow into weed."
	icon_state = "seed-wheat"
	mypath = "/obj/item/seeds/wheatseed"
	species = "wheat"
	plantname = "Wheat stalks"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/wheat"
	lifespan = 25
	endurance = 15
	maturation = 6
	production = 1
	yield = 4
	potency = 0
	oneharvest = 1
	plant_type = 0
	growthstages = 6

/obj/item/seeds/carrotseed
	name = "Carrot seeds"
	desc = "It will grow into a carrot."
	icon_state = "seed-carrot"
	mypath = "/obj/item/seeds/carrotseed"
	species = "carrot"
	plantname = "CURROTS MAN CURROTS"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/carrot"
	lifespan = 25
	endurance = 15
	maturation = 10
	production = 1
	yield = 5
	potency = 10
	oneharvest = 1
	plant_type = 0
	growthstages = 5

/obj/item/seeds/amanitamycelium
	name = "Fly Amanita mycelium"
	desc = "Grows into something horrible."
	icon_state = "mycelium-amanita"
	mypath = "/obj/item/seeds/amanitamycelium"
	species = "amanita"
	plantname = "Fly Amanita"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/amanita"
	lifespan = 50
	endurance = 35
	maturation = 10
	production = 5
	yield = 4
	potency = 10 // Damage based on potency?
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/angelmycelium
	name = "Destroying Angel mycelium"
	icon_state = "mycelium-angel"
	mypath = "/obj/item/seeds/angelmycelium"
	species = "angel"
	plantname = "Destroying Angel"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/angel"
	lifespan = 50
	endurance = 35
	maturation = 12
	production = 5
	yield = 2
	potency = 35
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/libertymycelium
	name = "Liberty Cap mycelium"
	desc = "It is said to grow druggy."
	icon_state = "mycelium-liberty"
	mypath = "/obj/item/seeds/libertymycelium"
	species = "liberty"
	plantname = "Liberty Cap"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/libertycap"
	lifespan = 25
	endurance = 15
	maturation = 7
	production = 1
	yield = 5
	potency = 15 // Lowish potency at start
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/chantermycelium
	name = "Chanterelle mycelium"
	desc = "Grows, grows, grows."
	icon_state = "mycelium-chanter"
	mypath = "/obj/item/seeds/chantermycelium"
	species = "chanter"
	plantname = "Chanterelle"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/chanterelle"
	lifespan = 35
	endurance = 20
	maturation = 7
	production = 1
	yield = 5
	potency = -1
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/towermycelium
	name = "Tower Cap mycelium"
	desc = "Why does this sound so familiar..."
	icon_state = "mycelium-tower"
	mypath = "/obj/item/seeds/towermycelium"
	species = "towercap"
	plantname = "Tower Cap"
	productname = "/obj/item/weapon/grown/log"
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = -1
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/glowshroom
	name = "Glowshroom mycelium"
	desc = "This will glow into mushrooms."
	icon_state = "mycelium-glowshroom"
	mypath = "/obj/item/seeds/glowshroom"
	species = "glowshroom"
	plantname = "Glowshroom"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/glowshroom"
	lifespan = 120 //ten times that is the delay
	endurance = 30
	maturation = 15
	production = 1
	yield = 3 //-> spread
	potency = 30 //-> brightness
	oneharvest = 1
	growthstages = 4
	plant_type = 2

/obj/item/seeds/plumpmycelium
	name = "Plump Helmet mycelium"
	desc = "These seeds will grow into helmets."
	icon_state = "mycelium-plump"
	mypath = "/obj/item/seeds/plumpmycelium"
	species = "plump"
	plantname = "Plump Helmet"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/plumphelmet"
	lifespan = 25
	endurance = 15
	maturation = 8
	production = 1
	yield = 4
	potency = 0
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/walkingmushroommycelium
	name = "Walking Mushroom mycelium"
	desc = "These seeds will grow into huge stuff."
	icon_state = "mycelium-walkingmushroom"
	mypath = "/obj/item/seeds/walkingmushroommycelium"
	species = "walkingmushroom"
	plantname = "Walking Mushroom"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/mushroom/walkingmushroom"
	lifespan = 30
	endurance = 30
	maturation = 5
	production = 1
	yield = 1
	potency = 0
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/nettleseed
	name = "Nettle seeds"
	desc = "Grows into nettle."
	icon_state = "seed-nettle"
	mypath = "/obj/item/seeds/nettleseed"
	species = "nettle"
	plantname = "Nettle"
	productname = "/obj/item/weapon/grown/nettle"
	lifespan = 30
	endurance = 40 // tuff like a toiger
	maturation = 6
	production = 6
	yield = 4
	potency = 8
	oneharvest = 0
	growthstages = 5
	plant_type = 1

/obj/item/seeds/deathnettleseed
	name = "Deathnettle seeds"
	desc = "Grows into Nettle."
	icon_state = "seed-deathnettle"
	mypath = "/obj/item/seeds/deathnettleseed"
	species = "deathnettle"
	plantname = "Death Nettle"
	productname = "/obj/item/weapon/grown/deathnettle"
	lifespan = 30
	endurance = 25
	maturation = 8
	production = 6
	yield = 2
	potency = 20
	oneharvest = 0
	growthstages = 5
	plant_type = 1

/obj/item/seeds/weeds
	name = "Weeds"
	desc = "These seems weedy."
	icon_state = "seed"
	mypath = "/obj/item/seeds/weeds"
	species = "weeds"
	plantname = "Generic weeds"
	productname = ""
	lifespan = 100
	endurance = 50 // damm pesky weeds
	maturation = 5
	production = 1
	yield = -1
	potency = -1
	oneharvest = 1
	growthstages = 4
	plant_type = 1

/obj/item/seeds/harebell
	name = "Harebell"
	icon_state = "seed"
	mypath = "/obj/item/seeds/harebell"
	species = "harebell"
	plantname = "Harebell"
	productname = ""
	lifespan = 100
	endurance = 20
	maturation = 7
	production = 1
	yield = -1
	potency = -1
	oneharvest = 1
	growthstages = 4
	plant_type = 1

/obj/item/seeds/sunflowerseed
	name = "Sunflower seeds"
	desc = "This will grow shining."
	icon_state = "seed-sunflower"
	mypath = "/obj/item/seeds/sunflowerseed"
	species = "sunflower"
	plantname = "Sunflower"
	productname = "/obj/item/weapon/grown/sunflower"
	lifespan = 25
	endurance = 20
	maturation = 6
	production = 1
	yield = 2
	potency = -1
	oneharvest = 1
	growthstages = 3
	plant_type = 1

/obj/item/seeds/brownmold
	name = "Brown Mold"
	desc = "Moldy."
	icon_state = "seed"
	mypath = "/obj/item/seeds/brownmold"
	species = "mold"
	plantname = "Brown Mold"
	productname = ""
	lifespan = 50
	endurance = 30
	maturation = 10
	production = 1
	yield = -1
	potency = -1
	oneharvest = 1
	growthstages = 3
	plant_type = 2

/obj/item/seeds/appleseed
	name = "Apple seeds"
	desc = "A tasty fruit."
	icon_state = "seed-apple"
	mypath = "/obj/item/seeds/appleseed"
	species = "apple"
	plantname = "Apple tree"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/apple"
	lifespan = 55
	endurance = 35
	maturation = 6
	production = 6
	yield = 5
	plant_type = 0
	growthstages = 6

/obj/item/seeds/ambrosiavulgarisseed
	name = "Ambrosia Vulgaris seeds"
	desc = "A plant grown by and from medicine."
	icon_state = "seed-ambrosiavulgaris"
	mypath = "/obj/item/seeds/ambrosiavulgarisseed"
	species = "ambrosiavulgaris"
	plantname = "Ambrosia Vulgaris"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/ambrosiavulgaris"
	lifespan = 60
	endurance = 25
	maturation = 6
	production = 6
	yield = 8
	plant_type = 0
	growthstages = 6

/obj/item/seeds/whitebeetseed
	name = "White Beet seed"
	desc = "A sugary beet."
	icon_state = "seed-whitebeet"
	mypath = "/obj/item/seeds/whitebeetseed"
	species = "whitebeet"
	plantname = "White Beet Plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/whitebeet"
	lifespan = 60
	endurance = 50
	maturation = 6
	production = 6
	yield = 4
	plant_type = 0
	growthstages = 6

/obj/item/seeds/sugarcaneseed
	name = "Sugarcane seed"
	desc = "A cane of sugar"
	icon_state = "seed-sugarcane"
	mypath = "/obj/item/seeds/sugarcaneseed"
	species = "sugarcane"
	plantname = "Sugarcane"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/sugarcane"
	lifespan = 60
	endurance = 50
	maturation = 3
	production = 6
	yield = 4
	plant_type = 0
	growthstages = 3

/obj/item/seeds/watermelonseed
	name = "Watermelon Seed"
	desc = "Some promising seeds."
	icon_state = "seed-watermelon"
	mypath = "/obj/item/seeds/watermelonseed"
	species = "watermelon"
	plantname = "Watermelon Plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/watermelon"
	lifespan = 50
	endurance = 40
	maturation = 6
	production = 6
	yield = 3
	plant_type = 0
	growthstages = 6

/obj/item/seeds/pumpkinseed
	name = "Pumpkin Seed"
	desc = "Some promising seeds."
	icon_state = "seed-pumpkin"
	mypath = "/obj/item/seeds/pumpkinseed"
	species = "pumpkin"
	plantname = "pumpkin Plant"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/pumpkin"
	lifespan = 50
	endurance = 40
	maturation = 6
	production = 6
	yield = 3
	plant_type = 0
	growthstages = 3


/obj/item/seeds/limeseed
	name = "Lime Seed"
	desc = "Very sour seeds."
	icon_state = "seed-lime"
	mypath = "/obj/item/seeds/limeseed"
	species = "lime"
	plantname = "Lime Tree"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/lime"
	lifespan = 55
	endurance = 50
	maturation = 6
	production = 6
	yield = 4
	plant_type = 0
	growthstages = 6

/obj/item/seeds/lemonseed
	name = "Lemon Seed"
	desc = "Sour seeds."
	icon_state = "seed-lemon"
	mypath = "/obj/item/seeds/lemonseed"
	species = "lemon"
	plantname = "Lemon Tree"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/lemon"
	lifespan = 55
	endurance = 45
	maturation = 6
	production = 6
	yield = 4
	plant_type = 0
	growthstages = 6

/obj/item/seeds/orangeseed
	name = "Orange Seed"
	desc = "Sour seeds."
	icon_state = "seed-orange"
	mypath = "/obj/item/seeds/orangeseed"
	species = "orange"
	plantname = "Orange Tree"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/orange"
	lifespan = 60
	endurance = 50
	maturation = 6
	production = 6
	yield = 5
	plant_type = 0
	growthstages = 6

/obj/item/seeds/poisonberryseed
	name = "Poison Berry seeds"
	desc = "Seeds that grows into poison berries."
	icon_state = "seed-poisonberry"
	mypath = "/obj/item/seeds/poisonberryseed"
	species = "poisonberry"
	plantname = "Poison Berry bush"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/poisonberries"
	lifespan = 20
	endurance = 15
	maturation = 5
	production = 5
	yield = 2
	potency = 10
	plant_type = 0
	growthstages = 6

/obj/item/seeds/deathberryseed
	name = "Death Berry seeds"
	desc = "Seeds that grows into death berries."
	icon_state = "seed-deathberry"
	mypath = "/obj/item/seeds/deathberryseed"
	species = "deathberry"
	plantname = "Death Berry bush"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/deathberries"
	lifespan = 30
	endurance = 20
	maturation = 5
	production = 5
	yield = 3
	potency = 50
	plant_type = 0
	growthstages = 6

/obj/item/seeds/grassseed
	name = "Grass seeds"
	desc = "Seeds that will one day become sheep food."
	icon_state = "seed-grass"
	mypath = "/obj/item/seeds/grassseed"
	species = "grass"
	plantname = "Grass"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/grass"
	lifespan = 60
	endurance = 50
	maturation = 2
	production = 5
	yield = 5
	potency = 10
	plant_type = 0
	growthstages = 2

/obj/item/seeds/cocoapodseed
	name = "Cocoa Pod seeds"
	desc = "Looks fattening these seeds."
	icon_state = "seed-cocoapod"
	mypath = "/obj/item/seeds/cocoapodseed"
	species = "cocoapod"
	plantname = "Cocoa Pod Tree"
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/cocoapod"
	lifespan = 20
	endurance = 15
	maturation = 5
	production = 5
	yield = 2
	potency = 10
	plant_type = 0
	growthstages = 6

/*  // Maybe one day when I get it to work like a grenade which exlodes gibs.
/obj/item/seeds/gibtomatoseed
	name = "Gib Tomato seeds"
	desc = "Used to grow gib tomotoes."
	icon_state = "seed-gibtomato"
	mypath = "/obj/item/seeds/gibtomatoseed"
	species = "gibtomato"
	plantname = "Gib Tomato plant"
	productname = "/obj/item/weapon/grown/gibtomato"
	lifespan = 35
	endurance = 25
	maturation = 6
	production = 6
	yield = 3
	potency = 10
	plant_type = 0
	growthstages = 6
*/

/*
/obj/item/seeds/
	name = ""
	icon_state = "seed"
	mypath = "/obj/item/seeds/"
	species = ""
	plantname = ""
	productname = "/obj/item/weapon/reagent_containers/food/snacks/grown/"
	lifespan = 25
	endurance = 15
	maturation = 10
	production = 1
	yield = -1
	potency = 0
	oneharvest = 1
	growthstages = 3
	plant_type = 0

*/
