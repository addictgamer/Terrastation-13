
/obj/item/weapon/disk
	name = "disk"
	icon = 'items.dmi'

/obj/item/weapon/disk/nuclear
	name = "Nuclear Authentication Disk"
	desc = "Better keep this safe."
	icon_state = "nucleardisk"
	item_state = "card-id"
	w_class = 1.0

/obj/item/weapon/disk/nuclear/Del()
	if (ticker.mode && ticker.mode.name == "nuclear emergency")
		if(blobstart.len > 0)
			var/obj/D = new /obj/item/weapon/disk/nuclear(pick(blobstart))
			message_admins("[src] has been destroyed. Spawning [D] at ([D.x], [D.y], [D.z]).")
			log_game("[src] has been destroyed. Spawning [D] at ([D.x], [D.y], [D.z]).")
	..()

//The return of data disks?? Just for transferring between genetics machine/cloning machine.
//TO-DO: Make the genetics machine accept them.
/obj/item/weapon/disk/data
	name = "Cloning Data Disk"
	icon = 'cloning.dmi'
	icon_state = "datadisk0" //Gosh I hope syndies don't mistake them for the nuke disk.
	item_state = "card-id"
	w_class = 1.0
	var/data = ""
	var/ue = 0
	var/data_type = "ui" //ui|se
	var/owner = "God Emperor of Mankind"
	var/read_only = 0 //Well,it's still a floppy disk

/obj/item/weapon/disk/data/New()
	..()
	var/diskcolor = pick(0,1,2)
	src.icon_state = "datadisk[diskcolor]"

/obj/item/weapon/disk/data/attack_self(mob/user as mob)
	src.read_only = !src.read_only
	user << "You flip the write-protect tab to [src.read_only ? "protected" : "unprotected"]."

/obj/item/weapon/disk/data/examine()
	set src in oview(5)
	..()
	usr << text("The write-protect tab is set to [src.read_only ? "protected" : "unprotected"].")
	return

/obj/item/weapon/disk/data/demo
	name = "data disk - 'God Emperor of Mankind'"
	data = "066000033000000000AF00330660FF4DB002690"
	//data = "0C80C80C80C80C80C8000000000000161FBDDEF" - Farmer Jeff
	ue = 1
	read_only = 1

/obj/item/weapon/disk/data/monkey
	name = "data disk - 'Mr. Muggles'"
	data_type = "se"
	data = "0983E840344C39F4B059D5145FC5785DC6406A4FFF"
	read_only = 1

////////////////////////////////////////
//Disks for transporting design datums//
////////////////////////////////////////

/obj/item/weapon/disk/design_disk
	name = "Component Design Disk"
	desc = "A disk for storing device design data for construction in lathes."
	icon = 'cloning.dmi'
	icon_state = "datadisk2"
	item_state = "card-id"
	w_class = 1.0
	m_amt = 30
	g_amt = 10
	var/datum/design/blueprint
	New()
		src.pixel_x = rand(-5.0, 5)
		src.pixel_y = rand(-5.0, 5)

/obj/item/weapon/disk/tech_disk
	name = "Technology Disk"
	desc = "A disk for storing technology data for further research."
	icon = 'cloning.dmi'
	icon_state = "datadisk2"
	item_state = "card-id"
	w_class = 1.0
	m_amt = 30
	g_amt = 10
	var/datum/tech/stored
	New()
		src.pixel_x = rand(-5.0, 5)
		src.pixel_y = rand(-5.0, 5)
