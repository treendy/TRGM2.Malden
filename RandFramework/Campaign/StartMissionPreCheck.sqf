_isFinal = _this select 0;

_bAllow = [] call TRGM_fnc_isPlayerAllowedToLead;

//everyone has to be back at base (or the AO camp) with the current tasks done
_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
_bAllAtBase = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers));
if (_bAllow && !(_bAllAtBase && ActiveTasks call FHQ_TT_areTasksCompleted)) then {
	hint (localize "STR_TRGM2_StartMission_Hint");
	_bAllow = false;
};

if (_bAllow) then {
	if (_isFinal) then {
		FinalMissionStarted=true;
		publicVariable "FinalMissionStarted";
	};

	[false] call TRGM_fnc_resetTransportChoppers;
	sleep 0.2;
	//unique id for this start, PostStartMission uses it to wait for the server's camp decision (also when replayed for joining players)
	_startId = format["%1_%2", getPlayerUID player, diag_tickTime];
	[[_startId],"RandFramework\Campaign\StartMission.sqf"] remoteExec ["BIS_fnc_execVM",0,"TRGM_startMission"]; //JIP id so joining players only replay the latest mission start
};