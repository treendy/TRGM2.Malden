format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if (isNil "TREND_BadPoints") then {TREND_BadPoints = 0; publicVariable "TREND_BadPoints";};
_lastRepPoints = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
_lastBadPoints = TREND_BadPoints;
_LastRank = 0;
if (_lastRepPoints >= 10) then {_LastRank = 5;};
if (_lastRepPoints < 10) then {_LastRank = 4;};
if (_lastRepPoints < 7) then {_LastRank = 3;};
if (_lastRepPoints < 5) then {_LastRank = 2;};
if (_lastRepPoints < 3) then {_LastRank = 1;};
if (_lastRepPoints < 1) then {_LastRank = 0;};
while {true} do {
	_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
	_CurrentRank = _LastRank;
	if (_dCurrentRep >= 10) then {_CurrentRank = 5;};
	if (_dCurrentRep < 10) then {_CurrentRank = 4;};
	if (_dCurrentRep < 7) then {_CurrentRank = 3;};
	if (_dCurrentRep < 5) then {_CurrentRank = 2;};
	if (_dCurrentRep < 3) then {_CurrentRank = 1;};
	if (_dCurrentRep < 1) then {_CurrentRank = 0;};
	if (_dCurrentRep != _lastRepPoints) then {
		if (TREND_SaveType != 0) then {
			[TREND_SaveType,false] spawn TREND_fnc_ServerSave;
			_lastRepPoints = _dCurrentRep;
		};
	};

	if (_lastBadPoints != TREND_BadPoints) then {

		_bRepWorse = false;
		if (TREND_BadPoints > _lastBadPoints) then {_bRepWorse = true};
		_lastBadPoints = TREND_BadPoints;
		if (TREND_iMissionParamType != 5) then {
			if (_dCurrentRep <= 0 && {TREND_iMissionParamRepOption isEqualTo 1}) then {
				_iCurrentTaskCount = 0;
				["tskKeepAboveAverage", "failed"] call FHQ_fnc_ttSetTaskState;
				while {_iCurrentTaskCount < count TREND_ActiveTasks} do {
					if (!(TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then {
						[TREND_ActiveTasks select _iCurrentTaskCount, "failed"] call FHQ_fnc_ttSetTaskState;
						_iCurrentTaskCount = _iCurrentTaskCount + 1;
					};
				};
				sleep 2;

				[TREND_FriendlySide, ["DeBrief", localize "STR_TRGM2_mainInit_Debrief", "Debrief", ""]] call FHQ_fnc_ttAddTasks;
			};
			if (_dCurrentRep <= 0 && {TREND_iMissionParamRepOption isEqualTo 0}) then { //note... when gaining rep, we increase the TREND_MaxBadPoints, and when lower, we incrase TREND_BadPoints (rep is calulated by the difference)
				["tskKeepAboveAverage", "failed"] call FHQ_fnc_ttSetTaskState;
			};
			if (_dCurrentRep > 0 && {TREND_iMissionParamRepOption isEqualTo 0}) then {
				["tskKeepAboveAverage", "succeeded"] call FHQ_fnc_ttSetTaskState;
			};
		};
	};
	if (_LastRank != _CurrentRank) then {
		_bRepWorse = true;
		if (_CurrentRank > _LastRank) then {_bRepWorse = false};
		_LastRank = _CurrentRank;
		if (TREND_iMissionParamType isEqualTo 5) then {
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

			if ((TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then { //if rank changed and tasks completed, then if now rank 5, need to reset board to show "Start final mission", otherwise, make sure shows "start next mission"
				["MISSION_COMPLETE"] remoteExec ["TREND_fnc_SetMissionBoardOptions",0,true];
			};

			[parseText _sRankMessage] remoteExec ["Hint", 0, true];
		};
	};

	//show "Current Reputation is X, Goal is X"
	if (isServer) then {
		"transportChopper" setMarkerPos getPos chopper1;
	};
	sleep 1;
};