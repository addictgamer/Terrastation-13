
PriorityQueue
	var/L[]
	var/cmp
	New(compare)
		L = new()
		cmp = compare
	proc
		IsEmpty()
			return !L.len
		Enqueue(d)
			var/i
			var/j
			L.Add(d)
			i = L.len
			j = i>>1
			while(i > 1 &&  call(cmp)(L[j],L[i]) > 0)
				L.Swap(i,j)
				i = j
				j >>= 1

		Dequeue()
			if (!L.len) return 0
			. = L[1]
			Remove(1)

		Remove(i)
			if (i > L.len) return 0
			L.Swap(i,L.len)
			L.Cut(L.len)
			if (i < L.len)
				_Fix(i)
		_Fix(i)
			var/child = i + i
			var/item = L[i]
			while(child <= L.len)
				if (child + 1 <= L.len && call(cmp)(L[child],L[child + 1]) > 0)
					child++
				if (call(cmp)(item,L[child]) > 0)
					L[i] = L[child]
					i = child
				else
					break
				child = i + i
			L[i] = item
		List()
			var/ret[] = new()
			var/copy = L.Copy()
			while(!IsEmpty())
				ret.Add(Dequeue())
			L = copy
			return ret
		RemoveItem(i)
			var/ind = L.Find(i)
			if (ind)
				Remove(ind)
PathNode
	var/datum/source
	var/PathNode/prevNode
	var/f
	var/g
	var/h
	var/nt		// Nodes traversed
	New(s,p,pg,ph,pnt)
		source = s
		prevNode = p
		g = pg
		h = ph
		f = g + h
		source.bestF = f
		nt = pnt

datum
	var/bestF
proc
	PathWeightCompare(PathNode/a, PathNode/b)
		return a.f - b.f

	AStar(start,end,adjacent,dist,maxnodes,maxnodedepth = 30,mintargetdist,minnodedist,id=null, var/turf/exclude=null)

//		world << "A*: [start] [end] [adjacent] [dist] [maxnodes] [maxnodedepth] [mintargetdist], [minnodedist] [id]"
		var/PriorityQueue/open = new /PriorityQueue(/proc/PathWeightCompare)
		var/closed[] = new()
		var/path[]
		start = get_turf(start)
		if (!start) return 0

		open.Enqueue(new /PathNode(start,null,0,call(start,dist)(end)))

		while(!open.IsEmpty() && !path)
		{
			var/PathNode/cur = open.Dequeue()
			closed.Add(cur.source)

			var/closeenough
			if (mintargetdist)
				closeenough = call(cur.source,dist)(end) <= mintargetdist

			if (cur.source == end || closeenough)
				path = new()
				path.Add(cur.source)
				while(cur.prevNode)
					cur = cur.prevNode
					path.Add(cur.source)
				break

			var/L[] = call(cur.source,adjacent)(id)
			if (minnodedist && maxnodedepth)
				if (call(cur.source,minnodedist)(end) + cur.nt >= maxnodedepth)
					continue
			else if (maxnodedepth)
				if (cur.nt >= maxnodedepth)
					continue

			for(var/datum/d in L)
				if (d == exclude)
					continue
				var/ng = cur.g + call(cur.source,dist)(d)
				if (d.bestF)
					if (ng + call(d,dist)(end) < d.bestF)
						for(var/i = 1; i <= open.L.len; i++)
							var/PathNode/n = open.L[i]
							if (n.source == d)
								open.Remove(i)
								break
					else
						continue

				open.Enqueue(new /PathNode(d,cur,ng,call(d,dist)(end),cur.nt+1))
				if (maxnodes && open.L.len > maxnodes)
					open.L.Cut(open.L.len)
		}

		var/PathNode/temp
		while(!open.IsEmpty())
			temp = open.Dequeue()
			temp.source.bestF = 0
		while(closed.len)
			temp = closed[closed.len]
			temp.bestF = 0
			closed.Cut(closed.len)

		if (path)
			for(var/i = 1; i <= path.len/2; i++)
				path.Swap(i,path.len-i+1)
			//if (Debug || Debug2) world << "Pathfinding NOTE: path.len = [path.len]"

		return path


// Returns true if a link between A and B is blocked
// Movement through doors allowed if ID has access
/proc/LinkBlockedWithAccess(turf/A, turf/B, obj/item/weapon/card/id/ID)

	if (A == null || B == null) return 1
	var/adir = get_dir(A,B)
	var/rdir = get_dir(B,A)
	if ((adir & (NORTH|SOUTH)) && (adir & (EAST|WEST)))	//	diagonal
		var/iStep = get_step(A,adir&(NORTH|SOUTH))
		if (!LinkBlockedWithAccess(A,iStep, ID) && !LinkBlockedWithAccess(iStep,B,ID))
			return 0

		var/pStep = get_step(A,adir&(EAST|WEST))
		if (!LinkBlockedWithAccess(A,pStep,ID) && !LinkBlockedWithAccess(pStep,B,ID))
			return 0
		return 1

	if (DirBlockedWithAccess(A,adir, ID))
		return 1

	if (DirBlockedWithAccess(B,rdir, ID))
		return 1

	for(var/obj/O in B)
		if (O.density && !istype(O, /obj/machinery/door) && !(O.flags & ON_BORDER))
			return 1

	return 0

// Returns true if direction is blocked from loc
// Checks doors against access with given ID
/proc/DirBlockedWithAccess(turf/loc,var/dir,var/obj/item/weapon/card/id/ID)
	for(var/obj/structure/window/D in loc)
		if (!D.density)			continue
		if (D.dir == SOUTHWEST)	return 1
		if (D.dir == dir)		return 1

	for(var/obj/machinery/door/D in loc)
		if (!D.density)			continue
		if (istype(D, /obj/machinery/door/window))
			if ( dir & D.dir )	return !D.check_access(ID)

			//if ((dir & SOUTH) && (D.dir & (EAST|WEST)))		return !D.check_access(ID)
			//if ((dir & EAST ) && (D.dir & (NORTH|SOUTH)))	return !D.check_access(ID)
		else return !D.check_access(ID)	// it's a real, air blocking door
	return 0
