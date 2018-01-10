
if (bAllAtBase && ActiveTasks call FHQ_TT_areTasksCompleted) then {
	["DeBrief", "succeeded"] call FHQ_TT_setTaskState;  	

	if (BadPoints >= MaxBadPoints && iMissionParamRepOption == 1) then {
		["end2", true, 7] remoteExec ["BIS_fnc_endMission"]
	}
	else {
		["end1", true, 7] remoteExec ["BIS_fnc_endMission"]
	};
	
};

bAttemptedEnd = false; publicVariable "bAttemptedEnd"; 