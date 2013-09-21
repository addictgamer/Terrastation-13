
// Rip from meme.dm. I have no idea how this works --Tauka Usanake

// Take control of a mob
client/proc/Possession()
	set name = "Take Absolute Control"
	set category = "Admin"
	set desc = "Take complete control of another mob."

	if(!host) return

	usr << "<b>You take control of [host]!</b>"
	host << "\red An admin has taken control of your body."

	spawn
		var/mob/dummy = new()
		dummy.loc = 0

		var/datum/mind/host_mind = host.mind
		var/datum/mind/admin_mind = src.mind

		host_mind.transfer_to(dummy)
		meme_mind.transfer_to(host)
		host_mind.current.clearHUD()
		host.update_clothing()

		log_admin("[admin_mind.key] has taken control of [host]([host_mind.key])")
		message_admins("[admin_mind.key] has taken control of [host]([host_mind.key])")



		log_admin("[admin_mind.key] has left control of [host]([host_mind.key])")
		message_admins("[admin_mind.key] has left control of [host]([host_mind.key])")

		admin_mind.transfer_to(src)
		host_mind.transfer_to(host)
		admin_mind.current.clearHUD()
		host.update_clothing()

		del dummy
