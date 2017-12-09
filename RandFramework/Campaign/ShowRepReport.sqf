
	_justPlayers = allPlayers - entities "HeadlessClient_F";
	_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
	_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;
	_totalRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
	hint format["Current cost per life: %1\n\nBad reputation points: %2 out of %3\n\nTOTAL REP: %4 \n\nREASONS SO FAR: \n%5",_iPointsToAdd,BadPoints, MaxBadPoints, _totalRep, BadPointsReason]

