
/mob/living/simple_animal/bot/cleanbot/BLARGOR
	name = "B.L.A.R.G.O.R."
	desc = "A strange cleaning robot. Not sure where it came from. It aparently stands for \"Binominal Linguished Anonymous Replicable Gyro Omniscient Robot.\"<br>What a mouthful."
	//layer = 5.0 //what even does this do
	//weight = 1.0E7
	health = 75
	maxHealth = 75

//LZ's all-access patch 1.0 whee
/mob/living/simple_animal/bot/cleanbot/BLARGOR/New()
	..()
	var/datum/job/captain/blrg = new/datum/job/captain
	access_card.access = blrg.get_access()
	prev_access = access_card.access
//There is probably a better way to do this. --LZ