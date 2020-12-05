format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers));

//bAllAtBase2 replaces bAllAtBase (bAllAtBase2 covers units withing range of AO Camp too)
if (bAllAtBase2 && TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) then {
	["DeBrief", "succeeded"] call FHQ_fnc_ttsetTaskState;

	if (TREND_iMissionParamType == 5) then {
		["end1", true, 7] remoteExec ["BIS_fnc_endMission"];
	}
	else {

		if (TREND_BadPoints >= TREND_MaxBadPoints && TREND_iMissionParamRepOption == 1) then {
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