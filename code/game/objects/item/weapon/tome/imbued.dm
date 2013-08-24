
/obj/item/weapon/tome/imbued //admin tome, spawns working runes without waiting
	w_class = 2.0
	var/cultistsonly = 1
	attack_self(mob/user as mob)
		if (src.cultistsonly && !iscultist(usr))
			return
		if (!wordtravel)
			runerandom()
		if (user)
			var/r
			if (!istype(user.loc,/turf))
				user << "\red You do not have enough space to write a proper rune."
			var/list/runes = list("teleport", "itemport", "tome", "convert", "tear in reality", "emp", "drain", "seer", "raise", "obscure", "reveal", "astral journey", "manifest", "imbue talisman", "sacrifice", "wall", "freedom", "cultsummon", "deafen", "blind", "bloodboil", "communicate", "stun")
			r = input("Choose a rune to scribe", "Rune Scribing") in runes //not cancellable.
			var/obj/rune/R = new /obj/rune
			if (istype(user, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = user
				R.blood_DNA = H.dna.unique_enzymes
				R.blood_type = H.b_type
			switch(r)
				if ("teleport")
					var/list/words = list("ire", "ego", "nahlizet", "certum", "veri", "jatkaa", "balaq", "mgar", "karazet", "geeri")
					var/beacon
					if (usr)
						beacon = input("Select the last rune", "Rune Scribing") in words
					R.word1=wordtravel
					R.word2=wordself
					R.word3=beacon
					R.loc = user.loc
					R.check_icon()
				if ("itemport")
					var/list/words = list("ire", "ego", "nahlizet", "certum", "veri", "jatkaa", "balaq", "mgar", "karazet", "geeri")
					var/beacon
					if (usr)
						beacon = input("Select the last rune", "Rune Scribing") in words
					R.word1=wordtravel
					R.word2=wordother
					R.word3=beacon
					R.loc = user.loc
					R.check_icon()
				if ("tome")
					R.word1=wordsee
					R.word2=wordblood
					R.word3=wordhell
					R.loc = user.loc
					R.check_icon()
				if ("armor")
					R.word1=wordhell
					R.word2=worddestr
					R.word3=wordother
					R.loc = user.loc
					R.check_icon()
				if ("convert")
					R.word1=wordjoin
					R.word2=wordblood
					R.word3=wordself
					R.loc = user.loc
					R.check_icon()
				if ("tear in reality")
					R.word1=wordhell
					R.word2=wordjoin
					R.word3=wordself
					R.loc = user.loc
					R.check_icon()
				if ("emp")
					R.word1=worddestr
					R.word2=wordsee
					R.word3=wordtech
					R.loc = user.loc
					R.check_icon()
				if ("drain")
					R.word1=wordtravel
					R.word2=wordblood
					R.word3=wordself
					R.loc = user.loc
					R.check_icon()
				if ("seer")
					R.word1=wordsee
					R.word2=wordhell
					R.word3=wordjoin
					R.loc = user.loc
					R.check_icon()
				if ("raise")
					R.word1=wordblood
					R.word2=wordjoin
					R.word3=wordhell
					R.loc = user.loc
					R.check_icon()
				if ("obscure")
					R.word1=wordhide
					R.word2=wordsee
					R.word3=wordblood
					R.loc = user.loc
					R.check_icon()
				if ("astral journey")
					R.word1=wordhell
					R.word2=wordtravel
					R.word3=wordself
					R.loc = user.loc
					R.check_icon()
				if ("manifest")
					R.word1=wordblood
					R.word2=wordsee
					R.word3=wordtravel
					R.loc = user.loc
					R.check_icon()
				if ("imbue talisman")
					R.word1=wordhell
					R.word2=wordtech
					R.word3=wordjoin
					R.loc = user.loc
					R.check_icon()
				if ("sacrifice")
					R.word1=wordhell
					R.word2=wordblood
					R.word3=wordjoin
					R.loc = user.loc
					R.check_icon()
				if ("reveal")
					R.word1=wordblood
					R.word2=wordsee
					R.word3=wordhide
					R.loc = user.loc
					R.check_icon()
				if ("wall")
					R.word1=worddestr
					R.word2=wordtravel
					R.word3=wordself
					R.loc = user.loc
					R.check_icon()
				if ("freedom")
					R.word1=wordtravel
					R.word2=wordtech
					R.word3=wordother
					R.loc = user.loc
					R.check_icon()
				if ("cultsummon")
					R.word1=wordjoin
					R.word2=wordother
					R.word3=wordself
					R.loc = user.loc
					R.check_icon()
				if ("deafen")
					R.word1=wordhide
					R.word2=wordother
					R.word3=wordsee
					R.loc = user.loc
					R.check_icon()
				if ("blind")
					R.word1=worddestr
					R.word2=wordsee
					R.word3=wordother
					R.loc = user.loc
					R.check_icon()
				if ("bloodboil")
					R.word1=worddestr
					R.word2=wordsee
					R.word3=wordblood
					R.loc = user.loc
					R.check_icon()
				if ("communicate")
					R.word1=wordself
					R.word2=wordother
					R.word3=wordtech
					R.loc = user.loc
					R.check_icon()
				if ("stun")
					R.word1=wordjoin
					R.word2=wordhide
					R.word3=wordtech
					R.loc = user.loc
					R.check_icon()
