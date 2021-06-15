format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
if (isNil "TRGM_VAR_BadPoints") then {TRGM_VAR_BadPoints = 0; publicVariable "TRGM_VAR_BadPoints";};
_lastRepPoints = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;
_lastBadPoints = TRGM_VAR_BadPoints;
_LastRank = 0;
if (_lastRepPoints >= 10) then {_LastRank = 5;};
if (_lastRepPoints < 10) then {_LastRank = 4;};
if (_lastRepPoints < 7) then {_LastRank = 3;};
if (_lastRepPoints < 5) then {_LastRank = 2;};
if (_lastRepPoints < 3) then {_LastRank = 1;};
if (_lastRepPoints < 1) then {_LastRank = 0;};
while {true} do {
	_dCurrentRep = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;
	_CurrentRank = _LastRank;
	if (_dCurrentRep >= 10) then {_CurrentRank = 5;};
	if (_dCurrentRep < 10) then {_CurrentRank = 4;};
	if (_dCurrentRep < 7) then {_CurrentRank = 3;};
	if (_dCurrentRep < 5) then {_CurrentRank = 2;};
	if (_dCurrentRep < 3) then {_CurrentRank = 1;};
	if (_dCurrentRep < 1) then {_CurrentRank = 0;};
	if (_dCurrentRep != _lastRepPoints) then {
		if (TRGM_VAR_SaveType != 0) then {
			[TRGM_VAR_SaveType,false] spawn TRGM_SERVER_fnc_serverSave;
			_lastRepPoints = _dCurrentRep;
		};
	};

	if (_lastBadPoints != TRGM_VAR_BadPoints) then {

		_bRepWorse = false;
		if (TRGM_VAR_BadPoints > _lastBadPoints) then {_bRepWorse = true};
		_lastBadPoints = TRGM_VAR_BadPoints;
		if (TRGM_VAR_iMissionParamType != 5) then {
			if (_dCurrentRep <= 0 && {TRGM_VAR_iMissionParamRepOption isEqualTo 1}) then {
				_iCurrentTaskCount = 0;
				["tskKeepAboveAverage", "failed"] call FHQ_fnc_ttSetTaskState;
				while {_iCurrentTaskCount < count TRGM_VAR_ActiveTasks} do {
					if (!(TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then {
						[TRGM_VAR_ActiveTasks select _iCurrentTaskCount, "failed"] call FHQ_fnc_ttSetTaskState;
						_iCurrentTaskCount = _iCurrentTaskCount + 1;
					};
				};
				sleep 2;

				[TRGM_VAR_FriendlySide, ["DeBrief", localize "STR_TRGM2_mainInit_Debrief", "Debrief", ""]] call FHQ_fnc_ttAddTasks;
			};
			if (_dCurrentRep <= 0 && {TRGM_VAR_iMissionParamRepOption isEqualTo 0}) then { //note... when gaining rep, we increase the TRGM_VAR_MaxBadPoints, and when lower, we incrase TRGM_VAR_BadPoints (rep is calulated by the difference)
				["tskKeepAboveAverage", "failed"] call FHQ_fnc_ttSetTaskState;
			};
			if (_dCurrentRep > 0 && {TRGM_VAR_iMissionParamRepOption isEqualTo 0}) then {
				["tskKeepAboveAverage", "succeeded"] call FHQ_fnc_ttSetTaskState;
			};
		};
	};
	if (_LastRank != _CurrentRank) then {
		_bRepWorse = true;
		if (_CurrentRank > _LastRank) then {_bRepWorse = false};
		_LastRank = _CurrentRank;
		if (TRGM_VAR_iMissionParamType isEqualTo 5) then {
			_sRankIcon = "";
			_sRankMessage = "";
			//HERE HERE HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//!!!!!! rank cound go from 2.2 to 3.2 and would not show icon... so need to check if =< 3 and if rank has actually changed!
			if (_dCurrentRep >= 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank5.jpg' size='3.5' />";};
			if (_dCurrentRep < 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank4.jpg' size='3.5' />";};
			if (_dCurrentRep < 7) then {_sRankIcon = "<img image='RandFramework\Media\Rank3.jpg' size='3.5' />";};
			if (_dCurrentRep < 5) then {_sRankIcon = "<img image='RandFramework\Media\Rank2.jpg' size='3.5' />";};
			if (_dCurrentRep < 3) then {_sRankIcon = "<img image='RandFramework\Media\Rank1b.jpg' size='3.5' />";};
			if (_dCurrentRep <= 0) then {_sRankIcon = "<img image='RandFramework\Media\Rank0.jpg' size='3.5' />";};
			if (_bRepWorse) then {
				_sRankMessage = "<t color='#ff0000'>" + localize "STR_TRGM2_mainInit_ReputationDropped" + "</t><br /><br />" + _sRankIcon + "<br /><br />" + localize "STR_TRGM2_mainInit_ReputationText";
			}
			else {
				_sRankMessage = "<t color='#00ff00'>" + localize "STR_TRGM2_mainInit_ReputationIncreased" + "</t><br /><br />" + _sRankIcon + "<br /><br />" + localize "STR_TRGM2_mainInit_ReputationText";
			};

			if ((TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then { //if rank changed and tasks completed, then if now rank 5, need to reset board to show "Start final mission", otherwise, make sure shows "start next mission"
				["MISSION_COMPLETE"] remoteExec ["TRGM_SERVER_fnc_setMissionBoardOptions",0,true];
			};

			[parseText _sRankMessage] call TRGM_GLOBAL_fnc_notifyGlobal;
		};
	};

	//show "Current Reputation is X, Goal is X"
	if (isServer) then {
		"transportChopper" setMarkerPos getPos chopper1;
	};
	sleep 1;
};