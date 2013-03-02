
/obj
	//var/datum/module/mod		//not used
	var/m_amt = 0	// metal
	var/g_amt = 0	// glass
	var/w_amt = 0	// waster amounts
	var/origin_tech = null	//Used by R&D to determine what research bonuses it grants.
	var/reliability = 100	//Used by SOME devices to determine how reliable they are.
	var/crit_fail = 0
	var/unacidable = 0 //universal "unacidabliness" var, here so you can use it in any obj.
	animate_movement = 2
	var/throwforce = 1
	proc/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
		//Return: (NONSTANDARD)
		//		null if object handles breathing logic for lifeform
		//		datum/air_group to tell lifeform to process using that breath return
		//DEFAULT: Take air from turf to give to have mob process
		if(breath_request>0)
			return remove_air(breath_request)
		else
			return null

	proc/initialize()

	var/needs_held_update = 0 //If set to true, it needs its held_update function called when held.

	proc/held_update() //This proc is called when it's being held, if the held_update var is set to true.

	proc/attack_by_critter(var/damage, obj/critter/critter) //Call if a critter is attacking it.
		//This is just the default case. Every object has its own death thing...
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\red <B>[src] was genocidedly attacked by [critter].</B>"), 1)
		playsound(src.loc, 'bamf.ogg', 100, 1)
		//src.health -= damage //TODO: Take damage if it has health.
		src.anchored = 0
		step(src, get_dir(critter, src))
		src.density = 0
		critter.broke_object = 1 //Broke the object!
		del(src)
		return

/obj/proc/updateUsrDialog()
	var/list/nearby = viewers(1, src)
	for(var/mob/M in nearby)
		if ((M.client && M.machine == src))
			src.attack_hand(M)
	if (istype(usr, /mob/living/silicon/ai) || istype(usr, /mob/living/silicon/robot))
		if (!(usr in nearby))
			if (usr.client && usr.machine==src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
				src.attack_ai(usr)

/obj/proc/updateDialog()
	var/list/nearby = viewers(1, src)
	for(var/mob/M in nearby)
		if ((M.client && M.machine == src))
			src.attack_hand(M)
	AutoUpdateAI(src)

/obj/proc/update_icon()
	return

/obj/item/proc/updateSelfDialog()
	var/mob/M = src.loc
	if(istype(M) && M.client && M.machine == src)
		src.attack_self(M)


/obj/proc/alter_health()
	return 1

/obj/proc/hide(h)
	return


/obj/proc/hear_talk(mob/M as mob, text)
/*
	var/mob/mo = locate(/mob) in src
	if(mo)
		var/rendered = "<span class='game say'><span class='name'>[M.name]: </span> <span class='message'>[text]</span></span>"
		mo.show_message(rendered, 2)
		*/
	return

/*
Desc:	Sorta a hack/workaround to get interfaceish things into this engine.
		To use an interface just override the proc in your object and set it to return true.
		If an object returns true for one of these it should have ALL of the commented out procs and vars defined in its class.
		There may be some example code in procs below the defines to help explain things, but you don't have to use it.
*/

/*
Name:	IsAssembly
Desc:	If true is an assembly that can work with the holder
*/

/obj/proc/IsAssembly()
	return 0

/*
	var
		secured = 1
		small_icon_state_left = null
		small_icon_state_right = null
		list/small_icon_state_overlays = null
		obj/holder = null
		cooldown = 0//To prevent spam

	proc
		Activate()//Called when this assembly is pulsed by another one
		Secure()//Code that has to happen when the assembly is ready goes here
		Unsecure()//Code that has to happen when the assembly is taken off of the ready state goes here
		Attach_Assembly(var/obj/A, var/mob/user)//Called when an assembly is attacked by another
		Process_cooldown()//Call this via spawn(10) to have it count down the cooldown var
		Holder_Movement()//Called when the holder is moved

	IsAssembly()
		return 1


	Process_cooldown()
		cooldown--
		if(cooldown <= 0)	return 0
		spawn(10)
			Process_cooldown()
		return 1


	Activate()
		if((!secured) || (cooldown > 0))//Make sure to add something using cooldown or such to prevent spam
			return 0
		cooldown = 2
		spawn(10)
			Process_cooldown()
		return 0


	Secure()
		if(secured)
			return 0
		secured = 1
		return 1


	Unsecure()
		if(!secured)
			return 0
		secured = 0
		return 1


	Attach_Assembly(var/obj/A, var/mob/user)
		holder = new/obj/item/device/assembly_holder(get_turf(src))
		if(holder:attach(A,src,user))
			user.show_message("\blue You attach the [A.name] to the [src.name]!")
			return 1
		return 0


	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(W.IsAssembly())
			var/obj/item/device/D = W
			if((!D:secured) && (!src.secured))
				Attach_Assembly(D,user)
		if(isscrewdriver(W))
			if(src.secured)
				Unsecure()
				user.show_message("\blue The [src.name] can now be attached!")
			else
				Secure()
				user.show_message("\blue The [src.name] is ready!")
			return
		else
			..()
		return
*/

/*
Name:	IsAssemblyHolder
Desc:	If true is an object that can hold an assemblyholder object
*/

/obj/proc/IsAssemblyHolder()
	return 0

/*
	proc
		Process_Activation(var/obj/D, var/normal = 1, var/special = 1)
*/

/*
Name:	IsSpecialAssembly
Desc:	If true is an object that can be attached to an assembly holder but is a special thing like a plasma can or door
*/

/obj/proc/IsSpecialAssembly()
	return 0

/*
	var
		small_icon_state = null//If this obj will go inside the assembly use this for icons
		list/small_icon_state_overlays = null//Same here
		obj/holder = null
		cooldown = 0//To prevent spam

	proc
		Activate()//Called when this assembly is pulsed by another one
		Process_cooldown()//Call this via spawn(10) to have it count down the cooldown var
		Attach_Holder(var/obj/H, var/mob/user)//Called when an assembly holder attempts to attach, sets src's loc in here


	Activate()
		if(cooldown > 0)
			return 0
		cooldown = 2
		spawn(10)
			Process_cooldown()
		//Rest of code here
		return 0


	Process_cooldown()
		cooldown--
		if(cooldown <= 0)	return 0
		spawn(10)
			Process_cooldown()
		return 1


	Attach_Holder(var/obj/H, var/mob/user)
		if(!H)	return 0
		if(!H.IsAssemblyHolder())	return 0
		//Remember to have it set its loc somewhere in here
*/
