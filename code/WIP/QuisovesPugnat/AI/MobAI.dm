//Intellect
#define BEAST	1 	//A savage animal, with little capacity for learning or stratagems.
#define SHREWD 	2	//Brighter than your average bear, this creature can learn by example and can even manipulate tools.
#define SAPIENT 3	//Of humanoid intelligence. Capable of advanced planning, improvisation, group organization, etc.
#define GENIUS 	4	//Preternaturally gifted, understanding comes easily to this one. Exceedingly cunning.

//Behavioral Traits
#define TERRITORIAL 1
#define EMOTIONLESS	2
#define THIEF		4
#define RAMPAGE		8	//This creature smashes anything and everything it sees.
#define PREDATOR	16  //Actively hunts other mobs, ala most hostile mobs.
#define ERATIC		32


//Movement Traits
#define UNSTEADY		1 	//Ambles about, as if intoxicated.
#define ROVING			2	//This creature has no direction, moving entirely at random.
#define STATIC			4 	//This creature doesn't move at all...
#define STAY_AT_BASE	8
#define FLEE_TO_BASE	16


//Like/Dislike
#define LIGHT 		1
#define DARKNESS	2
#define NOISE 		4
#define SILENCE		8
#define COMPANY		16
#define CONSTRAINTS	32


//Priorities
#define FIND_TARGET		1
#define GO_TO_TARGET	2
#define ATTACK_TARGET	4
#define FLEE_TARGET		8
#define AID_TARGET		16
#define RESCUE_TARGET	32
#define STEAL_TARGET	64
#define FLEE_AREA		128
#define FIND_ATTACKER	256
/datum/MobAI
	var/intellect
	var/learning = 50 //Used for creatures above beastial intelligence, determines probability of learning something.
	var/anger = 25
	var/ferocity = 25
	var/cunning = 25		//Determines, in opposition to ferocity, how likely a creature is to ambush, set traps, etc.
	var/caution = 45		//Determines the extent to which a creature avoids probable danger.
	var/paranoia = 10		//Determines the probability of a creature erroneously perceiving danger.
							//Interacts inversely with valor.
	var/friendliness = 50
	var/stubbornness = 20	//Determines how likely a creature is to persist in a difficult or unpleasant task.
	var/patience = 50
	var/valor = 50 		//Determines the percentage of health that must be lost before a creature flees from combat.
	var/mischief = 0 	//Determines how playful a creature is, and therefore how likely it is to mess around with things.
	var/focus = 75 		//Determines how likely a creature is to stick to a goal.


	var/sanity = 100
	var/memory = 60
	var/movement_traits

	var/likes
	var/dislikes
	var/list/specific_likes
	var/list/specific_dislikes
	var/list/default_knowledge //Determines what this creature knows of from the outset.
	var/list/languages
	var/list/feared				//Things to automatically flee from.
	var/list/hated				//Things to automatically attack.
	var/list/territory_area
	var/list/territory_turf
	var/list/steal
//Used during play, do not change.
	var/frustration = 0
	var/list/priorities = list()
	var/list/prioritytargets = list()
	var/currentpriority
	var/busy = 0
	var/atom/current_target
	var/list/react_target = list()
	var/react = 0

/datum/MobAI/proc/React()
	var/rlen = react_target.len
	for(var/i in (ATTACKED_BY, BLOCKED_BY, ETC))
		if(react_target
			switch(i)
				if(ATTACKED_BY)
					if(src.canhit(react_target))
						src.doaction(ATTACK, react_target)
					else if(src.isgreaterthreat(react_target))
						if(src.willfight(react_target))
							priority = ATTACK_TARGET
						else
							priority = FLEE_TARGET
				if(ATTACKED_BY_UNKNOWN)

		 		if(BLOCKED_BY)
		 			if(src.goaround(current_target))
		 				prioritytargets -= prioritytargets[Ln]
		 				priorities -= priorities[Ln]
		 			else
		 				current_target = react_target
		 				if(src.willfight())
		 					priority = ATTACK_TARGET
		 				else
		 					priority

/datum/MobAI/proc/Process()
	var/Ln = priorities.len
	if(!busy)
		if(!currentpriority && intellect > BEAST)
			if(Ln)
				currentpriority = priorities[Ln]
				priorities -= priorities[Ln]
				current_target = prioritytargets[Ln]
				prioritytargets -= prioritytargets[Ln]
		else if(react)
			priorities += currentpriority
			prioritytargets += current_target
			Ln = priorities.len
			src.React()
	else
		if(!src.dopriority(currentpriority))
