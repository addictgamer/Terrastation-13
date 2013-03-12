
/obj/screen/close
	name = "close"
	master = null

/obj/screen/close/DblClick()
	if (src.master)
		src.master:close(usr)
	return
