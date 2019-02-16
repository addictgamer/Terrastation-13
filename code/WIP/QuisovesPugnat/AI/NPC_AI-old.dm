//Intellect
#define BEAST	1 	//A savage animal, with little capacity for learning or stratagems.
#define SHREWD 	2	//Brighter than your average bear, this creature can learn by example and can even manipulate tools.
#define SAPIENT 3	//Of humanoid intelligence. Capable of advanced planning, improvisation, group organization, etc.
#define GENIUS 	4	//Preternaturally gifted, understanding comes easily to this one. Exceedingly cunning.

//Behavioral Traits
#define TERRITORIAL 1
#define THIEF		2
#define RAMPAGE		4	//This creature smashes anything and everything it sees.
#define HOSTILE		8
#define ERATIC		16
#define SUICIDAL	32
#define FANATICAL	64
#define DOCILE		128	//This creature behaves like a pet.
#define LURKER		256	//This creature prefers to lie in wait, emerging only when it sees a valid target
#define COOPERATIVE	512`//This creature asks its allies for help.
#define CURIOUS		1024

//Movement Traits
#define UNSTEADY		1 	//Ambles about, as if intoxicated.
#define ROVING			2	//This creature has no direction, moving entirely at random.
#define STATIC			4 	//This creature doesn't move at all...
#define STAY_AT_BASE	8
#define FLEE_TO_BASE	16


//Like/Dislike
#define PREFERENCE_LIGHT 		1
#define PREFERENCE_DARKNESS		2
#define PREFERENCE_NOISE 		4
#define PREFERENCE_SILENCE		8
#define PREFERENCE_COMPANY		16
#define PREFERENCE_CONSTRAINTS	32



#define IGNORE_SUBTYPES		1
//General Action Bitflags
#define	AI_SUBDUE			2
#define AI_SCARE_AWAY		4
#define AI_BEAT_UP			8
#define AI_DESTROY			16
#define AI_FLEE				32
#define AI_FOLLOW			64
#define AI_AID				128
#define AI_GUARD			256
#define AI_TAMPER			512
#define AI_OPERATE			1024
#define AI_HEAL				2048
#define AI_EAT				4096
#define AI_GET				8192
#define	AI_CUSTOM			16384

//General Reaction Bitflags
#define AI_LIKE				4
#define AI_DISLIKE			8
#define AI_LOVE				16
#define AI_HATE				32
#define AI_RANDOM_ACTION	64
#define AI_CUSTOM_REACT		128

//Priorities
#define FIND_TARGET				1
#define GO_TO_TARGET			2
#define SUBDUE_TARGET			4
#define ATTACK_TARGET			8
#define BEAT_UP_TARGET			16
#define DESTROY_TARGET			32
#define FLEE_TARGET				64
#define AID_TARGET				128
#define GET_TARGET				256
#define OPERATE_TARGET			512
#define TAMPER_TARGET			1024
#define HEAL_TARGET				2048
#define EAT_TARGET				4092
#define FIND_TARGET_SOURCE		8192
#define CUSTOM_ACTION			16384


//Status flags

#define STATUS_SLEEP	1
#define STATUS_OVERRIDE	2
#define STATUS_IDLE		3
#define STATUS_ACTIVE	4
#define STATUS_ANGRY	5
#define STATUS_BERSERK	6
#define STATUS_PANICKED	7
#define STATUS_JUMPY	8
#define STATUS_INSANE	9

//Eating flags
#define OMNIVORE				1
#define CARNIVORE				2
#define HERBIVORE				4
#define	SUPERVORE				8 //Eats *anything*
#define	CANNIBAL				16
#define DESPERATE_EAT_ENEMIES	32
#define DESPERATE_EAT_FRIENDS	64
#define DESPERATE_EAT_FACTION	128
#define DESPERATE_OMNIVORE		256
#define DESPERATE_SUPERVORE		512 //This will probably never be used, unless someone wants to make a picky robot, but why not?
#define DESPERATE_CANNIBAL		1024

//COMMAND FLAGS
#define COMMAND_FOLLOW_ME				1
#define COMMAND_FOLLOW_ME_STOP			2
#define COMMAND_FOLLOW_OTHER			3
#define COMMAND_FOLLOW_OTHER_STOP		4
#define COMMAND_RESCUE_ME				5
#define COMMAND_RESCUE_OTHER			6
#define COMMAND_STAY					7
#define COMMAND_STAY_STOP				8

/datum/NPC_AI
/*
	TRAITS:
	Preface a trait with "min_" and "max_" to make it variable, i.e. randomized for each instance of an AI.
	learning  				//Used for creatures above beastial intelligence, determines probability of learning something.
	anger					//50 is the median value. A creature with 50 anger will calm down from a tantrum after 10 minutes.
	ferocity
	cunning					//Determines, in opposition to ferocity, how likely a creature is to ambush, set traps, etc.
	caution					//Determines the extent to which a creature avoids probable danger.
	paranoia				//Determines the probability of a creature erroneously perceiving danger.
							//Interacts inversely with valor.
	friendliness
	stubbornness			//Determines how likely a creature is to persist in a difficult or unpleasant task.
	patience
	valor	 				//Determines the percentage of health that must be lost before a creature flees from combat.
	mischief		 		//Determines how playful a creature is, and therefore how likely it is to mess around with things.
	focus 					//Determines how likely a creature is to stick to a goal.


	sanity
	memory
*/
/
/WHOOOO SO MANY LISTS
	var/list/emotions = list(
	"min_anger" = 25,
	"max_anger" = 35,
	"ferocity" = 25,
	"caution" = 45,
	"paranoia" = 10,
	"friendliness" = 50,
	"stubbornness" = 20,
	"patience" = 50,
	"valor" = 50,
	"mischief" = 0
	)
	var/list/intellectual_traits = list(
	"learning" = 50,
	"cunning" = 25,
	"focus" = 75,
	"sanity" = 100
	)
	var/intellect = BEAST
	var/movement_traits

	var/behavior_traits
	var/likes
	var/dislikes
	var/loves
	var/hates
	var/fears
	var/list/special_interactions	//Associative-list, with types as indices for bitflags.
	var/list/special_reactions		//Ditto.
	var/list/territory
	var/list/commands //Associative list, with commands as indices.
//Combat
	var/attack_range //The range that a creature


	var/list/faction
	var/list/speech
	var/eating_flags

//The following are used during play; do not predefine them.
	var/frustration = 0 //Determines how likely a creature is to give up on a task (if it has stubborness).
	var/anger = 0
/*
When this reaches 75, an NPC with the anger emotion
will attempt to attack anything it finds itself frustrated with.
At 100, it will throw a tantrum. */
	var/terror = 0 //Ditto, but with fear and panic.
	var/hunger
	var/list/priorities	//Short term objectives.
	var/list/goals		//Long term objectives.
	var/list/relationships
	var/list/knowhow	//List of things this creature can operate.
	var/currentpriority
	var/status = 0
	var/not_moving = 1
	var/atom/host
	var/datum/swarm/Swarm
	var/targets


/proc/BitflagTypeCache(var/list/L)
	var/list/L2
	for(var/P in L)
		if(L[P] &= IGNORE_SUBTYPES)
			L2[P] = L[P]
		else
			for(var/T in typesof(P))
				L2[T] = L[P]
	return L2


/datum/NPC_AI/proc/is_in_faction(var/list/F)
	for(var/F2 in faction)
		if(F2 in F)
			return 1
	return 0

/datum/NPC_AI/proc/RandomAction(var/atom/R = null)
	return

/datum/NPC_AI/proc/CustomAction(var/atom/R = null)
	return

/datum/NPC_AI/proc/Angry(a = 5, var/atom/R = null)
	if(frustration >= 100)
		return
	if(!emotions["anger"]) //In the offchance some ninny calls this proc without checking the emotions-list.
		return
	if(R && !(R in angry_at))
		angry_at += R
	frustration += (a * (emotions["anger"] / 100))
	if(frustration >= 100)
		status = STATUS_ANGRY
	else if(frustration >= 50)
		var/fr = 0
		if(emotions["ferocity"])
			fr = emotions["ferocity"]
		fr += frustration
		for(var/atom/R2 in angry_at)
			if(fr < 100)
				Add_Priority(BEAT_UP_TARGET, R2)
			else
				Add_Priority(DESTROY_TARGET, R2)
			angry_at -= R2

/datum/NPC_AI/proc/emotions_cooldown()
	if(emotions["anger"]  && frustration > 0)
		frustration -= ((1 / 3) * (emotions["anger"] /  50))
/datum/NPC_AI/proc/DoPriorities()
	for(var/atom/A in priorities)
		if(!A)
			priorities -= A
		else if(priorities[A] & GO_TO_TARGET)
			if(!MoveToTarget(A, delay, minimum_distance))
				priorities[A] |= ~GO_TO_TARGET
		else if(priorities[A] & (ATTACK_TARGET | BEAT_UP_TARGET | DESTROY_TARGET))
			if(!MoveToTarget(A))
				if(!Attack(A))
					priorities[A] |= (~ATTACK_TARGET | ~BEAT_UP_TARGET | ~DESTROY_TARGET)
			else
				if(Attack(A))
					if(priorities[A] & ATTACK_TARGET)
						priorities[A] |= ~ATTACK_TARGET
			if(priorities[A] & BEAT_UP_TARGET && A.is_battered())
				priorities[A] |= ~BEAT_UP_TARGET
			else if(priorities[A] & DESTROY_TARGET && A.is_destroyed())
				priorities[A] |= ~DESTROY_TARGET

		else if(priorities[A] & FLEE_TARGET)
			if(!can_see(A))
				priorities[A] |= ~FLEE_TARGET
			else if(!flee(A))
				priorities[A] |= ~FLEE_TARGET
				if(CanAttack(A))
					Analyize_Threat(A)
		else if

/datum/NPC_AI/proc/Assess_Surroundings()
	host.Get_Surroundings()
	Ticker()
	React()
/datum/NPC_AI/proc/Action()
	Speech("casual")
	Movement()

/datum/NPC_AI/proc/Process()
	switch(status)
		if(STATUS_SLEEP)
			return
		if(STATUS_IDLE)
			Assess_Surroundings()
			if(priorities.len)
				DoPriorities()
		if(STATUS_OVERRIDE)
			Pass_Surroundings_to_Swarm()
			if(priorities.len)
				DoPriorities()

		if(STATUS_ACTIVE)
			Assess_Surroundings()
			if(priorities.len)
				DoPriorities()
			else
				Action()
				Targeting()

		if(STATUS_ANGRY)
			Tantrum()
		if(STATUS_BERSERK)
			Berserk()
		if(STATUS_PANICKED)
			Panic(terror)
		if(STATUS_JUMPY)
			Threat_Analysis(emotions["paranoia"])
		if(STATUS_INSANE)
			Eratic(intellectual_traits["sanity"])


/atom/proc/IsCombatant()	//I.e. "Is this is a thing to fight or flee from?"
	return 0

/atom/proc/IsVulnerable()	//I.e. "Can this thing be damaged?"
	return 0

/atom/proc/HasOccupant()	//I.e. "Does this thing have an occupant and, if so, what is that?"
	return null

/atom/proc/CanUse()			//I.e. Can this thing be operated or tampered with?
	return 0				//N.B. Special interactions don't check for this, which you may find of use.

/atom/proc/NPC_Tamper(var/datum/NPC_AI/AI)
	return
/atom/proc/NPC_Operate(var/datum/NPC_AI/AI)
	return

/atom/proc/Get_Surroundings()
/obj/spacepod/HasOccupant()
	return pilot

/obj/spacepod/IsCombatant()
	var/atom/M = HasOccupant()
	if(M && M.IsCombatant)
		return 1
	else
		return 0


/obj/machinery/porta_turret/IsVulnerable()
	if(!raised) //Don't attack invincible turrets
		return 0
	if(stat & BROKEN) //Or turrets that are already broken
		return 0
	return 1

/obj/machinery/porta_turret/IsCombatant()
	if(!IsVulnerable())
		return 0
	return 1
/*
/datum/NPC_AI/proc/React()
	if(!reactions.len)
		return 0
	for(var i = 1; i <= reactions.len; i++)
		var/atom/R
		var/react = reactions[i]
		if(i <=  react_to.len) //Generalized reactions are placed at the end of the reactions-list.
			R = reactions[i + 1]
			switch(react)
				if(REACTION_BLOCKED_BY)
					if(!src,npc_operate() || R.density)
						delay_current_priority()
						if(can_attack(R))
							currentpriority = ATTACK_TARGET
							current_target = R
						else
							currentpriority = FIND_TARGET
				if(REACTION_ATTACKED_BY)
					if(R.is_in_faction(faction))
						return
					if(can_attack(R))
						if(currentpriority >= SCARE_AWAY_TARGET &&  currentpriority <= DESTROY_TARGET)
							var/atom/CMP = comparethreats(current_target, R)
							if(CMP != current_target)
								delay_current_priority()
							current_target = CMP
						if(will_fight(current_target))
							current_priority = ATTACK_TARGET
						else
							current_priority = FLEE_TARGET
							purge_priorities(ATTACK_TARGET)
					else if(NPC_CanMove() && behavior_traits ~ SUICIDAL && behavior_traits ~ FANATICAL)
						current_priority = FLEE_TARGET
						purge_priorities(ATTACK_TARGET)
					else
						return

				if(REACTION_ANGERED_BY)
					Angry(reactions[i + 1])
*/
/*
/datum/NPC_AI/proc/DoPriorities()
	var/remaining_targets = targets
	for(var/i = 1; i <= priorities.len; i++)
		if(!targets && !NPC_CanMove())
			break
		if(priorities[i] >= SCARE_AWAY_TARGET && <= DESTROY_TARGET)
			if(!can_attack(prioritytargets[i]))
				continue
			else if(IsInRange(prioritytargets[i]))
				NPC_attack(prioritytargets[i])
				remaining_targets--
				if(priorities[i] == SCARE_AWAY_TARGET)
					RemovePriority(i)
				else if(priorities[i] == BEAT_UP_TARGET)
					if(prioritytargets[i].DamageCheck(DAMAGE_BATTERED))
						RemovePriority(i)
				else if(priorities[i] == DESTROY_TARGET)
					if(prioritytargets[i].IsDead())
						RemovePriority(i)

		if(not_moving)
			host.NPC_Move_Towards(prioritytargets[i])
			not_moving--
*/