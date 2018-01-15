diag_log format ["############## %1 ############## - AIS init started", missionName];

if (isServer) then {
	ais_ace_shutDown = false;
	if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {
		ais_ace_shutDown = true;
		["AIS: AIS shutdown itself cause ACE mod was detected. ACE and AIS cant work at the same time."] call BIS_fnc_logFormat;
	};
	publicVariable "ais_ace_shutDown";
};

removeAllMissionEventHandlers "Draw3D";
removeAllMissionEventHandlers "EachFrame";

call AIS_Core_fnc_initEvents;
AIS_Core_Interaction_Actions = [];