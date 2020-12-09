
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
bDebugging = false;

if (isNil "TREND_ToUseMilitia_Side") then {TREND_ToUseMilitia_Side = false; publicVariable "TREND_ToUseMilitia_Side";};

sTeamleaderToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sTeamleaderMilitia);}; 		(call sTeamleader); };
sRiflemanToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sRiflemanMilitia);}; 		(call sRifleman); };
sTank1ArmedCarToUse = 	{ if (TREND_ToUseMilitia_Side) exitWith {(call sTank1ArmedCarMilitia);}; 	(call sTank1ArmedCar); };
sTank2APCToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sTank2APCMilitia);}; 		(call sTank2APC); };
sTank3TankToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sTank3TankMilitia);}; 		(call sTank3Tank); };
sAAAVehToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sAAAVehMilitia);}; 			(call sAAAVeh); };
sEngineerToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sEngineerMilitia);}; 		(call sEngineer); };
sGrenadierToUse = 		{ if (TREND_ToUseMilitia_Side) exitWith {(call sGrenadierMilitia);}; 		(call sGrenadier); };
sMedicToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sMedicMilitia);}; 			(call sMedic); };
sAAManToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sAAManMilitia);}; 			(call sAAMan); };
sATManToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sATManMilitia);}; 			(call sATMan); };
sMortarToUse = 			{ if (TREND_ToUseMilitia_Side) exitWith {(call sMortarMilitia);}; 			(call sMortar); };
sMachineGunManToUse = 	{ if (TREND_ToUseMilitia_Side) exitWith {(call sMachineGunManMilitia);}; 	(call sMachineGunMan); };
true;