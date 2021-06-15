params [["_fullRep", false]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (_fullRep) then {
	_justPlayers = allPlayers - entities "HeadlessClient_F";
	_iPlayerCount = count _justPlayers;
	_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
	_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;

	[parseText format[localize "STR_TRGM2_TRGMInitPlayerLocal_FullReputationReport",_iPointsToAdd,TRGM_VAR_BadPoints, TRGM_VAR_MaxBadPoints, TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints, TRGM_VAR_BadPointsReason]] call TRGM_GLOBAL_fnc_notify;
} else {
	_totalRep = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;
	_sRankIcon = "";
	if (_totalRep >= 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank5.jpg' size='3.5' />";};
	if (_totalRep < 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank4.jpg' size='3.5' />";};
	if (_totalRep < 7) then {_sRankIcon = "<img image='RandFramework\Media\Rank3.jpg' size='3.5' />";};
	if (_totalRep < 5) then {_sRankIcon = "<img image='RandFramework\Media\Rank2.jpg' size='3.5' />";};
	if (_totalRep < 3) then {_sRankIcon = "<img image='RandFramework\Media\Rank1b.jpg' size='3.5' />";};
	if (_totalRep <= 0) then {_sRankIcon = "<img image='RandFramework\Media\Rank0.jpg' size='3.5' />";};
	_sRankMessage = "<t color='#00ff00'>" + (localize "STR_TRGM2_ShowRepReport_Message1") + " </t><br /><br />" + _sRankIcon + "<br /><br />" + (localize "STR_TRGM2_ShowRepReport_Message2") + "<br /><br />";

	_sRankMessage = _sRankMessage +  format[localize "STR_TRGM2_ShowRepReport_TotalMessage",_totalRep, TRGM_VAR_BadPointsReason];
	[parseText _sRankMessage] call TRGM_GLOBAL_fnc_notify;
};

true;