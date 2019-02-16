/*Effects
Heart-rate
Energy
Increased strengh/speed
Pleasure
Memory
Learning
Fine motor control (Manual dexterity?)
Sedation
Nausea
Pain
Itching
Hallucinations
Dreamning
Blindness

Drugs:
Psilocybin-5-HT
Nicotine-Nicotinic acetylcholine receptor
Krokodil-Opiods: MOR & NOR
Methamphetamine-Sigma 1 & Sigma 2 & TAAR1
THC-CB1 & CB2
Hydrocodone: MOR
Diphenhydramine: H1
*/
//Major Effects

#define ANALGESIA		1
#define SEDATION		2
#define	EUPHORIA		4
#define	HALLUCINATION	8
#define STIMULATION		16
#define	MOTOR_CONTROL	32
#define MOTOR_FINE		64
#define RESPIRATION		128

//Minor Effects
#define ITCHING			1
#define NAUSEA			2
#define MIOSIS			4
#define	APPETITE		8
/datum/neuroreceptor/
	var/potency = 0 //Probably percentile.
	var/list/agonists
	var/list/antagonists
	var/major_effects = 0
	var/minor_effects = 0

/datum/neuroreceptor/MOR/
	major_effects = ANALGESIA | SEDATION | EUPHORIA
	minor_effects = ITCHING | NAUSEA | MIOSIS
	agonists = list(/datum/reagent/medicine/hydrocodone = 5, /datum/reagent/krokodil/ = 15)
/datum/neurorecptor/NOR/
