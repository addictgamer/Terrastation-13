
/obj/manifest
	name = "manifest"
	icon = 'screen1.dmi'
	icon_state = "x"
	unacidable = 1//Just to be sure.

	New()
		src.invisibility = 101
		return

	proc
		manifest()
			var/dat = "<B>Crew Manifest</B>:<BR>"
			for(var/mob/living/carbon/human/M in world)
				dat += text("    <B>[]</B> -  []<BR>", M.name, M.get_assignment())
			var/obj/item/paper/P = new /obj/item/paper( src.loc )
			P.info = dat
			P.name = "paper- 'Crew Manifest'"
			//SN src = null
			del(src)
			return
