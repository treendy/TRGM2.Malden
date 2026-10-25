if (bDebugMode) then {hint format["KILLED!: %1", player distance getMarkerPos "MrkHQ"]; sleep 3;};

if (player distance getMarkerPos "MrkHQ" > SaveZoneRadius) then {
	_killer = _this select 1;

	_aceSource = player getVariable ["ace_medical_lastDamageSource", objNull];
	if (!(_aceSource isEqualTo objNull)) then {
		_killer = _aceSource;
	};

	if (_killer != player) then {
		[getPlayerUID player, getPos player] call TRGM_fnc_recordPlayerDeath;

		_iPointsToAdd = 0.2;
		if (iMissionParamType != 5) then { //if not campaign, then work out how many rep points team gain when a player is killed
			_justPlayers = allPlayers - entities "HeadlessClient_F";
			_iPlayerCount = count _justPlayers;
			_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
			_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;
		};

		[_iPointsToAdd,format[localize "STR_TRGM2_TRGMOnPlayerKilled_Killed", name player]] call TRGM_fnc_adjustBadPoints;

		_tombStone = selectRandom TombStones createVehicle GraveYardPos;
		_tombStone setDir GraveYardDirection;
		_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name player],true];
		[_tombStone, [localize "STR_TRGM2_RecruiteInf_Read","hint format['%1',(_this select 0) getVariable 'Message']"]] remoteExec ["addAction", 0, true];
	};
};
