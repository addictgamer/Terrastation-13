
/obj/machinery/r_n_d/server/centcom
	name = "Centcom Central R&D Database"
	server_id = -1

	initialize()
		..()
		var/list/no_id_servers = list()
		var/list/server_ids = list()
		for(var/obj/machinery/r_n_d/server/S in world)
			switch(S.server_id)
				if (-1)
					continue
				if (0)
					no_id_servers += S
				else
					server_ids += S.server_id

		for(var/obj/machinery/r_n_d/server/S in no_id_servers)
			var/num = 1
			while(!S.server_id)
				if (num in server_ids)
					num++
				else
					S.server_id = num
					server_ids += num
			no_id_servers -= S

	process()
		return
