
/obj/secure_closet/kitchen
	name = "Kitchen Cabinet"
	req_access = list(access_kitchen)

/obj/secure_closet/kitchen/New()
	..()
	sleep(2)
	/*new /obj/item/clothing/head/chefhat(src)
	new /obj/item/clothing/head/chefhat(src)
	new /obj/item/clothing/under/rank/chef(src)
	new /obj/item/clothing/under/rank/chef(src)*/
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/snacks/flour(src)
	new /obj/item/weapon/reagent_containers/food/condiment/sugar(src)
	/*new /obj/item/weapon/tray(src)
	new /obj/item/weapon/tray(src)
	new /obj/item/weapon/tray(src)
	new /obj/item/weapon/tray(src)
	new /obj/item/weapon/tray(src)
	new /obj/item/weapon/tray(src)
	new /obj/item/weapon/kitchenknife(src)*/
	/*new /obj/item/clothing/head/chefhat(src)
	new /obj/item/clothing/head/chefhat(src)
	new /obj/item/clothing/under/rank/chef(src)
	new /obj/item/clothing/under/rank/chef(src)
	new /obj/item/weapon/kitchen/utensil/fork(src)
	new /obj/item/weapon/kitchen/utensil/knife(src)
	new /obj/item/weapon/kitchen/utensil/spoon(src)
	new /obj/item/weapon/kitchen/rollingpin(src)*/

/obj/secure_closet/meat
	name = "Meat Fridge"
	icon_state = "fridge1"
	icon_closed = "fridge"
	icon_locked = "fridge1"
	icon_opened = "fridgeopen"
	icon_broken = "fridgebroken"
	icon_off = "fridge1"

/obj/secure_closet/meat/New()
	..()
	sleep(2)
	new /obj/item/kitchen/egg_box(src)
	new /obj/item/kitchen/egg_box(src)
	new /obj/item/weapon/reagent_containers/food/snacks/meat/monkey(src)
	new /obj/item/weapon/reagent_containers/food/snacks/meat/monkey(src)
	new /obj/item/weapon/reagent_containers/food/snacks/meat/monkey(src)
	new /obj/item/weapon/reagent_containers/food/snacks/meat/monkey(src)

/obj/secure_closet/fridge
	name = "Refrigerator"
	icon_state = "fridge1"
	icon_closed = "fridge"
	icon_locked = "fridge1"
	icon_opened = "fridgeopen"
	icon_broken = "fridgebroken"
	icon_off = "fridge1"

/obj/secure_closet/fridge/New()
	..()
	sleep(2)
	new /obj/item/weapon/reagent_containers/food/drinks/milk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/milk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/milk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/milk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/milk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/soymilk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/soymilk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/soymilk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/soymilk(src)
	new /obj/item/weapon/reagent_containers/food/drinks/soymilk(src)

/obj/secure_closet/money_freezer
	name = "Freezer"
	icon_state = "fridge1"
	icon_closed = "fridge"
	icon_locked = "fridge1"
	icon_opened = "fridgeopen"
	icon_broken = "fridgebroken"
	icon_off = "fridge1"
	req_access = list(access_heads_vault)

/obj/secure_closet/money_freezer/New()
	..()
	sleep(2)
	new /obj/item/weapon/spacecash/c1000(src)
	new /obj/item/weapon/spacecash/c1000(src)
	new /obj/item/weapon/spacecash/c1000(src)
	new /obj/item/weapon/spacecash/c500(src)
	new /obj/item/weapon/spacecash/c500(src)
	new /obj/item/weapon/spacecash/c500(src)
	new /obj/item/weapon/spacecash/c500(src)
	new /obj/item/weapon/spacecash/c500(src)
	new /obj/item/weapon/spacecash/c200(src)
	new /obj/item/weapon/spacecash/c200(src)
	new /obj/item/weapon/spacecash/c200(src)
	new /obj/item/weapon/spacecash/c200(src)
	new /obj/item/weapon/spacecash/c200(src)
	new /obj/item/weapon/spacecash/c200(src)

/*
/obj/secure_closet/kitchen/mining
	req_access = list()
*/
