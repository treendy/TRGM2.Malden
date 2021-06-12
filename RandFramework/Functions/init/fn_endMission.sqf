format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers)) isEqualTo ({ (alive _x) } count (call BIS_fnc_listPlayers));

if !(TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) then {
	{
		[_x, "canceled"] call FHQ_fnc_ttSetTaskState;
	} forEach TREND_ActiveTasks select {!([_x] call FHQ_fnc_ttAreTasksCompleted)};
};

//bAllAtBase2 replaces bAllAtBase (bAllAtBase2 covers units withing range of AO Camp too)
if (bAllAtBase2 && TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) then {
	["DeBrief", "succeeded"] call FHQ_fnc_ttsetTaskState;
	sleep 5;
	_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
	if (_dCurrentRep > 0 && {TREND_iMissionParamRepOption isEqualTo 1}) then {
		["tskKeepAboveAverage", "succeeded"] call FHQ_fnc_ttSetTaskState;
	};

	sleep 10;

	if (TREND_iMissionParamType isEqualTo 5) then {
		["end1", true, 7] remoteExec ["BIS_fnc_endMission"];
	}
	else {

		if (TREND_BadPoints >= TREND_MaxBadPoints && TREND_iMissionParamRepOption isEqualTo 1) then {
			["end2", true, 7] remoteExec ["BIS_fnc_endMission"]
		}
		else {
			if ((["InfSide0"] call FHQ_fnc_ttareTasksSuccessful)) then {
				["end1", true, 7] remoteExec ["BIS_fnc_endMission"];
			} else {
				["end2", true, 7] remoteExec ["BIS_fnc_endMission"];
			};
		};
	};
};

bAttemptedEnd = false; publicVariable "bAttemptedEnd";