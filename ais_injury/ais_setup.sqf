// by psycho
// AIS INJURY Setup-File Version 21022016

//__________________________________________________________________________________________________________________________________________________________________
// v v v v v v v v v v v v  --- Main Settings --- v v v v v v v v v v v v
//0 = no, 1 = guarantee revive, 2 = realistic revive, 3 = realistic revive (only medics can revive)

_iUseRevive = ("OUT_par_UseRevive" call BIS_fnc_getParamValue);	

if (_iUseRevive == 1) then {
	tcb_ais_realistic_mode 			= 	false; 			// If set to true, units may die immediately if they get seriously wounded. If set to false, you are guaranteed a 100% chance to revive.
	tcb_ais_medical_education 		= 	1; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
};
if (_iUseRevive == 2) then {
	tcb_ais_realistic_mode 			= 	true; 			// If set to true, units may die immediately if they get seriously wounded. If set to false, you are guaranteed a 100% chance to revive.
	tcb_ais_medical_education 		= 	1; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
};
if (_iUseRevive == 3) then {
	tcb_ais_realistic_mode 			= 	true; 			// If set to true, units may die immediately if they get seriously wounded. If set to false, you are guaranteed a 100% chance to revive.
	tcb_ais_medical_education 		= 	2; 				// Who can revive an unconscious unit? 0 == Everybody, 1 == Everybody with a First Aid Kit or Medkit, 2 == Only Medics (this affects both, AI and players!).
};

tcb_ais_pvpMode 				= 	false; 			// Not implemented yet!



//__________________________________________________________________________________________________________________________________________________________________
//	v v v v v v v v v v v v  --- Optional Settings --- v v v v v v v v v v v v 

tcb_ais_rambofactor 			= 	1; 				// A higher value means more damage tolerance. Set to 2 for double damage tolerance. Set to 0.5 for half etc. 1 equates to Vanilla.
tcb_ais_random_lifetime_factor 	= 	100; 			// A higher value means you have more time to heal the unit before it bleeds out and dies (50 == means around 1 minute, 100 == means around 3 minutes, 200 == approximately 5 minutes).
													// The time mostly depends on the damage the unit takes before loose consciousness. The time is randomized and not exact.
tcb_ais_delTime 				= 	0; 			// Time in seconds until dead bodys are removed. If zero seconds are selected, this feature is disabled. (only units that have been handled by AIS Injury System will be deleted!).
tcb_ais_allways_walk 			= 	false; 			// If set to true, the units are always able to walk/run. False means broken legs are possible (Vanilla).
tcb_ais_toggleTFAR 				= 	false; 			// If set to true, injured player cannot use his TFAR radio (if TFAR is in use - auto detection).
tcb_ais_noChat 					= 	false; 			// If set to true, an injured player cannot use text chat.



//__________________________________________________________________________________________________________________________________________________________________
//	v v v v v v v v v v v v  --- Visual Settings --- v v v v v v v v v v v v 

tcb_ais_show_injury_marker 		=	false; 			// If set to true, a marker will show injured units on the map.
tcb_ais_show_3d_icons 			=	false; 			// If set to true, an in-game visible 3D-icon shows you the position of injured units (within a range of 30 meters).
tcb_ais_dead_dialog 			= 	false; 			// Set to true to enable the deadcam and the dead dialog.
tcb_ais_bloodParticle 			= 	true; 			// If set to true, extra blood particles are randomly generated on wounded units. Set false to disable this feature.
tcb_ais_impactEffects 			= 	true; 			// Set to true to enable visible impact effects. Set to false to disable this feature.
tcb_ais_showCountdown 			= 	true; 			// If set to true, an unconscious unit will be able to see the bleed out timer.
tcb_ais_showDiaryInfo 			= 	true; 			// If set to true, a diary entry with some informations about the AIS (Credits, features, How to) is added.