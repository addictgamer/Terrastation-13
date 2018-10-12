/obj/structure/spacepod_frame
	density = 1
	opacity = 0

	anchored = 1
	layer = 3.9

	icon = 'icons/goonstation/48x48/pod_construction.dmi'
	icon_state = "pod_1"

	var/datum/construction/construct

/obj/structure/spacepod_frame/New()
	..()
	bound_width = 64
	bound_height = 64

	construct = new /datum/construction/reversible/pod(src)

	dir = EAST

/obj/structure/spacepod_frame/Destroy()
	QDEL_NULL(construct)
	return ..()

/obj/structure/spacepod_frame/attackby(obj/item/W as obj, mob/user as mob, params)
	if(!construct || !construct.action(W, user))
		..()
	return

/obj/structure/spacepod_frame/attack_hand()
	return



/////////////////////////////////
// CONSTRUCTION STEPS
/////////////////////////////////
/datum/construction/reversible/pod/custom_action(index, diff, atom/used_atom, mob/user)
	if(!..())
		return 0

	holder.icon_state = "pod_[steps.len - index + 1 - diff]"
	return 1
/datum/construction/reversible/pod/action(atom/used_atom,mob/user)
	return check_step(used_atom,user)

/datum/construction/reversible/pod
	result = /obj/spacepod/civilian
//	base_icon="pod"
	//taskpath = /datum/job_objective/make_pod
	steps = list(

				// 12. Bolted-down armor
				list(
					"desc" = "A space pod with unsecured armor.",
					"backstep" = list(
						"key"      = /obj/item/weapon/wrench,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s armor.",
						"verb_2nd" = "unsecure",
						"verb_3rd" = "unsecures"
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/weldingtool,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s armor.",
						"verb_2nd" = "weld",
						"verb_3rd" = "welds"
					)
				),

				// 11. Loose armor
				list(
					"desc" = "A space pod with unsecured armor.",
					"backstep" = list(
						"key"      = /obj/item/weapon/crowbar,
						"vis_msg"  = "{USER} {VERB} off {HOLDER}'s armor.",
						"verb_2nd" = "pry",
						"verb_3rd" = "pries",
						"spawn"    = /obj/item/pod_parts/armor,
						"amount"   = 1
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/wrench,
						"vis_msg"  = "{USER} {VERB} down the {HOLDER}'s armor.",
						"verb_2nd" = "bolt",
						"verb_3rd" = "bolts"
					)
				),

				// 10. Welded bulkhead
				list(
					"desc" = "A space pod with sealed bulkhead panelling exposed.",
					"backstep" = list(
						"key"      = /obj/item/weapon/weldingtool,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s bulkhead panelling loose.",
						"verb_2nd" = "cut",
						"verb_3rd" = "cuts"
					),
					"nextstep" = list(
						"key"      = /obj/item/pod_parts/armor,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s armor plating.",
						"verb_2nd" = "install",
						"verb_3rd" = "installs",
						"amount"   = 1
					)
				),

				// 9. Bulkhead secured with bolts
				list(
					"desc" = "A space pod with unwelded bulkhead panelling exposed.",
					"backstep" = list(
						"key"      = /obj/item/weapon/wrench,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s bulkhead panelling.",
						"verb_2nd" = "unbolt",
						"verb_3rd" = "unbolts"
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/weldingtool,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s bulkhead panelling with a weld.",
						"verb_2nd" = "seal",
						"verb_3rd" = "seals"
					)
				),

				// 8. Bulkhead added
				list(
					"desc" = "A space pod with loose bulkhead panelling exposed.",
					"backstep" = list(
						"key"      = /obj/item/weapon/crowbar,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s bulkhead panelling loose.",
						"verb_2nd" = "pop",
						"verb_3rd" = "pops",

						"spawn"    = /obj/item/stack/sheet/metal,
						"amount"   = 5,
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/wrench,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s bulkhead panelling.",
						"verb_2nd" = "secure",
						"verb_3rd" = "secures"
					)
				),
				// 7. Core secured
				list(
					"desc" = "A naked space pod with an exposed core. How lewd.",
					"backstep" = list(
						"key"      = /obj/item/weapon/wrench,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s core.",
						"verb_2nd" = "unsecure",
						"verb_3rd" = "unsecures"
					),
					"nextstep" = list(
						"key"      = /obj/item/stack/sheet/metal,
						"amount"   = 5,
						"vis_msg"  = "{USER} {VERB} a pressure bulkhead for the {HOLDER}.",
						"verb_2nd" = "fabricate",
						"verb_3rd" = "fabricates"
					)
				),
				// 6. Core inserted
				list(
					"desc" = "A naked space pod with a loose core.",
					"backstep" = list(
						"key"      = /obj/item/weapon/crowbar,
						"vis_msg"  = "{USER} {VERB} the core from the {HOLDER} with a crowbar.",
						"verb_2nd" = "delicately remove",
						"verb_3rd" = "delicately removes",

						"spawn"    = /obj/item/pod_parts/core,
						"amount"   = 1
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/wrench,
						"vis_msg"  = "{USER} {VERB} the core's bolts.",
						"verb_2nd" = "secure",
						"verb_3rd" = "secures"
					)
				),
				// 5. Circuit secured
				list(
					"desc" = "A wired pod frame with a secured mainboard.",
					"backstep" = list(
						"key"      = /obj/item/weapon/screwdriver,
						"vis_msg"  = "{USER} {VERB} the mainboard.",
						"verb_2nd" = "unscrew",
						"verb_3rd" = "unsecure"
					),
					"nextstep" = list(
						"key"      = /obj/item/pod_parts/core,
						,
						"vis_msg"  = "{USER} {VERB} the core into the {HOLDER}.",
						"verb_2nd" = "carefully insert",
						"verb_3rd" = "inserts",
						"amount"   = 1
					)
				),

				// 4. Circuit added
				list(
					"desc" = "A wired pod frame with a loose mainboard.",
					"backstep" = list(
						"key"      = /obj/item/weapon/crowbar,
						"vis_msg"  = "{USER} {VERB} out the mainboard.",
						"verb_2nd" = "pry",
						"verb_3rd" = "pries",
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/screwdriver,
						"vis_msg"  = "{USER} {VERB} the mainboard.",
						"verb_2nd" = "secure",
						"verb_3rd" = "secures"
					)
				),

				// 3. Cleanly wired
				list(
					"desc" = "A wired pod frame.",
					"backstep" = list(
						"key"      = /obj/item/weapon/screwdriver,
						"vis_msg"  = "{USER} {VERB} {HOLDER}'s wiring harnesses.",
						"verb_2nd" = "unclip",
						"verb_3rd" = "unclips"
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/circuitboard/mecha/pod,
						"vis_msg"  = "{USER} {VERB} the mainboard into the {HOLDER}.",
						"verb_2nd" = "insert",
						"verb_3rd" = "inserts",
						"amount"   = 1
					)
				),

				// 2. Crudely Wired
				list(
					"desc" = "A crudely-wired pod frame.",
					"backstep" = list(
						"key"      = /obj/item/weapon/wirecutters,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}'s wiring.",
						"verb_2nd" = "remove",
						"verb_3rd" = "cuts out"
					),
					"nextstep" = list(
						"key"      = /obj/item/weapon/screwdriver,
						"vis_msg"  = "{USER} {VERB} the wiring.",
						"verb_2nd" = "adjust",
						"verb_3rd" = "adjusts"
					)
				),

				// 1. Initial state
				list(
					"desc" = "An empty pod frame.",
					"nextstep" = list(
						"key"      = /obj/item/stack/cable_coil,
						"amount"   = 15,
						"vis_msg"  = "{USER} {VERB} the {HOLDER}.",
						"verb_2nd" = "wire",
						"verb_3rd" = "wires"
					)
				)

				// EOF
			)

	spawn_result(mob/user as mob)
		..()
		feedback_inc("spacepod_created",1)
		return