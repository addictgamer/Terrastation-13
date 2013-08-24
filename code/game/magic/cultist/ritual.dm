
var
	wordtravel = null
	wordself = null
	wordsee = null
	wordhell = null
	wordblood = null
	wordjoin = null
	wordtech = null
	worddestr = null
	wordother = null
	//wordhear = null
	//wordfree = null
	wordhide = null
	runedec = 0
	engwords = list("travel", "blood", "join", "hell", "destroy", "technology", "self", "see", "other", "hide")

/client
	proc
		check_words() // -- Urist
			set category = "Special Verbs"
			set name = "Check Rune Words"
			set desc = "Check the rune-word meaning"
			if (!wordtravel)
				runerandom()
			usr << "[wordtravel] is travel, [wordblood] is blood, [wordjoin] is join, [wordhell] is Hell, [worddestr] is destroy, [wordtech] is technology, [wordself] is self, [wordsee] is see, [wordother] is other, [wordhide] is hide."


/proc
	runerandom() //randomizes word meaning
		var/list/runewords=list("ire","ego","nahlizet","certum","veri","jatkaa","mgar","balaq", "karazet", "geeri") ///"orkan" and "allaq" removed.
		wordtravel=pick(runewords)
		runewords-=wordtravel
		wordself=pick(runewords)
		runewords-=wordself
		wordsee=pick(runewords)
		runewords-=wordsee
		wordhell=pick(runewords)
		runewords-=wordhell
		wordblood=pick(runewords)
		runewords-=wordblood
		wordjoin=pick(runewords)
		runewords-=wordjoin
		wordtech=pick(runewords)
		runewords-=wordtech
		worddestr=pick(runewords)
		runewords-=worddestr
		wordother=pick(runewords)
		runewords-=wordother
	//	wordhear=pick(runewords)
	//	runewords-=wordhear
	//	wordfree=pick(runewords)
	//	runewords-=wordfree
		wordhide=pick(runewords)
		runewords-=wordhide

/*
Places these combos are mentioned: this file - twice in the rune code, once in imbued tome, once in tome's HTML runes.dm - in the imbue rune code. If you change a combination - dont forget to change it everywhere.

travel self [word] - Teleport to random [rune with word destination matching]
travel other [word] - Portal to rune with word destination matching - kinda doesnt work. At least the icon. No idea why.
see blood Hell - Create a new tome
join blood self - Incorporate person over the rune into the group
Hell join self - Summon TERROR
destroy see technology - EMP rune
travel blood self - Drain blood
see Hell join - See invisible
blood join Hell - Raise dead

hide see blood - Hide nearby runes
blood see hide - Reveal nearby runes  - The point of this rune is that its reversed obscure rune. So you always know the words to reveal the rune once you have obscured it.

Hell travel self - Leave your body and ghost around
blood see travel - Manifest a ghost into a mortal body
Hell tech join - Imbue a rune into a talisman
Hell blood join - Sacrifice rune
destroy travel self - Wall rune
join other self - Summon cultist rune
travel technology other - Freeing rune    //other blood travel was freedom join other

hide other see - Deafening rune     //was destroy see hear
destroy see other - Blinding rune
destroy see blood - BLOOD BOIL

self other technology - Communication rune  //was other hear blood
join hide technology - stun rune. Rune color: bright pink.
*/
