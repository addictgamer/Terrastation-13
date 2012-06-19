/*/mob/living/carbon/human/proc/human_test_space_pirate()
	set category = "testing commands"
	set name = "Transform into space pirate"

	if(usr.stat == 2)
		usr <<"You cannot change into a space pirate becuase you are dead!"
		return
	src.piratize()
	return*/