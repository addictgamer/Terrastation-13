
/obj/machinery/vending/wallmed2
	name = "NanoMed"
	desc = "Wall-mounted Medical Equipment dispenser."
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	req_access_txt = "5"
	product_paths = "/obj/item/weapon/reagent_containers/syringe/inaprovaline;/obj/item/weapon/reagent_containers/syringe/antitoxin;/obj/item/stack/medical/bruise_pack;/obj/item/stack/medical/ointment;/obj/item/device/healthanalyzer"
	product_amounts = "5;3;3;3;3"
	product_hidden = "/obj/item/weapon/reagent_containers/pill/tox"
	product_hideamt = "3"
	density = 0 //It is wall-mounted, and thus, not dense. --Superxpdude
