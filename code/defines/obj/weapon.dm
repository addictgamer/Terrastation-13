/obj/item/weapon
	name = "weapon"
	icon = 'weapons.dmi'

/obj/item/weapon/offhand
	name = "Offhand"
	var/linked_weapon_name = ""
	w_class = 5.0
	icon_state = "offhand"

/obj/item/weapon/shield
	name = "shield"

/obj/item/weapon/shield/riot
	name = "riot shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder."
	icon = 'weapons.dmi'
	icon_state = "riot"
	flags = FPRINT | TABLEPASS| CONDUCT| ONBACK
	force = 5.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = 4.0
	g_amt = 7500
	m_amt = 1000
	origin_tech = "materials=2"


/obj/item/weapon/shield/legendary
	name = "Legendary Sheild"
	desc = "It's dangerous to go alone, but it's not like this will keep you safe."
	icon = 'weapons.dmi'
	icon_state = "legendary"
	flags = FPRINT | TABLEPASS| CONDUCT| ONBACK
	force = 6.0
	throwforce = 6.0
	throw_speed = 1
	throw_range = 2
	w_class = 4.0
	g_amt = 9000
	m_amt = 2500
	origin_tech = "materials=4"


/obj/item/weapon/sord
	name = "SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	flags = FPRINT | ONBELT | TABLEPASS
	force = 2
	throwforce = 1
	w_class = 3

/obj/item/weapon/bodybag
	name = "body bag"
	desc = "Bag mixed with a bit of body."
	icon = 'closet.dmi'
	icon_state = "bodybag"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 5.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 4
	w_class = 1.0
	g_amt = 7500
	m_amt = 1000
	origin_tech = "materials=2"

/obj/item/weapon/rsf
	name = "Rapid-Service-Fabricator (RSF)"
	desc = "A device used to rapidly deploy service items."
	icon = 'items.dmi'
	icon_state = "rcd"
	opacity = 0
	density = 0
	anchored = 0.0
	var/matter = 0
	var/mode = 1
	flags = TABLEPASS
	w_class = 3.0

/obj/item/weapon/rsp
	name = "Rapid-Seed-Producer (RSP)"
	desc = "A device used to rapidly deploy seeds."
	icon = 'items.dmi'
	icon_state = "rcd"
	opacity = 0
	density = 0
	anchored = 0.0
	var/matter = 0
	var/mode = 1
	flags = TABLEPASS
	w_class = 3.0

/obj/item/weapon/rcd_ammo
	name = "Compressed matter cartridge"
	desc = "Highly compressed matter for the RCD."
	icon = 'ammo.dmi'
	icon_state = "rcd"
	item_state = "rcdammo"
	opacity = 0
	density = 0
	anchored = 0.0
	origin_tech = "materials=2"
	m_amt = 30000
	g_amt = 15000

/obj/item/weapon/spacecash
	name = "Space Cash"
	desc = "You're rich, bitch!"
	icon = 'items.dmi'
	icon_state = "spacecash"
	opacity = 0
	density = 0
	anchored = 0.0
	force = 1.0
	throwforce = 1.0
	throw_speed = 1
	throw_range = 2
	w_class = 1.0
	var/access = list()
	access = access_crate_cash

/obj/item/weapon/spacecash/c10
	icon_state = "spacecash10"
	access = access_crate_cash
/obj/item/weapon/spacecash/c20
	icon_state = "spacecash20"
	access = access_crate_cash
/obj/item/weapon/spacecash/c50
	icon_state = "spacecash50"
	access = access_crate_cash
/obj/item/weapon/spacecash/c100
	icon_state = "spacecash100"
	access = access_crate_cash
/obj/item/weapon/spacecash/c200
	icon_state = "spacecash200"
	access = access_crate_cash
/obj/item/weapon/spacecash/c500
	icon_state = "spacecash500"
	access = access_crate_cash
/obj/item/weapon/spacecash/c1000
	icon_state = "spacecash1000"
	access = access_crate_cash

/*
/obj/item/weapon/ammo
	name = "ammo"
	icon = 'ammo.dmi'
	var/amount_left = 0.0
	flags = FPRINT | TABLEPASS| CONDUCT
	item_state = "syringe_kit"
	m_amt = 50000
	throwforce = 2
	w_class = 1.0
	throw_speed = 4
	throw_range = 20
	origin_tech = "materials=2;combat=1"

/obj/item/weapon/ammo/a357
	desc = "There are 7 rounds left!"
	name = "ammo-357"
	icon_state = "357-7"
	amount_left = 7.0

/obj/item/weapon/ammo/a45
	desc = "There are 10 rounds left!"
	name = "ammo-45"
	icon_state = "45-10"
	amount_left = 10.0

/obj/item/weapon/ammo/a763m
	desc = "There are 9 rounds left!"
	name = "ammo-7.63x25"
	icon_state = "7.63x25m-9"
	amount_left = 9.0

/obj/item/weapon/ammo/a9x19p
	desc = "There are 8 rounds left!"
	name = "ammo-9x19"
	icon_state = "9x19p-8"
	amount_left = 8.0

/obj/item/weapon/ammo/assaultmag
	desc = "There are 30 rounds left!"
	name = "5.56x45mm NATO"
	icon_state = "5.56"
	amount_left = 30.0

/obj/item/weapon/ammo/shell //easier to add new shell types. Like badmin laser/taser/pulse shells.
	desc = "Generic shell description."
	name = "Generic shell."
	icon_state = "blshell"
	m_amt = 9000
	New()
		src.pixel_x = rand(-10.0, 10)
		src.pixel_y = rand(-10.0, 10)

/obj/item/weapon/ammo/shell/beanbag
	desc = "A weak beanbag shell."
	name = "beanbag shell"
	icon_state = "bshell"
	m_amt = 10000

/obj/item/weapon/ammo/shell/gauge
	desc = "A 12gauge shell."
	name = "12 gauge shell"
	icon_state = "gshell"
	m_amt = 25000

/obj/item/weapon/ammo/shell/blank
	desc = "A blank shell."
	name = "blank shell"
	icon_state = "blshell"
	m_amt = 500

/obj/item/weapon/ammo/shell/dart
	desc = "A dart for use in shotguns.."
	name = "shotgun dart"
	icon_state = "blshell" //someone, draw the icon, please.
	m_amt = 50000 //because it's like, instakill.


/obj/item/weapon/ammo/a38
	desc = "A speedloader that contains 7 .38 Special rounds."
	name = "38-Special ammo"
	icon_state = "38-7"
	amount_left = 7.0
	m_amt = 10000
*/
/obj/item/device/mass_spectrometer
	desc = "A hand-held mass spectrometer which identifies trace chemicals in a blood sample."
	name = "mass-spectrometer"
	icon_state = "spectrometer"
	item_state = "analyzer"
	w_class = 2.0
	flags = FPRINT | TABLEPASS| CONDUCT | ONBELT | OPENCONTAINER
	throwforce = 5
	throw_speed = 4
	throw_range = 20
	m_amt = 30
	g_amt = 20
	origin_tech = "magnets=2;biotech=2"
	var
		details = 0
		recent_fail = 0

/obj/item/device/mass_spectrometer/adv
	name = "advanced mass-spectrometer"
	icon_state = "adv_spectrometer"
	details = 1
	origin_tech = "magnets=4;biotech=2"

/obj/item/weapon/melee/baton
	name = "Stun Baton"
	desc = "A stun baton for hitting people with."
	icon_state = "stunbaton"
	item_state = "baton"
	flags = FPRINT | ONBELT | TABLEPASS
	force = 10
	throwforce = 7
	w_class = 3
	var/charges = 10.0
	var/maximum_charges = 10.0
	var/status = 0
	origin_tech = "combat=2"

/obj/item/weapon/melee/chainofcommand
	name = "Chain of Command"
	desc = "The Captain is first and all other heads are last."
	icon_state = "chainofcommand"
	item_state = "chainofcommand"
	flags = FPRINT | ONBELT | TABLEPASS
	force = 10
	throwforce = 7
	w_class = 3
	var/charges = 50.0
	var/maximum_charges = 50.0
	var/status = 1
	origin_tech = "combat=4"

/obj/item/weapon/melee/energy
	var/active = 0

/obj/item/weapon/melee/energy/axe
	name = "Axe"
	desc = "An energised battle axe."
	icon_state = "axe0"
	force = 40.0
	throwforce = 25.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	flags = FPRINT | CONDUCT | NOSHIELD | TABLEPASS
	origin_tech = "combat=3"

/obj/item/weapon/melee/energy/sword
	var/color
	name = "energy sword"
	desc = "May the force be within you."
	icon_state = "sword0"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD
	origin_tech = "magnets=3;syndicate=4"

/obj/item/weapon/melee/energy/sword/chainsword
	color = "chain"
	New()
		return

/obj/item/weapon/melee/energy/sword/pirate
	name = "energy cutlass"
	desc = "Arrrr matey."
	icon_state = "cutlass0"

/obj/item/weapon/melee/energy/blade
	name = "energy blade"
	desc = "A concentrated beam of energy in the shape of a blade. Very stylish... and lethal."
	icon_state = "blade"
	force = 70.0//Normal attacks deal very high damage.
	throwforce = 1//Throwing or dropping the item deletes it.
	throw_speed = 1
	throw_range = 1
	w_class = 4.0//So you can't hide it in your pocket or some such.
	flags = FPRINT | TABLEPASS | NOSHIELD
	var/datum/effects/system/spark_spread/spark_system

/obj/item/weapon/bananapeel
	name = "Banana Peel"
	desc = "A peel from a banana."
	icon = 'items.dmi'
	icon_state = "banana_peel"
	item_state = "banana_peel"
	w_class = 1.0
	throwforce = 0
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/soap
	name = "Soap"
	desc = "A cheap bar of soap. Doesn't smell."
	icon = 'items.dmi'
	icon_state = "soap"
	w_class = 1.0
	throwforce = 0
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/soap/nanotrasen
	desc = "A Nanotrasen brand bar of soap. Smells of plasma."
	icon_state = "soapnt"

/obj/item/weapon/soap/deluxe
	desc = "A deluxe Waffle Co. brand bar of soap. Smells of comdoms."
	icon_state = "soapdeluxe"

/obj/item/weapon/bedsheet
	name = "bedsheet"
	desc = "Nice, linen, bedsheet. Perfect to put on."
	icon = 'items.dmi'
	icon_state = "sheet"
	layer = 4.0
	item_state = "bedsheet"
	throwforce = 1
	w_class = 1.0
	throw_speed = 2
	throw_range = 10

/obj/item/weapon/bikehorn
	name = "Bike Horn"
	desc = "A horn off of a bicycle."
	icon = 'items.dmi'
	icon_state = "bike_horn"
	item_state = "bike_horn"
	throwforce = 3
	w_class = 1.0
	throw_speed = 3
	throw_range = 15
	var/spam_flag = 0

/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'items.dmi'
	amount = 5
	max_amount = 5
	w_class = 1
	throw_speed = 4
	throw_range = 20
	var/heal_brute = 0
	var/heal_burn = 0

/obj/item/stack/medical/bruise_pack
	name = "bruise pack"
	singular_name = "bruise pack"
	desc = "A pack designed to treat blunt-force trauma."
	icon_state = "brutepack"
	heal_brute = 60
	origin_tech = "biotech=1"

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Used to treat those nasty burns."
	singular_name = "ointment"
	icon_state = "ointment"
	heal_burn = 40
	origin_tech = "biotech=1"

/obj/item/weapon/c_tube
	name = "cardboard tube"
	desc = "A tube... of cardboard."
	icon = 'items.dmi'
	icon_state = "c_tube"
	throwforce = 1
	w_class = 1.0
	throw_speed = 4
	throw_range = 5

/obj/item/weapon/camera
	name = "camera"
	desc = "Use this to take pictures."
	icon_state = "camera"
	var/last_pic = 1.0
	item_state = "wrench"
	w_class = 2.0
	origin_tech = "magnets=1"

/obj/item/weapon/card
	name = "card"
	desc = "Does card things."
	icon = 'card.dmi'
	w_class = 1.0

	var/list/files = list(  )

/obj/item/weapon/card/data
	name = "data disk"
	desc = "A disk of data."
	icon_state = "data"
	var/function = "storage"
	var/data = "null"
	var/special = null
	item_state = "card-id"

/obj/item/weapon/card/data/clown
	name = "Coordinates to Clown Planet"
	icon_state = "data"
	item_state = "card-id"
	layer = 3
	level = 2
	desc = "This card contains coordinates to the fabled Clown Planet. Handle with care."

/obj/item/weapon/card/emag
	desc = "It's a card with a magnetic strip attached to some circuitry."
	name = "cryptographic sequencer"
	icon_state = "emag"
	item_state = "card-id"
	origin_tech = "magnets=2;syndicate=2"

/obj/item/weapon/card/id
	name = "identification card"
	desc = "An identification card. No shit."
	icon_state = "id"
	item_state = "card-id"
	var/access = list()
	var/registered = null
	var/assignment = null
	var/obj/item/weapon/photo/PHOTO = null

/obj/item/weapon/card/id/gold
	name = "identification card"
	desc = "A golden card which shows power and might."
	icon_state = "gold"
	item_state = "gold_id"

/obj/item/weapon/card/id/syndicate
	name = "agent card"
	desc = "Shhhhh."
	access = list(access_maint_tunnels)
	origin_tech = "syndicate=3"

/obj/item/weapon/card/id/syndicate_command
	name = "Syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered = "Syndicate"
	assignment = "Syndicate Overlord"
	access = list(access_syndicate)

/obj/item/weapon/card/id/captains_spare
	name = "Captain's spare ID"
	desc = "The spare ID of the High Lord himself."
	icon_state = "gold"
	item_state = "gold_id"
	registered = "Captain"
	assignment = "Captain"
	New()
		access = get_access("Captain")
		..()

/obj/item/weapon/card/id/centcom
	name = "CentCom ID"
	desc = "An ID straight from Cent. Com."
	icon_state = "centcom"
	registered = "Central Command"
	assignment = "General"
	New()
		access = get_all_centcom_access()
		..()

/obj/item/weapon/cleaner
	desc = "Space Cleaner!"
	icon = 'janitor.dmi'
	name = "space cleaner"
	icon_state = "cleaner"
	item_state = "cleaner"
	flags = ONBELT|TABLEPASS|OPENCONTAINER|FPRINT|USEDELAY
	throwforce = 3
	w_class = 2.0
	throw_speed = 2
	throw_range = 10

/obj/item/weapon/chemsprayer
	desc = "A utility used to spray large amounts of reagent in a given area."
	icon = 'gun.dmi'
	name = "chem sprayer"
	icon_state = "chemsprayer"
	item_state = "chemsprayer"
	flags = ONBELT|TABLEPASS|OPENCONTAINER|FPRINT|USEDELAY
	throwforce = 3
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	origin_tech = "combat=3;materials=3;engineering=3"

/obj/item/weapon/cloaking_device
	name = "cloaking device"
	desc = "Use this to become invisible to the human eyesocket."
	icon = 'device.dmi'
	icon_state = "shield0"
	var/active = 0.0
	flags = FPRINT | TABLEPASS| CONDUCT
	item_state = "electronic"
	throwforce = 10.0
	throw_speed = 2
	throw_range = 10
	w_class = 2.0
	origin_tech = "magnets=3;syndicate=4"

#define MAXCOIL 30
/obj/item/weapon/cable_coil
	name = "cable coil"
	icon = 'power.dmi'
	icon_state = "coil_red"
	var/amount = MAXCOIL
	var/color = "red"
	desc = "A coil of power cable."
	throwforce = 10
	w_class = 2.0
	throw_speed = 2
	throw_range = 5
	flags = TABLEPASS|USEDELAY|FPRINT|CONDUCT
	item_state = "coil_red"

/obj/item/weapon/cable_coil/cut
	item_state = "coil_red2"

/obj/item/weapon/cable_coil/yellow
	color = "yellow"
	icon_state = "coil_yellow"

/obj/item/weapon/cable_coil/blue
	color = "blue"
	icon_state = "coil_blue"

/obj/item/weapon/cable_coil/green
	color = "green"
	icon_state = "coil_green"

/obj/item/weapon/crowbar
	name = "crowbar"
	desc = "Used to hit floors"
	icon = 'items.dmi'
	icon_state = "crowbar"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 5.0
	throwforce = 7.0
	item_state = "wrench"
	w_class = 2.0
	m_amt = 50
	origin_tech = "engineering=1"

/obj/item/weapon/crowbar/red
	icon = 'items.dmi'
	icon_state = "red_crowbar"

/obj/item/weapon/fireaxe  // DEM AXES MAN, marker -Agouri
	icon_state = "fireaxe0"
	name = "Fire axe"
	desc = "Truly, the tool of a madman. Who would possibly think to fight fire with an axe?"
	force = 5
	w_class = 4.0
	flags = ONBACK
	twohanded = 1
	force_unwielded = 5
	force_wielded = 30

/obj/item/weapon/cane
	name = "cane"
	desc = "A cane used by a true gentlemen. Or a clown."
	icon = 'weapons.dmi'
	icon_state = "cane"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 5.0
	throwforce = 7.0
	item_state = "cane"
	w_class = 2.0
	m_amt = 50

/obj/item/weapon/cane/browncane
	name = " browncane"
	icon_state = "browncane"

/obj/item/weapon/disk
	name = "disk"
	icon = 'items.dmi'

/obj/item/weapon/disk/nuclear
	name = "Nuclear Authentication Disk"
	desc = "Better keep this safe."
	icon_state = "nucleardisk"
	item_state = "card-id"
	w_class = 1.0

/obj/item/weapon/dummy
	name = "dummy"
	invisibility = 101.0
	anchored = 1.0
	flags = 2.0

/obj/item/weapon/extinguisher
	name = "fire extinguisher"
	desc = "Contains water....dangit..."
	icon = 'items.dmi'
	icon_state = "fire_extinguisher0"
	var/last_use = 1.0
	var/safety = 1
	hitsound = 'smash.ogg'
	flags = FPRINT | USEDELAY | TABLEPASS | CONDUCT
	throwforce = 10
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 10.0
	item_state = "fire_extinguisher"
	m_amt = 90

/obj/item/weapon/f_card
	name = "Finger Print Card"
	desc = "Used to take fingerprints."
	icon = 'card.dmi'
	icon_state = "fingerprint0"
	var/amount = 10.0
	item_state = "paper"
	throwforce = 1
	w_class = 1.0
	throw_speed = 3
	throw_range = 5


/obj/item/weapon/fcardholder
	name = "Finger Print Case"
	desc = "Apply finger print card."
	icon = 'items.dmi'
	icon_state = "fcardholder0"
	item_state = "clipboard"

/obj/item/weapon/flasks
	name = "flask"
	icon = 'Cryogenic2.dmi'
	var/oxygen = 0.0
	var/plasma = 0.0
	var/coolant = 0.0

/obj/item/weapon/flasks/coolant
	name = "light blue flask"
	icon_state = "coolant-c"
	coolant = 1000.0

/obj/item/weapon/flasks/oxygen
	name = "blue flask"
	icon_state = "oxygen-c"
	oxygen = 500.0

/obj/item/weapon/flasks/plasma
	name = "orange flask"
	icon_state = "plasma-c"
	plasma = 500.0

/*
/obj/item/weapon/game_kit
	name = "Gaming Kit"
	icon = 'items.dmi'
	icon_state = "game_kit"
	var/selected = null
	var/board_stat = null
	var/data = ""
	var/base_url = "http://svn.slurm.us/public/spacestation13/misc/game_kit"
	item_state = "sheet-metal"
	w_class = 5.0
*/

/obj/item/weapon/gift
	name = "gift"
	desc = "A wrapped item."
	icon = 'items.dmi'
	icon_state = "gift3"
	var/size = 3.0
	var/obj/item/gift = null
	item_state = "gift"
	w_class = 4.0

/obj/item/weapon/grab
	name = "grab"
	icon = 'screen1.dmi'
	icon_state = "grabbed"
	var/obj/screen/grab/hud1 = null
	var/mob/affecting = null
	var/mob/assailant = null
	var/state = 1.0
	var/killing = 0.0
	var/allow_upgrade = 1.0
	var/last_suffocate = 1.0
	layer = 21
	abstract = 1.0
	item_state = "nothing"
	w_class = 5.0
/*
/obj/item/weapon/gun
	name = "gun"
	icon = 'gun.dmi'
	flags =  FPRINT | TABLEPASS | CONDUCT | ONBELT | USEDELAY
	item_state = "gun"
	m_amt = 2000
	throwforce = 5
	w_class = 2.0
	throw_speed = 4
	throw_range = 10
	origin_tech = "combat=1"

/obj/item/weapon/gun/shotgun
	name = "shotgun"
	icon_state = "shotgun"
	var/shellsmax
	var/shellsunlimited = 0
	var/index
	var/list/shells = list() //this is a list. All craftsmanship is of good quality. At least, it's better than two/eight vars, Uhangi! -- Barhandar //it is, thanks bro --uhangi
	w_class = 4.0 //dammit urist no
	force = 7.0
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY | ONBACK
	var/pumped = 0
	shellsmax = 2
	origin_tech = "combat=2"

/obj/item/weapon/gun/shotgun/combat
	name = "combat shotgun"
	icon_state = "cshotgun"
	w_class = 4.0
	force = 12.0
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY | ONBACK
	shellsmax = 8
	origin_tech = "combat=3"

/obj/item/weapon/gun/energy
	name = "energy"
	var/charges = 10.0
	var/maximum_charges = 10.0
	origin_tech = "combat=2;magnets=2"

/obj/item/weapon/gun/energy/taser_gun
	name = "taser gun"
	icon_state = "taser"
	w_class = 3.0
	item_state = "gun"
	force = 10.0
	throw_speed = 2
	throw_range = 10
	charges = 4
	maximum_charges = 4
	m_amt = 2000
	origin_tech = "combat=2;magnets=2"

/obj/item/weapon/gun/energy/teleport_gun
	name = "teleport gun"
	desc = "A hacked together combination of a taser and a handheld teleportation unit."
	icon_state = "taser"
	w_class = 3.0
	item_state = "gun"
	force = 10.0
	throw_speed = 2
	throw_range = 10
	charges = 4
	maximum_charges = 4
	m_amt = 2000
	var/failchance = 5
	var/obj/item/target = null
	origin_tech = "combat=2;magnets=2;bluespace=3"

/obj/item/weapon/gun/energy/crossbow // Laaazy
	name = "mini energy-crossbow"
	desc = "A weapon favored by many of the syndicates stealth specialists."
	icon_state = "crossbow"
	w_class = 2.0
	item_state = "crossbow"
	force = 4.0
	throw_speed = 2
	throw_range = 10
	charges = 3
	maximum_charges = 3
	m_amt = 2000
	origin_tech = "combat=2;magnets=2;syndicate=2"

/obj/item/weapon/gun/energy/laser_gun
	name = "laser gun"
	icon_state = "laser"
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 7.0
	m_amt = 2000
	origin_tech = "combat=3;magnets=2"
	var/shot_delay = 0 //used for borg guns, adds that much in deciseconds delay between shots
	var/next_attack = 0 //used for the delay

/obj/item/weapon/gun/energy/laser_gun/captain
	icon_state = "caplaser"
	desc = "This is an antique laser gun. All craftsmanship is of the highest quality. It is decorated with assistant leather and chrome. The object menaces with spikes of energy. On the item is an image of Space Station 13. The station is exploding."
	force = 10
	origin_tech = null

/obj/item/weapon/gun/revolver
	desc = "There are 0 bullets left. Uses 357"
	name = "revolver"
	icon_state = "revolver"
	var/bullets = 0.0
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 24.0
	m_amt = 2000
	origin_tech = "combat=3;materials=2"

/obj/item/weapon/gun/revolver/mateba
	desc = "There are 0 bullets left. Uses 357"
	name = "revolver"
	icon_state = "mateba"
	origin_tech = "combat=3;materials=2"

/obj/item/weapon/gun/c96
	desc = "There are 0 rounds left. Uses 7.63x25 Mauser"
	name = "c96"
	icon_state = "c96"
	var/obj/item/weapon/ammo/a763m/magazine
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 12.0
	m_amt = 2000
//	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/p08
	desc = "There are 0 rounds left. Uses 9x19 Parabellum"
	name = "p08"
	icon_state = "p08empty"
	var/obj/item/weapon/ammo/a9x19p/magazine
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 16.0
	m_amt = 2000
//	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/glock
	desc = "There are 0 rounds left. Uses .45 ACP"
	name = "glock"
	icon_state = "glock"
	var/obj/item/weapon/ammo/a45/magazine
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 6.0
	m_amt = 2000
//	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/m1911
	desc = "There are 0 rounds left. Uses .45 ACP"
	name = "m1911"
	icon_state = "m1911"
	var/obj/item/weapon/ammo/a45/magazine
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 14.0
	m_amt = 2000
//	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/carbine
	desc = "There are 0 rounds left. Uses 5.56x45mm NATO"
	name = "carbine"
	icon_state = "carbinenomag"
	var/obj/item/weapon/ammo/assaultmag/magazine
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY
	w_class = 4.0
	throw_speed = 2
	throw_range = 10
	force = 6.0
	m_amt = 2000
//	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/ak331
	desc = "There are 0 rounds left. Uses 5.56x45mm NATO"
	name = "ak331"
	icon_state = "ak331nomag"
	var/obj/item/weapon/ammo/assaultmag/magazine
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY
	w_class = 4.0
	throw_speed = 2
	throw_range = 10
	force = 18.0
	m_amt = 2000
//	origin_tech = "combat=2;materials=2"

/obj/item/weapon/gun/detectiverevolver
	desc = "A cheap Martian knock-off of a Smith & Wesson Model 10. Uses .38-Special rounds."
	name = ".38 revolver"
	icon_state = "detective"
	var/bullets = 5.0
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 14.0
	m_amt = 1000
	origin_tech = "combat=2;materials=2"
*/

/obj/item/weapon/hand_tele
	name = "hand tele"
	desc = "A portable item using blue-space technology."
	icon = 'device.dmi'
	icon_state = "hand_tele"
	item_state = "electronic"
	throwforce = 5
	w_class = 2.0
	throw_speed = 3
	throw_range = 5
	m_amt = 10000
	origin_tech = "magnets=1;bluespace=3"

/obj/item/weapon/handcuffs
	name = "handcuffs"
	desc = "Use this to keep prisoners in line."
	icon = 'items.dmi'
	icon_state = "handcuff"
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	throwforce = 5
	w_class = 2.0
	throw_speed = 2
	throw_range = 5
	m_amt = 500
	origin_tech = "materials=1"
	var/dispenser = 0

/obj/item/weapon/handcuffs/cyborg
	dispenser = 1


/obj/item/weapon/locator
	name = "locator"
	desc = "Used to track those with locater implants."
	icon = 'device.dmi'
	icon_state = "locator"
	var/temp = null
	var/frequency = 1451
	var/broadcasting = null
	var/listening = 1.0
	flags = FPRINT | TABLEPASS| CONDUCT
	w_class = 2.0
	item_state = "electronic"
	throw_speed = 4
	throw_range = 20
	m_amt = 400
	origin_tech = "magnets=1"



/obj/item/weapon/mop
	desc = "The world of janitalia wouldn't be complete without a mop."
	name = "mop"
	icon = 'janitor.dmi'
	icon_state = "mop"
	var/mopping = 0
	var/mopcount = 0
	force = 3.0
	throwforce = 10.0
	throw_speed = 5
	throw_range = 10
	w_class = 3.0
	flags = FPRINT | TABLEPASS

/obj/item/weapon/caution
	desc = "Caution! Wet Floor!"
	name = "wet floor sign"
	icon = 'janitor.dmi'
	icon_state = "caution"
	force = 1.0
	throwforce = 3.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	flags = FPRINT | TABLEPASS

/obj/item/weapon/banhammer
	desc = "A banhammer"
	name = "Banhammer"
	icon = 'items.dmi'
	icon_state = "toyhammer"
	flags = FPRINT | ONBELT | TABLEPASS
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15

/obj/item/weapon/pen/sleepypen
	desc = "It's a normal black ink pen with a sharp point."
	flags = FPRINT | ONBELT | TABLEPASS | OPENCONTAINER
	origin_tech = "materials=2;biotech=1;syndicate=5"

/obj/item/weapon/rack_parts
	name = "rack parts"
	desc = "Parts of a rack."
	icon = 'items.dmi'
	icon_state = "rack_parts"
	flags = FPRINT | TABLEPASS| CONDUCT
	m_amt = 3750

/obj/item/weapon/rubber_chicken
	name = "Rubber Chicken"
	desc = "A rubber chicken, isn't that hilarious?"
	icon = 'items.dmi'
	icon_state = "rubber_chicken"
	item_state = "rubber_chicken"
	w_class = 2.0

/obj/item/weapon/screwdriver
	name = "screwdriver"
	desc = "You can be totally screwwy with this."
	icon = 'items.dmi'
	icon_state = "screwdriver"
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 5.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	g_amt = 0
	m_amt = 75

/obj/item/weapon/shard
	name = "shard"
	icon = 'shards.dmi'
	icon_state = "large"
	desc = "Could probably be used as ... a throwing weapon?"
	w_class = 3.0
	force = 5.0
	throwforce = 15.0
	item_state = "shard-glass"
	g_amt = 3750

/obj/item/weapon/syndicate_uplink
	name = "station bounced radio"
	desc = "Remain silent about this..."
	icon = 'radio.dmi'
	icon_state = "radio"
	var/temp = null
	var/uses = 10.0
	var/selfdestruct = 0.0
	var/traitor_frequency = 0.0
	var/mob/currentUser = null
	var/obj/item/device/radio/origradio = null
	flags = FPRINT | TABLEPASS | CONDUCT | ONBELT
	w_class = 2.0
	item_state = "radio"
	throw_speed = 4
	throw_range = 20
	m_amt = 100
	origin_tech = "magnets=2;syndicate=3"

/obj/item/weapon/SWF_uplink
	name = "station bounced radio"
	desc = "used to comunicate it appears."
	icon = 'radio.dmi'
	icon_state = "radio"
	var/temp = null
	var/uses = 4.0
	var/selfdestruct = 0.0
	var/traitor_frequency = 0.0
	var/obj/item/device/radio/origradio = null
	flags = FPRINT | TABLEPASS| CONDUCT | ONBELT
	item_state = "radio"
	throwforce = 5
	w_class = 2.0
	throw_speed = 4
	throw_range = 20
	m_amt = 100
	origin_tech = "magnets=1"

/obj/item/weapon/spellbook
	name = "Spell Book"
	desc = "The legendary book of spells of the wizard."
	icon = 'library.dmi'
	icon_state ="book"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
	flags = FPRINT | TABLEPASS
	var/uses = 4.0
	var/temp = null
	var/spell_type = "verb"
	var/max_uses = 5

/obj/item/weapon/spellbook/object_type_spells //used for giving out object spells as opposed to verb spells
	spell_type = "object"

/obj/item/weapon/staff
	name = "wizards staff"
	desc = "Apparently a staff used by the wizard."
	icon = 'wizard.dmi'
	icon_state = "staff"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD


/obj/item/weapon/staff/stick
	name = "stick"
	desc = "A great tool to drag someone else's drinks across the bar."
	icon = 'weapons.dmi'
	icon_state = "stick"
	item_state = "stick"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	flags = FPRINT | TABLEPASS | NOSHIELD

/obj/item/weapon/table_parts
	name = "table parts"
	desc = "Parts of a table. Poor table."
	icon = 'items.dmi'
	icon_state = "table_parts"
	m_amt = 3750
	flags = FPRINT | TABLEPASS| CONDUCT

/obj/item/weapon/table_parts/reinforced
	name = "reinforced table parts"
	desc = "Hard table parts. Well...harder..."
	icon = 'items.dmi'
	icon_state = "reinf_tableparts"
	m_amt = 7500
	flags = FPRINT | TABLEPASS| CONDUCT

/obj/item/weapon/table_parts/wood
	name = "wooden table parts"
	desc = "Keep away from fire."
	icon_state = "wood_tableparts"
	flags = null

/obj/item/weapon/teleportation_scroll
	name = "Teleportation Scroll"
	desc = "A scroll for moving around."
	icon = 'wizard.dmi'
	icon_state = "scroll"
	var/uses = 4.0
	flags = FPRINT | TABLEPASS
	w_class = 2.0
	item_state = "paper"
	throw_speed = 4
	throw_range = 20
	origin_tech = "bluespace=4"

/obj/item/weapon/wire
	desc = "This is just a simple piece of regular insulated wire."
	name = "wire"
	icon = 'power.dmi'
	icon_state = "item_wire"
	var/amount = 1.0
	var/laying = 0.0
	var/old_lay = null
	m_amt = 40

/obj/item/weapon/wrapping_paper
	name = "wrapping paper"
	desc = "You can use this to wrap items in."
	icon = 'items.dmi'
	icon_state = "wrap_paper"
	var/amount = 20.0

/obj/item/weapon/cell
	name = "power cell"
	desc = "A rechargable electrochemical power cell."
	icon = 'power.dmi'
	icon_state = "cell"
	item_state = "cell"
	origin_tech = "powerstorage=1"
	flags = FPRINT|TABLEPASS
	force = 5.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	w_class = 3.0
	pressure_resistance = 80
	var/charge = 0	// note %age conveted to actual charge in New
	var/maxcharge = 1000
	m_amt = 700
	g_amt = 50
	var/rigged = 0		// true if rigged to explode
	var/minor_fault = 0 //If not 100% reliable, it will build up faults.

/obj/item/weapon/cell/crap
	name = "Nanotrassen Brand Rechargable AA Battery"
	desc = "You can't top the plasma top." //TOTALLY TRADEMARK INFRINGEMENT
	origin_tech = "powerstorage=0"
	maxcharge = 500
	g_amt = 40

/obj/item/weapon/cell/high
	name = "high-capacity power cell"
	origin_tech = "powerstorage=2"
	maxcharge = 10000
	g_amt = 60

/obj/item/weapon/cell/super
	name = "super-capacity power cell"
	origin_tech = "powerstorage=3"
	maxcharge = 20000
	g_amt = 70

/obj/item/weapon/cell/hyper
	name = "hyper-capacity power cell"
	origin_tech = "powerstorage=6"
	maxcharge = 30000
	g_amt = 80

/obj/item/weapon/cell/infinite
	name = "infinite-capacity power cell!"
	origin_tech =  null
	maxcharge = 30000
	g_amt = 80
	use()
		return

/*/obj/item/weapon/cell/potato
	name = "Potato Battery"
	desc = "A rechargable starch based power cell."
	icon = 'harvest.dmi'
	icon_state = "potato_battery"
	maxcharge = 100
	m_amt = 0
	g_amt = 0*/

/obj/item/weapon/camera_bug/attack_self(mob/usr as mob)
	var/list/cameras = new/list()
	for (var/obj/machinery/camera/C in world)
		if (C.bugged && C.status)
			cameras.Add(C)
	if (length(cameras) == 0)
		usr << "\red No bugged functioning cameras found."
		return

	var/list/friendly_cameras = new/list()

	for (var/obj/machinery/camera/C in cameras)
		friendly_cameras.Add(C.c_tag)

	var/target = input("Select the camera to observe", null) as null|anything in friendly_cameras
	if (!target)
		return
	for (var/obj/machinery/camera/C in cameras)
		if (C.c_tag == target)
			target = C
			break
	if (usr.stat == 2) return

	usr.client.eye = target


/obj/item/weapon/module
	icon = 'module.dmi'
	icon_state = "std_module"
	w_class = 2.0
	item_state = "electronic"
	flags = FPRINT|TABLEPASS|CONDUCT
	var/mtype = 1						// 1=electronic 2=hardware

/obj/item/weapon/module/card_reader
	name = "card reader module"
	icon_state = "card_mod"
	desc = "An electronic module for reading data and ID cards."

/obj/item/weapon/module/power_control
	name = "power control module"
	icon_state = "power_mod"
	desc = "Heavy-duty switching circuits for power control."

/obj/item/weapon/module/id_auth
	name = "ID authentication module"
	icon_state = "id_mod"
	desc = "A module allowing secure authorization of ID cards."

/obj/item/weapon/module/cell_power
	name = "power cell regulator module"
	icon_state = "power_mod"
	desc = "A converter and regulator allowing the use of power cells."

/obj/item/weapon/module/cell_power
	name = "power cell charger module"
	icon_state = "power_mod"
	desc = "Charging circuits for power cells."


/obj/item/weapon/a_gift
	name = "gift"
	desc = "A gift it appears."
	icon = 'items.dmi'
	icon_state = "gift"
	item_state = "gift"
	pressure_resistance = 70


/obj/item/weapon/camera_bug
	name = "camera bug"
	icon = 'device.dmi'
	icon_state = "flash"
	w_class = 1.0
	item_state = "electronic"
	throw_speed = 4
	throw_range = 20


/obj/item/weapon/kitchen
	icon = 'kitchen.dmi'

/obj/item/weapon/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	force = 8.0
	throwforce = 10.0
	throw_speed = 2
	throw_range = 7
	w_class = 3.0

/obj/item/weapon/kitchenknife
	name = "Kitchen knife"
	icon = 'kitchen.dmi'
	icon_state = "knife"
	desc = "A general purpose Chef's Knife made by SpaceCook Incorporated. Guaranteed to stay sharp for years to come."
	flags = FPRINT | TABLEPASS | CONDUCT
	force = 10.0
	w_class = 3.0
	throwforce = 6.0
	throw_speed = 3
	throw_range = 6
	m_amt = 12000
	origin_tech = "materials=1"

/obj/item/weapon/butch
	name = "Butcher's Cleaver"
	icon = 'kitchen.dmi'
	icon_state = "butch"
	desc = "A huge thing used for chopping and chopping up meat. This includes clowns and clown-by-products."
	flags = FPRINT | TABLEPASS | CONDUCT
	force = 15.0
	w_class = 2.0
	throwforce = 8.0
	throw_speed = 3
	throw_range = 6
	m_amt = 12000
	origin_tech = "materials=1"

/obj/item/weapon/tray
	name = "Tray"
	icon = 'food.dmi'
	icon_state = "tray"
	desc = "A plastic tray to lay food on."
	throwforce = 12.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = 3.0
	flags = FPRINT | TABLEPASS | CONDUCT
	m_amt = 3000
	var/food_total= 0
	var/burger_amt = 0
	var/cheese_amt = 0
	var/fries_amt = 0
	var/classyalcdrink_amt = 0
	var/alcdrink_amt = 0
	var/bottle_amt = 0
	var/soda_amt = 0
	var/carton_amt = 0
	var/pie_amt = 0
	var/meatbreadslice_amt = 0
	var/salad_amt = 0
	var/miscfood_amt = 0


/obj/item/weapon/kitchen/utensil
	force = 5.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	flags = FPRINT | TABLEPASS | CONDUCT
	origin_tech = "materials=1"


/obj/item/weapon/kitchen/utensil/fork
	name = "fork"
	desc = "Pointy."
	icon_state = "fork"

/obj/item/weapon/kitchen/utensil/knife
	name = "knife"
	desc = "Can cut through any food."
	icon_state = "knife"
	force = 10.0
	throwforce = 10.0

/obj/item/weapon/kitchen/utensil/spoon
	name = "spoon"
	desc = "SPOON!"
	icon_state = "spoon"

/obj/item/weapon/scalpel
	name = "scalpel"
	desc = "Cut, cut, and once more cut."
	icon = 'surgery.dmi'
	icon_state = "scalpel"
	flags = FPRINT | TABLEPASS | CONDUCT
	force = 10.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	m_amt = 10000
	g_amt = 5000
	origin_tech = "materials=1;biotech=1"

/obj/item/weapon/retractor
	name = "retractor"
	desc = "Retracts stuff."
	icon = 'surgery.dmi'
	icon_state = "retractor"
	flags = FPRINT | TABLEPASS | CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"

/obj/item/weapon/hemostat
	name = "hemostat"
	desc = "You think you have seen this before."
	icon = 'surgery.dmi'
	icon_state = "hemostat"
	flags = FPRINT | TABLEPASS | CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"

/obj/item/weapon/cautery
	name = "cautery"
	desc = "This stops bleeding."
	icon = 'surgery.dmi'
	icon_state = "cautery"
	flags = FPRINT | TABLEPASS | CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"

/obj/item/weapon/surgicaldrill
	name = "surgical drill"
	desc = "You can drill using this item. You dig?"
	icon = 'surgery.dmi'
	icon_state = "drill"
	flags = FPRINT | TABLEPASS | CONDUCT
	w_class = 1.0
	origin_tech = "materials=1;biotech=1"

/obj/item/weapon/circular_saw
	name = "circular saw"
	desc = "For heavy duty cutting."
	icon = 'surgery.dmi'
	icon_state = "saw"
	flags = FPRINT | TABLEPASS | CONDUCT
	force = 15.0
	w_class = 1.0
	throwforce = 9.0
	throw_speed = 3
	throw_range = 5
	m_amt = 20000
	g_amt = 10000
	origin_tech = "materials=1;biotech=1"

/obj/item/weapon/syntiflesh
	name = "Syntiflesh"
	desc = "Meat that appears...strange..."
	icon = 'food.dmi'
	icon_state = "meat"
	flags = FPRINT | TABLEPASS | CONDUCT
	w_class = 1.0
	origin_tech = "biotech=2"
/*
/obj/item/weapon/cigarpacket
	name = "Pete's Cuban Cigars"
	desc = "The most robust cigars on the planet."
	icon = 'cigarettes.dmi'
	icon_state = "cigarpacket"
	item_state = "cigarpacket"
	w_class = 1
	throwforce = 2
	var/cigarcount = 6
	flags = ONBELT | TABLEPASS */


/obj/item/weapon/mousetrap
	name = "mousetrap"
	desc = "A handy little spring-loaded trap for catching pesty rodents."
	icon = 'weapons.dmi'
	icon_state = "mousetrap"
	item_state = "mousetrap"
	w_class = 1
	force = null
	throwforce = null
	var/armed = 0
	origin_tech = "combat=1"

/obj/item/weapon/mousetrap/armed
	icon_state = "mousetraparmed"
	armed = 1

/obj/item/weapon/dice // -- TLE
	name = "d6"
	desc = "A dice with six sides."
	var/sides = 6
	icon_state = "dice"
	item_state = "dice"

/obj/item/weapon/dice/d20 // -- TLE
	name = "d20"
	desc = "A dice with...hell that is many sides."
	sides = 20
	icon_state = "d20"
	item_state = "dice"

/obj/item/weapon/pai_cable
	desc = "A flexible coated cable with a universal jack on one end."
	desc = "Some spacey cable."
	name = "data cable"
	icon = 'power.dmi'
	icon_state = "wire1"
	var/obj/machinery/machine

/obj/item/weapon/plastique
	name = "Plastic Explosives"
	desc = "Used to put holes in specific areas without too much extra hole."
	icon = 'assemblies.dmi'
	icon_state = "plastic-explosive0"
	item_state = "plasticx"
	flags = FPRINT | TABLEPASS | USEDELAY
	w_class = 2.0
	origin_tech = "syndicate=2"
	var/timer = 10
	var/atom/target = null

///////////////////////////////////////Stock Parts /////////////////////////////////

/obj/item/weapon/stock_parts
	name = "stock part"
	desc = "What?"
	icon = 'stock_parts.dmi'
	var/rating = 1
	New()
		src.pixel_x = rand(-5.0, 5)
		src.pixel_y = rand(-5.0, 5)

//Rank 1

/obj/item/weapon/stock_parts/console_screen
	name = "Console Screen"
	desc = "Used in the construction of computers and other devices with a interactive console."
	icon_state = "screen"
	origin_tech = "materials=1"
	g_amt = 200

/obj/item/weapon/stock_parts/capacitor
	name = "Capacitor"
	desc = "A basic capacitor used in the construction of a variety of devices."
	icon_state = "capacitor"
	origin_tech = "powerstorage=1"
	m_amt = 50
	g_amt = 50

/obj/item/weapon/stock_parts/scanning_module
	name = "Scanning Module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "scan_module"
	origin_tech = "magnets=1"
	m_amt = 50
	g_amt = 20

/obj/item/weapon/stock_parts/manipulator
	name = "Micro-Manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "micro_mani"
	origin_tech = "materials=1;programming=1"
	m_amt = 30

/obj/item/weapon/stock_parts/micro_laser
	name = "Micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "micro_laser"
	origin_tech = "magnets=1"
	m_amt = 10
	g_amt = 20

/obj/item/weapon/stock_parts/matter_bin
	name = "Matter Bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	icon_state = "matter_bin"
	origin_tech = "materials=1"
	m_amt = 80

//Rank 2

/obj/item/weapon/stock_parts/capacitor/adv
	name = "Advanced Capacitor"
	desc = "An advanced capacitor used in the construction of a variety of devices."
	origin_tech = "powerstorage=3"
	rating = 2
	m_amt = 50
	g_amt = 50

/obj/item/weapon/stock_parts/scanning_module/adv
	name = "Advanced Scanning Module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "scan_module"
	origin_tech = "magnets=3"
	rating = 2
	m_amt = 50
	g_amt = 20

/obj/item/weapon/stock_parts/manipulator/nano
	name = "Nano-Manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	icon_state = "micro_mani"
	origin_tech = "materials=3,programming=2"
	rating = 2
	m_amt = 30

/obj/item/weapon/stock_parts/micro_laser/high
	name = "High-Power Micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "micro_laser"
	origin_tech = "magnets=3"
	rating = 2
	m_amt = 10
	g_amt = 20

/obj/item/weapon/stock_parts/matter_bin/adv
	name = "Advanced Matter Bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	icon_state = "matter_bin"
	origin_tech = "materials=3"
	rating = 2
	m_amt = 80

//Rating 3

/obj/item/weapon/stock_parts/capacitor/super
	name = "Super Capacitor"
	desc = "A super-high capacity capacitor used in the construction of a variety of devices."
	origin_tech = "powerstorage=5;materials=4"
	rating = 3
	m_amt = 50
	g_amt = 50

/obj/item/weapon/stock_parts/scanning_module/phasic
	name = "Phasic Scanning Module"
	desc = "A compact, high resolution phasic scanning module used in the construction of certain devices."
	origin_tech = "magnets=5"
	rating = 3
	m_amt = 50
	g_amt = 20

/obj/item/weapon/stock_parts/manipulator/pico
	name = "Pico-Manipulator"
	desc = "A tiny little manipulator used in the construction of certain devices."
	origin_tech = "materials=5,programming=2"
	rating = 3
	m_amt = 30

/obj/item/weapon/stock_parts/micro_laser/ultra
	name = "Ultra-High-Power Micro-laser"
	desc = "A tiny laser used in certain devices."
	origin_tech = "magnets=5"
	rating = 3
	m_amt = 10
	g_amt = 20

/obj/item/weapon/stock_parts/matter_bin/super
	name = "Super Matter Bin"
	desc = "A container for hold compressed matter awaiting re-construction."
	origin_tech = "materials=5"
	rating = 3
	m_amt = 80

/*

/obj/item/weapon/katanasword
	name = "Katana"
	desc = "A japanese samurai sword."
	icon = 'weapons.dmi'
	icon_state =
	item_state =
	origin_tech = "materials=5,bluespace=10"
	rating = 3
	m_amt = 80

*/