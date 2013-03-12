
/obj/screen/storage
	name = "storage"
	master = null

	attackby(W, mob/user as mob)
		src.master.attackby(W, user)
		return
