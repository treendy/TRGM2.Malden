
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
bDebugging = false;

sRiflemanToUse = 		{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sRiflemanMilitia);}; 		(call sRifleman); };
sTeamleaderToUse = 		{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sTeamleaderMilitia);}; 		(call sTeamleader); };
sATManToUse = 			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sATManMilitia);}; 			(call sATMan); };
sAAManToUse = 			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sAAManMilitia);}; 			(call sAAMan); };
sEngineerToUse = 		{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sEngineerMilitia);}; 		(call sEngineer); };
sGrenadierToUse = 		{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sGrenadierMilitia);}; 		(call sGrenadier); };
sMedicToUse = 			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sMedicMilitia);}; 			(call sMedic); };
sMachineGunManToUse = 	{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sMachineGunManMilitia);}; 	(call sMachineGunMan); };
sSniperToUse = 			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sSniperMilitia);}; 			(call sSniper); };
sExpSpecToUse =			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sExpSpecMilitia);}; 			(call sExpSpec); };
sEnemyHeliPilotToUse =	{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sEnemyHeliPilotMilitia);};	(call sEnemyHeliPilot); };

sTank1ArmedCarToUse = 	{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sTank1ArmedCarMilitia);}; 	(call sTank1ArmedCar); };
sTank2APCToUse = 		{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sTank2APCMilitia);}; 		(call sTank2APC); };
sTank3TankToUse = 		{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sTank3TankMilitia);}; 		(call sTank3Tank); };
sAAAVehToUse = 			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sAAAVehMilitia);}; 			(call sAAAVeh); };
sMortarToUse = 			{ if (TRGM_VAR_ToUseMilitia_Side) exitWith {(call sMortarMilitia);}; 			(call sMortar); };
true;
