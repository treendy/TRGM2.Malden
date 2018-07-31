diag_log format ["############## %1 ############## - AIS init started", missionName];

if (isServer) then {
	ais_ace_shutDown = false;
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
		ais_ace_shutDown = true;
		["AIS: AIS shutdown itself cause ACE mod was detected. ACE and AIS cant work at the same time."] call BIS_fnc_logFormat;
	};
	publicVariable "ais_ace_shutDown";
};

//removed this event handler clearing because ACE is already using it for the interaction menu
//removeAllMissionEventHandlers "Draw3D";
//removeAllMissionEventHandlers "EachFrame";
if (!isNil "AIS_Core_eachFrameHandlerId") then {
	removeMissionEventHandler ["EachFrame",AIS_Core_eachFrameHandlerId];
};

call AIS_Core_fnc_initEvents;
AIS_Core_Interaction_Actions = [];