
/obj/item/weapon/storage/lglo_kit
	name = "Latex Gloves"
	desc = "Contains white gloves."
	icon_state = "latex"
	item_state = "syringe_kit"

/obj/item/weapon/storage/lglo_kit/New()

	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/gloves/latex( src )
	new /obj/item/clothing/gloves/latex( src )
	..()
	return

/obj/item/weapon/storage/blankbox
	name = "blank shells"
	desc = "A box containing...stuff..."
	icon_state = "box"
	item_state = "syringe_kit"

/obj/item/weapon/storage/blankbox/New()

	new /obj/item/ammo_casing/shotgun/blank( src )
	new /obj/item/ammo_casing/shotgun/blank( src )
	new /obj/item/ammo_casing/shotgun/blank( src )
	new /obj/item/ammo_casing/shotgun/blank( src )
	new /obj/item/ammo_casing/shotgun/blank( src )
	new /obj/item/ammo_casing/shotgun/blank( src )
	new /obj/item/ammo_casing/shotgun/blank( src )
	..()
	return

/obj/item/weapon/storage/flashbang_kit
	desc = "<FONT color=red><B>WARNING: Do not use without reading these preautions!</B></FONT>\n<B>These devices are extremely dangerous and can cause blindness or deafness if used incorrectly.</B>\nThe chemicals contained in these devices have been tuned for maximal effectiveness and due to\nextreme safety precuaiotn shave been incased in a tamper-proof pack. DO NOT ATTEMPT TO OPEN\nFLASH WARNING: Do not use continually. Excercise extreme care when detonating in closed spaces.\n\tMake attemtps not to detonate withing range of 2 meters of the intended target. It is imperative\n\tthat the targets visit a medical professional after usage. Damage to eyes increases extremely per\n\tuse and according to range. Glasses with flash resistant filters DO NOT always work on high powered\n\tflash devices such as this. <B>EXERCISE CAUTION REGARDLESS OF CIRCUMSTANCES</B>\nSOUND WARNING: Do not use continually. Visit a medical professional if hearing is lost.\n\tThere is a slight chance per use of complete deafness. Exercise caution and restraint.\nSTUN WARNING: If the intended or unintended target is too close to detonation the resulting sound\n\tand flash have been known to cause extreme sensory overload resulting in temporary\n\tincapacitation.\n<B>DO NOT USE CONTINUALLY</B>\nOperating Directions:\n\t1. Pull detonnation pin. <B>ONCE THE PIN IS PULLED THE GRENADE CAN NOT BE DISARMED!</B>\n\t2. Throw grenade. <B>NEVER HOLD A LIVE FLASHBANG</B>\n\t3. The grenade will detonste 10 seconds hafter being primed. <B>EXCERCISE CAUTION</B>\n\t-<B>Never prime another grenade until after the first is detonated</B>\nNote: Usage of this pyrotechnic device without authorization is an extreme offense and can\nresult in severe punishment upwards of <B>10 years in prison per use</B>.\n\nDefault 3 second wait till from prime to detonation. This can be switched with a screwdriver\nto 10 seconds.\n\nCopyright of Nanotrasen Industries- Military Armnaments Division\nThis device was created by Nanotrasen Labs a member of the Expert Advisor Corporation"
	name = "Flashbangs (WARNING)"
	icon_state = "flashbang"
	item_state = "syringe_kit"

/obj/item/weapon/storage/flashbang_kit/New()

	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	..()
	return

/obj/item/weapon/storage/emp_kit
	desc = "A box with 5 emp grenades."
	name = "emp grenades"
	icon_state = "flashbang"
	item_state = "syringe_kit"

/obj/item/weapon/storage/emp_kit/New()

	new /obj/item/weapon/empgrenade( src )
	new /obj/item/weapon/empgrenade( src )
	new /obj/item/weapon/empgrenade( src )
	new /obj/item/weapon/empgrenade( src )
	new /obj/item/weapon/empgrenade( src )
	..()
	return

/obj/item/weapon/storage/stma_kit
	name = "Sterile Masks"
	desc = "This box contains masks of sterility."
	icon_state = "latex"
	item_state = "syringe_kit"

/obj/item/weapon/storage/stma_kit/New()

	new /obj/item/clothing/mask/surgical( src )
	new /obj/item/clothing/mask/surgical( src )
	new /obj/item/clothing/mask/surgical( src )
	new /obj/item/clothing/mask/surgical( src )
	new /obj/item/clothing/mask/surgical( src )
	new /obj/item/clothing/mask/surgical( src )
	new /obj/item/clothing/mask/surgical( src )
	..()
	return

/obj/item/weapon/storage/gl_kit
	name = "Prescription Glasses"
	desc = "This box contains nerd glasses."
	icon_state = "glasses"
	item_state = "syringe_kit"

/obj/item/weapon/storage/gl_kit/New()

	new /obj/item/clothing/glasses/regular( src )
	new /obj/item/clothing/glasses/regular( src )
	new /obj/item/clothing/glasses/regular( src )
	new /obj/item/clothing/glasses/regular( src )
	new /obj/item/clothing/glasses/regular( src )
	new /obj/item/clothing/glasses/regular( src )
	new /obj/item/clothing/glasses/regular( src )
	..()
	return

/obj/item/weapon/storage/trackimp_kit
	name = "Tracking Implant Kit"
	desc = "Box full of scum-bag tracking utensils."
	icon_state = "implant"
	item_state = "syringe_kit"

/obj/item/weapon/storage/trackimp_kit/New()

	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implanter( src )
	new /obj/item/weapon/implantpad( src )
	new /obj/item/weapon/locator( src )
	..()
	return

/obj/item/weapon/storage/chemimp_kit
	name = "Chemical Implant Kit"
	desc = "Box of stuff used to implant chemicals."
	icon_state = "implant"
	item_state = "syringe_kit"

/obj/item/weapon/storage/chemimp_kit/New()

	new /obj/item/weapon/implantcase/chem( src )
	new /obj/item/weapon/implantcase/chem( src )
	new /obj/item/weapon/implantcase/chem( src )
	new /obj/item/weapon/implantcase/chem( src )
	new /obj/item/weapon/implantcase/chem( src )
	new /obj/item/weapon/implanter( src )
	new /obj/item/weapon/implantpad( src )
	..()
	return

/obj/item/weapon/storage/injectbox
	name = "DNA-Injectors"
	desc = "This box contains injectors it seems."
	icon_state = "box"
	item_state = "syringe_kit"

/obj/item/weapon/storage/injectbox/New()

	new /obj/item/weapon/dnainjector/h2m( src )
	new /obj/item/weapon/dnainjector/h2m( src )
	new /obj/item/weapon/dnainjector/h2m( src )
	new /obj/item/weapon/dnainjector/m2h( src )
	new /obj/item/weapon/dnainjector/m2h( src )
	new /obj/item/weapon/dnainjector/m2h( src )

	..()
	return

/obj/item/weapon/storage/fcard_kit
	name = "Fingerprint Cards"
	desc = "This contains cards which are used to take fingerprints."
	icon_state = "id"
	item_state = "syringe_kit"

/obj/item/weapon/storage/fcard_kit/New()

	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	..()
	return

/obj/item/weapon/storage/id_kit
	name = "Spare IDs"
	desc = "Has so many empty IDs."
	icon_state = "id"
	item_state = "syringe_kit"

/obj/item/weapon/storage/id_kit/New()

	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	..()
	return

/obj/item/weapon/storage/handcuff_kit
	name = "Spare Handcuffs"
	desc = "A box full of handcuffs."
	icon_state = "handcuff"
	item_state = "syringe_kit"

/obj/item/weapon/storage/handcuff_kit/New()

	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	..()
	return

/obj/item/weapon/storage/donkpocket_kit
	name = "Donk-Pockets"
	desc = "Remember to fully heat prior to serving.  Product will cool if not eaten within seven minutes."
	icon_state = "donk_kit"
	item_state = "syringe_kit"

/obj/item/weapon/storage/donkpocket_kit/New()

	new /obj/item/weapon/reagent_containers/food/snacks/donkpocket( src )
	new /obj/item/weapon/reagent_containers/food/snacks/donkpocket( src )
	new /obj/item/weapon/reagent_containers/food/snacks/donkpocket( src )
	new /obj/item/weapon/reagent_containers/food/snacks/donkpocket( src )
	new /obj/item/weapon/reagent_containers/food/snacks/donkpocket( src )
	new /obj/item/weapon/reagent_containers/food/snacks/donkpocket( src )
	..()
	return

/obj/item/weapon/storage/condimentbottles
	name = "Condiment Bottles"
	desc = "A box of empty condiment bottles."
	icon_state = "box"
	item_state = "syringe_kit"

/obj/item/weapon/storage/condimentbottles/New()

	new /obj/item/weapon/reagent_containers/food/condiment( src )
	new /obj/item/weapon/reagent_containers/food/condiment( src )
	new /obj/item/weapon/reagent_containers/food/condiment( src )
	new /obj/item/weapon/reagent_containers/food/condiment( src )
	new /obj/item/weapon/reagent_containers/food/condiment( src )
	new /obj/item/weapon/reagent_containers/food/condiment( src )
	..()
	return

/obj/item/weapon/storage/drinkingglasses
	name = "Drinking Glasses"
	desc = "A box of clean drinking glasses"
	icon_state = "box"
	item_state = "syringe_kit"

/obj/item/weapon/storage/drinkingglasses/New()

	new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( src )
	new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( src )
	new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( src )
	new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( src )
	new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( src )
	new /obj/item/weapon/reagent_containers/food/drinks/drinkingglass( src )
	..()
	return

/obj/item/weapon/storage/disk_kit
	name = "data disks"
	desc = "For disks."
	icon_state = "id"
	item_state = "syringe_kit"

/obj/item/weapon/storage/disk_kit/disks

/*
/obj/item/weapon/storage/disk_kit/disks/New()

	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	..()
	return
*/

/obj/item/weapon/storage/disk_kit/disks2

/*
/obj/item/weapon/storage/disk_kit/disks2/New()

	spawn( 2 )
		for(var/obj/item/weapon/card/data/D in src.loc)
			D.loc = src
			//Foreach goto(23)
		return
	..()
	return
*/