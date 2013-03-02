
/obj/item/aiModule
	name = "AI Module"
	icon = 'module.dmi'
	icon_state = "std_mod"
	item_state = "electronic"
	desc = "An AI Module for transmitting encrypted instructions to the AI."
	flags = FPRINT | TABLEPASS| CONDUCT
	force = 5.0
	w_class = 2.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 15
	origin_tech = "programming=3"

	proc
		install(var/obj/machinery/computer/C)
			if (istype(C, /obj/machinery/computer/aiupload))
				var/obj/machinery/computer/aiupload/comp = C
				if(comp.stat & NOPOWER)
					usr << "The upload computer has no power!"
					return
				if(comp.stat & BROKEN)
					usr << "The upload computer is broken!"
					return
				if (!comp.current)
					usr << "You haven't selected an AI to transmit laws to!"
					return
				if (comp.current.stat == 2 || comp.current.control_disabled == 1)
					usr << "Upload failed. No signal is being detected from the AI."
				else if (comp.current.see_in_dark == 0)
					usr << "Upload failed. Only a faint signal is being detected from the AI, and it is not responding to our requests. It may be low on power."
				else
					src.transmitInstructions(comp.current, usr)
					comp.current << "These are your laws now:"
					comp.current.show_laws()
					usr << "Upload complete. The AI's laws have been modified."
			else if (istype(C, /obj/machinery/computer/borgupload))
				var/obj/machinery/computer/borgupload/comp = C
				if(comp.stat & NOPOWER)
					usr << "The upload computer has no power!"
					return
				if(comp.stat & BROKEN)
					usr << "The upload computer is broken!"
					return
				if (!comp.current)
					usr << "You haven't selected a cyborg to transmit laws to!"
					return
				if (comp.current.stat == 2 || comp.current.emagged)
					usr << "Upload failed. No signal is being detected from the cyborg."
				else if (comp.current.connected_ai)
					usr << "Upload failed. The cyborg is slaved to an AI."
				else
					src.transmitInstructions(comp.current, usr)
					comp.current << "These are your laws now:"
					comp.current.show_laws()
					usr << "Upload complete. The cyborg's laws have been modified."

		transmitInstructions(var/mob/living/silicon/ai/target, var/mob/sender)
			target << "[sender] has uploaded a change to the laws you must follow, using a [name]. From now on: "
			var/time = time2text(world.realtime,"hh:mm:ss")
			lawchanges.Add("[time] <B>:</B> [sender.name]([sender.key]) used [src.name] on [target.name]([target.key])")

/*
/obj/item/aiModule/robocop // -- TLE
	name = "'Robocop' Core AI Module"
	desc = "A 'Robocop' Core AI Module: 'Reconfigures the AI's core three laws.'"
	orign_tech = "programming=4"
*/
