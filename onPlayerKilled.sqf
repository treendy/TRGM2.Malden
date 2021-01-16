"OnPlayerKilled.sqf" call TREND_fnc_log;
params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];
TREND_debugMessages = TREND_debugMessages + "Player Killed";
TREND_debugMessages = TREND_debugMessages + format["KILLED: %1", name player];
TREND_debugMessages = TREND_debugMessages + format["KILLED Distance: %1", player distance getMarkerPos "MrkHQ"];

if (TREND_bDebugMode) then {[format["KILLED!: %1", player distance getMarkerPos "MrkHQ"]] call TREND_fnc_notify; sleep 3;};

if (player distance getMarkerPos "MrkHQ" > TREND_SaveZoneRadius) then {
	waitUntil {!(TRGM_Logic getVariable "DeathRunning")};
	TRGM_Logic setVariable ["DeathRunning", true, true];

	_aceSource = player getVariable ["ace_medical_lastDamageSource", objNull];
	if (!(_aceSource isEqualTo objNull)) then {
		_killer = _aceSource;
	};

	TREND_debugMessages = TREND_debugMessages + format["KILLED OUTSIDE SAFEZONE, SIDE: %1 - VEHICLE: %2 - PlayerObject: %3", side _killer,vehicle player, player];
	if (_killer != player) then {
		TREND_debugMessages = TREND_debugMessages + format["KILLER IS NOT THE PLAYER, Killer: %1 - %2", _killer, name _killer];
		TREND_KilledPlayers pushBack getPlayerUID player;
		TREND_KilledPositions pushBack [getPlayerUID player,getPos Player];
		publicVariable "TREND_KilledPlayers";
		publicVariable "TREND_KilledPositions";

		_iPointsToAdd = 0.2;
		if (TREND_iMissionParamType != 5) then { //if not campaign, then work out how many rep points team gain when a player is killed
			_justPlayers = allPlayers - entities "HeadlessClient_F";
			_iPlayerCount = count _justPlayers;
			_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
			_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;
		};

		[_iPointsToAdd,format[localize "STR_TRGM2_TRGMOnPlayerKilled_Killed", name player]] spawn TREND_fnc_AdjustBadPoints;
		//[_iPointsToAdd,format["Player was killed", name player]] spawn TREND_fnc_AdjustBadPoints;
		//TREND_BadPoints = TREND_BadPoints + 0.2; publicVariable "TREND_BadPoints"

		_tombStone = selectRandom TREND_TombStones createVehicle TREND_GraveYardPos;
		_tombStone setDir TREND_GraveYardDirection;
		_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name player],true];
		//_tombStone addAction ["Read",{[format["%1",(_this select 0) getVariable "Message"]] call TREND_fnc_notify}];
		[_tombStone, [localize "STR_TRGM2_RecruiteInf_Read","[format['%1',(_this select 0) getVariable 'Message']] call TREND_fnc_notify"]] remoteExec ["addAction", 0, true];
		//[0.2, format["KIA: %1",name (_this select 0)]] spawn TREND_fnc_AdjustBadPoints;
	};

	TRGM_Logic setVariable ["DeathRunning", false, true];
};


publicVariable "TREND_debugMessages";

true;