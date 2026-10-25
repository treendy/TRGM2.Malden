_isFinal = _this select 0;

_bAllow = [] call TRGM_fnc_isPlayerAllowedToLead;

if (_bAllow) then {
	if (_isFinal) then {
		FinalMissionStarted=true;
		publicVariable "FinalMissionStarted";
	};

	[false] call TRGM_fnc_resetTransportChoppers;
	sleep 0.2;
	[[],"RandFramework\Campaign\StartMission.sqf"] remoteExec ["BIS_fnc_execVM",0,"TRGM_startMission"]; //JIP id so joining players only replay the latest mission start
};