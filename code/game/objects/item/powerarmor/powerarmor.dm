
/obj/item/powerarmor
	name = "Generic power armor component"
	desc = "This is the base object, you should never see one."
	var/obj/item/clothing/suit/powered/parent //so the component knows which armor it belongs to.
	var/slowdown = 0 //how much the component slows down the wearer

	proc/toggle()
		return
		//The child objects will use this proc
