format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
sleep 60;
waituntil {sleep 2; TREND_CoreCompleted};
_bEnd = false;
while {!_bEnd} do {
	_bMissionEndedAndPlayersOutOfAO = false;
	_bMissionEnded = false;
	_bAnyPlayersInAOAndAlive = false;

	if (TREND_iMissionSetup == 5) then {
		_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
		if (TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted && _dCurrentRep >= 10 && TREND_FinalMissionStarted) then {_bMissionEnded = true};
	}
	else {
		if (TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) then {_bMissionEnded = true};
	};

	_justPlayers = allPlayers - entities "HeadlessClient_F";
	{
		_currentPlayer = _x;
		{
			if (alive(_currentPlayer) && _currentPlayer distance _x < 2000) then {
				_bAnyPlayersInAOAndAlive = true;
			};
		} forEach TREND_ObjectivePossitions;
	} forEach _justPlayers;
	if (_bMissionEnded && !_bAnyPlayersInAOAndAlive) then {_bMissionEndedAndPlayersOutOfAO = true};
	if (_bMissionEndedAndPlayersOutOfAO) then {
		_bEnd = true;
		ace_hearing_disableVolumeUpdate = true;
		2 fadeSound 0.1;
		playMusic "";
		0 fadeMusic 1;
		playMusic selectRandom TREND_ThemeAndIntroMusic;
		//Hint format["InitPlayer Music: %1",TREND_ThemeAndIntroMusic];
		sleep 8;
		["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>TRGM 2</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TRGM2Title" + "</t>",-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;
		sleep 10;
		["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>" + (TREND_AdvancedSettings select TREND_ADVSET_GROUP_NAME_IDX) + "</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'><br />" + localize "STR_TRGM2_TRGMInitPlayerLocal_RTBDebreif" + "</t>",-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;
		sleep 10;
		_stars = "";
		_iCount = 0;
		{
			_iCount = _iCount + 1;
			if (_iCount == count allPlayers) then {
				_stars = _stars + name _x; // format [_stars,name _x, "|%2"];
			}
			else {
				_stars = _stars + name _x + " | "; // format [_stars,name _x, "|%2"];
			};
		} forEach allPlayers;
		[format ["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>Starring</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'><br />%1</t>",_stars],-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;

		sleep 10;
		8 fadeMusic 0;
		8 fadeSound 1;
		[] spawn {
			sleep 8;
			ace_hearing_disableVolumeUpdate = false;
			playMusic "";
		};
	};
	sleep 5;
};