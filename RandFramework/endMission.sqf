
_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers));

//bAllAtBase2 replaces bAllAtBase (bAllAtBase2 covers units withing range of AO Camp too)
if (bAllAtBase2 && ActiveTasks call FHQ_TT_areTasksCompleted) then {
	["DeBrief", "succeeded"] call FHQ_TT_setTaskState;  	

	if (iMissionParamType == 5) then {
		["end1", true, 7] remoteExec ["BIS_fnc_endMission"];
	}
	else {

		if (BadPoints >= MaxBadPoints && iMissionParamRepOption == 1) then {
			["end2", true, 7] remoteExec ["BIS_fnc_endMission"]
		}
		else {
			if ((["InfSide0"] call FHQ_TT_areTasksSuccessful)) then {
				["end1", true, 7] remoteExec ["BIS_fnc_endMission"];
			} else {
				["end2", true, 7] remoteExec ["BIS_fnc_endMission"];
			};
		};
	};	
};

bAttemptedEnd = false; publicVariable "bAttemptedEnd"; 