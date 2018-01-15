// by Psychobastard
// AIS REVIVE Setup-File

//__________________________________________________________________________________________________________________________________________________________________
// v v v v v v v v v v v v  --- Main Settings --- v v v v v v v v v v v v

//0 = no, 1 = guarantee revive, 2 = realistic revive, 3 = realistic revive (only medics can revive)
//4 = relistic, medics only, and only when near medevac chopper  5 = realistic revive, medics only, and only near medical building at HQ


AIS_REVIVE_INIT_UNITS 		= 	"allPlayables"; // Auto-Init a group of units: "allPlayers" , "allPlayables" , "allUnits", "allUnitsBLUFOR", "allUnitsOPFOR", "allUnitsINDFOR", "allUnitsCIVILIAN"
												// Warning: I didn't recomment to use "allUnits" if you play with a lot of AI units! AIS is mainly created for players and/or their AI group.

if (iUseRevive == 1) then {
	AIS_MEDICAL_EDUCATION 		= 	0; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
	AIS_REVIVE_GUARANTY 		= 	true;			// If true you will fall everytime in uncoscious mode, regardless how strong the impact of damage was.
	AIS_MEDEVAC_STATIONS		=	[];				// Add one or more objects and a radius to activate the medevac feature. If enabled revive is only at this place(s) possible. Empty array []  means feature is disabled.
};												// Syntax: f.e.: [ [myMedevacVehicle, 15], [myMedicTent, 10] ]	--> make sure the variable name is avalible at gamestart. Otherwise call it later in a function.

if (iUseRevive == 2) then {
	AIS_MEDICAL_EDUCATION 		= 	1; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
	AIS_REVIVE_GUARANTY 		= 	false;			// If true you will fall everytime in uncoscious mode, regardless how strong the impact of damage was.
	AIS_MEDEVAC_STATIONS		=	[];				// Add one or more objects and a radius to activate the medevac feature. If enabled revive is only at this place(s) possible. Empty array []  means feature is disabled.
};

if (iUseRevive == 3) then {
	AIS_MEDICAL_EDUCATION 		= 	2; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
	AIS_REVIVE_GUARANTY 		= 	false;			// If true you will fall everytime in uncoscious mode, regardless how strong the impact of damage was.
	AIS_MEDEVAC_STATIONS		=	[];				// Add one or more objects and a radius to activate the medevac feature. If enabled revive is only at this place(s) possible. Empty array []  means feature is disabled.
};	
if (iUseRevive == 4) then {
	AIS_MEDICAL_EDUCATION 		= 	2; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
	AIS_REVIVE_GUARANTY 		= 	false;			// If true you will fall everytime in uncoscious mode, regardless how strong the impact of damage was.
	AIS_MEDEVAC_STATIONS		=	[[chopper1,15],[medBuilding,15],[medTruck,15],[mediChop1,15]]; 		// Add one or more objects and a radius to activate the medevac feature. If enabled revive is only at this place(s) possible. Empty array []  means feature is disabled.
};	
if (iUseRevive == 5) then {
	AIS_MEDICAL_EDUCATION 		= 	2; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
	AIS_REVIVE_GUARANTY 		= 	false;			// If true you will fall everytime in uncoscious mode, regardless how strong the impact of damage was.
	AIS_MEDEVAC_STATIONS		=	[[medBuilding,15]];				// Add one or more objects and a radius to activate the medevac feature. If enabled revive is only at this place(s) possible. Empty array []  means feature is disabled.
};	

//__________________________________________________________________________________________________________________________________________________________________
//	v v v v v v v v v v v v  --- Optional Settings --- v v v v v v v v v v v v 

AIS_DAMAGE_TOLLERANCE_FACTOR = 	1; 				// A higher value means more damage tolerance. 1 is Vanilla. 0.8 mean all damage will reduce to 80% of Vanilla.
AIS_BLEEDOUT_TIME 			= 	300; 			// Basic life time in seconds until the unit bleed out and die.. The real life time depends on the real damage of the unit. (can be less or more time from the basic value)
AIS_REVIVETIME 				= 	30;				// Basic revive time in seconds. The real revive time depends on the real damage of the unit. (can be less or more time from the basic value)
AIS_STABILIZETIME 			= 	20;				// Basic stabilize time in seconds to stop the bleeding of a unconscious unit. The real revive time depends on the real damage of the unit. (can be less or more time from the basic value)
AIS_REVIVE_HEAL 			= 	false;			// If set to true the injured unit get completely healed after the revive. (casual gameplay without a medic)
AIS_TOGGLE_RADIO 			= 	true; 			// If set to true, unconscious players cannot use his TFAR or ACRE radios.
AIS_NO_CHAT 				= 	true; 			// If set to true, a injured player cannot use text chat during he is uncoscious.
AIS_AI_HELP_RADIUS 			= 	100; 			// Number, Radius in metres. Units in this radius will help to revive if no group member is able to revive. Max value is 200 metres.
AIS_DISABLE_RESPAWN_BUTTON	=	30;				// Time in seconds while the respawn button is disabled (Esc Menu). Set to 0 to enable the respawn button everytime.



//__________________________________________________________________________________________________________________________________________________________________
//	v v v v v v v v v v v v  --- Visual Settings --- v v v v v v v v v v v v 

AIS_SHOW_UNC_MARKERS	 	=	false; 			// If set to true, a marker will show injured units on the map.
AIS_SHOW_UNC_MESSAGE_TO 	= 	"None"; 		// "None", "Side", "Group" --> who read the message about wounded units.
AIS_SHOW_UNC_3D_MARKERS 	=	false; 			// If set to true, an in-game visible 3D-icon shows you the position of injured units (within a range of 20 metres and 35 metres for medics).
AIS_IMPACT_EFFECTS 			= 	true; 			// Set to true to enable impact effects. (simple simluation of supressing effects)
AIS_SHOW_COUNTDOWN 			= 	true; 			// If set to true, an unconscious unit will be able to see the bleed out timer.
AIS_SHOW_DIARYINFO 			= 	true; 			// If set to true, a diary entry with some informations about the AIS (Credits, features, How to) is added.