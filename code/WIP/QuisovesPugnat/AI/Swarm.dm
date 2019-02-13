#define MOVE_AS_ONE						1
#define OVERRIDE_AI						2
#define COMMUNICATION_GROUP 			4
#define COMMUNICATION_SWARM_TO_MEMBERS	8
#define COMMUNICATION_MEMBER_TO_SWARM	16
#define GOOD_OF_THE_MANY				32
#define FANATICAL						64
#define BASE_OF_OPERATIONS				128
#define HANDLE_DEAD_MEMBERS				512	//Triggers HandleDead(), which removes the dead by default
#define ATTACK_AS_ONE					1024
#define ACT_AS_ONE						2048

//Authority flags.
#define MOVEMENT						1
#define COMBAT							2
#define MISSION							4
#define DISPERSE_SWARM_ON_DEATH			8
#define DESTROY_SWARM_ON_DEATH			16
#define ASSUME_CONTROL_OF_SUBORDINATE	32

/datum/swarm
	var/base_id
	var/communication_range
	var/radius = 15
	var/list/member_ids
	var/list/default_members 		//ID + path
	var/list/member_count   //E.g. list("hivebot" = 30, "carp_min" = 10, "carp_max" = 35)
	var/list/hierarchy
/*For example:
list(
"queen" = list("authority" = MOVEMENT | COMBAT | MISSION, "subordinates" = list("prince")),
"prince"= list("authority" = MOVEMENT | COMBAT, "subordinates" = list("drone", larva")),
"larva" = list("subswarm" = datum/swarm/mites, "subswarm_id = "leader")
)

*/

	var/list/subswarms
	var/flags
	var/goal
	var/datum/MobAI/AI = null
	var/list/base_of_operations

//Used in-play, do not edit.
	var/id
	var/list/members
	var/objectives

/datum/swarm/proc/AddMember(var/mob/M, role)
	if(!members[role])
		members[role] = list("role")
	else
		members[role] += M
	if(!M.faction)
		M.faction = list("[id]_faction")
	else
		M.faction += "[id]_faction"

	return

/datum/swarm/proc/RemoveMember(var/mob/M)
	for(var/list/L in members)
		if(M in L)
			L -= M
			break
	M.faction -= "[id]_faction"
	return

/turf/proc/isopen()
	if(src.density)
		return 0
	for(var/obj/O in src)
		if(O.density)
			return 0
	return 1
/datum/swarm/proc/place_swarm_member(var/mob/member, count, role, var/atom/L = null, var/area/A = null, onground = 0)
	var/mcount = 0
	var/list/total_turfs = list()
	var/list/free_turfs = list()
	var/mob/M2
	var/turf/Pt
	var/r2 = radius * radius
	var/r3 = (round(radius/2, 1))
	var/r4 = r3 - radius
	var/list/G = list()
	if(A)
			G = get_area_turfs(A)
		if(!L)
			L = pick(G)
	for(var/i1 = r4; i1 <= r3; i1++)
		for(var/i2 = r4; i2 <= r3; i2++)
			Pt = locate((L.x + i1), (L.y + i2), L.z)
			if(onground && Pt == turf/space)
				mcount++
				continue
			else if(Pt.isopen() && !A || Pt.isopen() && Pt in G)
				total_turfs += Pt
			else
				mcount++
				continue

			if(var/mob/M in Pt)
				mcount++
			else
				free_turfs += Pt

	for(var/i = 0; i < count; i++)
		if(mcount < r2)
			Pt = pick(free_turfs)
			mcount++
			free_turfs -= Pt
		else
			Pt = pick(total_turfs)
		M2 = new member(Pt.loc)
		src.AddMember(M2, role)
	return
/datum/swarm/New(var/obj/effect/spawner/swarm/spawner = null, var/turf/T = null, I = "", doSubswarms = 0, var/area/A = null, onground = null, prespawned = 0)
	Swarms += src
	var/atom/L
	if(I)
		id = I
	if(prespawned)
		return
	if(!id)
		var/s_count = 0
		for(var/S in Swarms)
			if(!s_count and S.id == base_id)
				s_count = 2
			else if(S.id == "[base_id]_[s_count]")
				s_count++
		if(!s_count)
			id = base_id
		else
			id = "[base_id]_[s_count]"
	if(spawner || T)
		if(spawner)
			L = spawner
			if(onground == null)
				onground = spawner.onground
		else
			L = T
	if(onground == null)
		onground = 0
		for(var/D in member_ids)
			if(D in default_members)
				if(D in member_count)
					src.place_swarm_member(default_members[D], member_count[D], D, L, A, onground)
				else if ("[D]_min" in member_count)
					src.place_swarm_member(default_members[D], rand(member_count["[D]_min"], member_count["[D]_max"]), D, L, A, onground)
				else
					src.place_swarm_member(default_members[D], 1, D, L, A, onground)
	if(doSubswarms)
		for(var/S in subswarms)
			if(spawner)
				S.New(spawner = spawner)
			else if(T)
				S.New(T = T)