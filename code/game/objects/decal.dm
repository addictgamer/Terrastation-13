
/obj/decal
	anchored = 1

/obj/decal/ash
	name = "Ashes"
	desc = "Ashes to ashes, dust to dust, and into space."
	icon = 'objects.dmi'
	icon_state = "ash"

/obj/decal/remains
	name = "remains"
	desc = "These remains have a strange sense about them..."
	icon = 'blood.dmi'

/obj/decal/remains/human
	icon_state = "remains"

/obj/decal/remains/xeno
	icon_state = "remainsxeno"

/obj/decal/remains/robot
	icon_state = "remainsrobot"

/obj/decal/point
	name = "point"
	desc = "It is an arrow hanging in mid-air. There may be a wizard about."
	icon = 'screen1.dmi'
	icon_state = "arrow"
	layer = 16.0

/obj/decal/point/point()
	set src in oview()
	set hidden = 1
	return

/obj/decal/cleanable
	density = 0

/obj/decal/cleanable/oil
	name = "motor oil"
	desc = "It's black. Beepsky made another mess."
	icon = 'robots.dmi'
	icon_state = "floor1"
	var/viruses = list()
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")

	Del()
		for(var/datum/disease/D in viruses)
			D.cure(0)
		..()

/obj/decal/cleanable/oil/streak
	random_icon_states = list("streak1", "streak2", "streak3", "streak4", "streak5")

//OTHER

/obj/decal/cleanable/generic
	name = "clutter"
	desc = "Someone should clean that up."
	layer = 2
	icon = 'objects.dmi'
	icon_state = "shards"

/obj/decal/cleanable/dirt
	name = "dirt"
	desc = "Someone should clean that up."
	layer = 2
	icon = 'effects.dmi'
	icon_state = "dirt"

/obj/decal/cleanable/greenglow
	name = "green glow"
	desc = "Eerie. This makes you feel creepy."
	layer = 2
	icon = 'effects.dmi'
	icon_state = "greenglow"

/obj/decal/cleanable/molten_item
	name = "gooey grey mass"
	desc = "Huh. Creepy..."
	layer = 3
	icon = 'chemical.dmi'
	icon_state = "molten"

/obj/decal/cleanable/cobweb
	name = "cobweb"
	desc = "Someone should remove that."
	layer = 3
	icon = 'effects.dmi'
	icon_state = "cobweb1"

/obj/decal/cleanable/cobweb2
	name = "cobweb"
	desc = "Someone should remove that."
	layer = 3
	icon = 'effects.dmi'
	icon_state = "cobweb2"

//Vomit (sorry)
/obj/decal/cleanable/vomit
	name = "Vomit"
	desc = "Gosh, how unpleasant."
	layer = 2
	icon = 'blood.dmi'
	icon_state = "vomit_1"
	random_icon_states = list("vomit_1", "vomit_2", "vomit_3", "vomit_4")
	var/list/viruses = list()

	Del()
		for(var/datum/disease/D in viruses)
			D.cure(0)
		..()

/obj/decal/cleanable/tomato_smudge
	name = "Tomato smooth"
	desc = "It's red"
	layer = 2
	icon = 'tomatodecal.dmi'
	random_icon_states = list("tomato_floor1", "tomato_floor2", "tomato_floor3")

/obj/decal/cleanable/egg_smudge
	name = "Smashed egg"
	desc = ""
	layer = 2
	icon = 'tomatodecal.dmi'
	random_icon_states = list("smashed_egg1", "smashed_egg2", "smashed_egg3")

/obj/decal/cleanable/crayon
	name = "rune"
	desc = "A rune drawn in crayon."
	icon = 'rune.dmi'
	layer = 2.1
	anchored = 1

/obj/decal/cleanable/crayon/New(location,main = "#FFFFFF",shade = "#000000",var/type = "rune")
	..()
	loc = location

	name = type
	desc = "A [type] drawn in crayon."

	switch(type)
		if("rune")
			type = "rune[rand(1,6)]"
		if("graffiti")
			type = pick("amyjon","face","matt","revolution","engie","guy","end","dwarf","uboa")

	var/icon/mainOverlay = new/icon('crayondecal.dmi',"[type]",2.1)
	var/icon/shadeOverlay = new/icon('crayondecal.dmi',"[type]s",2.1)

	mainOverlay.Blend(main,ICON_ADD)
	shadeOverlay.Blend(shade,ICON_ADD)

	overlays += mainOverlay
	overlays += shadeOverlay
// Used for spray that you spray at walls, tables, hydrovats etc
/obj/decal/spraystill
	layer = 50
