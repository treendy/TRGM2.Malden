
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
bDebugging = false;

sRiflemanToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sRiflemanMilitia);}; 		(call sRifleman); };
sTeamleaderToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sTeamleaderMilitia);}; 		(call sTeamleader); };
sATManToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sATManMilitia);}; 			(call sATMan); };
sAAManToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sAAManMilitia);}; 			(call sAAMan); };
sEngineerToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sEngineerMilitia);}; 		(call sEngineer); };
sGrenadierToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sGrenadierMilitia);}; 		(call sGrenadier); };
sMedicToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sMedicMilitia);}; 			(call sMedic); };
sMachineGunManToUse = 	{ if (TREND_ToUseMilitia_Side) exitWith {(call sMachineGunManMilitia);}; 	(call sMachineGunMan); };
sSniperToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sSniperMilitia);}; 			(call sSniper); };
sExpSpecToUse =			{ if (TREND_ToUseMilitia_Side) exitWith {(call sExpSpecMilitia);}; 			(call sExpSpec); };
sEnemyHeliPilotToUse =	{ if (TREND_ToUseMilitia_Side) exitWith {(call sEnemyHeliPilotMilitia);};	(call sEnemyHeliPilot); };

sTank1ArmedCarToUse = 	{ if (TREND_ToUseMilitia_Side) exitWith {(call sTank1ArmedCarMilitia);}; 	(call sTank1ArmedCar); };
sTank2APCToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sTank2APCMilitia);}; 		(call sTank2APC); };
sTank3TankToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sTank3TankMilitia);}; 		(call sTank3Tank); };
sAAAVehToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sAAAVehMilitia);}; 			(call sAAAVeh); };
sMortarToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sMortarMilitia);}; 			(call sMortar); };
true;
