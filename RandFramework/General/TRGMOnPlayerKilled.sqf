#include "../../setUnitGlobalVars.sqf";

debugMessages = debugMessages + "Player Killed";
debugMessages = debugMessages + format["KILLED: %1", name player];
debugMessages = debugMessages + format["KILLED Distance: %1", player distance getMarkerPos "MrkHQ"];

if (bDebugMode) then {hint format["KILLED!: %1", player distance getMarkerPos "MrkHQ"]; sleep 3;};

if (player distance getMarkerPos "MrkHQ" > SaveZoneRadius) then {
	waitUntil {!(TRGM_Logic getVariable "DeathRunning")};
	TRGM_Logic setVariable ["DeathRunning", true, true];

	_killer = _this select 1;

	debugMessages = debugMessages + format["KILLED OUTSIDE SAFEZONE, SIDE: %1 - VEHICLE: %2 - PlayerObject: %3", side _killer,vehicle player, player];
	if (_killer != player) then {
		debugMessages = debugMessages + format["KILLER IS NOT THE PLAYER, Killer: %1 - %2", _killer, name _killer];
		KilledPlayers pushBack getPlayerUID player;
		KilledPositions pushBack [getPlayerUID player,getPos Player];
		publicVariable "KilledPlayers";
		publicVariable "KilledPositions";

		_iPointsToAdd = 0.2;
		if (iMissionParamType != 5) then { //if not campaign, then work out how many rep points team gain when a player is killed
			_justPlayers = allPlayers - entities "HeadlessClient_F";
			_iPlayerCount = count _justPlayers;
			_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
			_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;
		};

		[_iPointsToAdd,format[localize "STR_TRGM2_TRGMOnPlayerKilled_Killed", name player]] execVM "RandFramework\AdjustBadPoints.sqf";
		//[_iPointsToAdd,format["Player was killed", name player]] execVM "RandFramework\AdjustBadPoints.sqf";
		//badPoints = badPoints + 0.2; publicVariable "badPoints"

		_tombStone = selectRandom TombStones createVehicle GraveYardPos;
		_tombStone setDir GraveYardDirection;
		_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name player],true];
		//_tombStone addAction ["Read",{hint format["%1",(_this select 0) getVariable "Message"]}];
		[[_tombStone, [localize "STR_TRGM2_RecruiteInf_Read","hint format['%1',(_this select 0) getVariable 'Message']"]],"addAction",true,true] call BIS_fnc_MP;
		//[0.2, format["KIA: %1",name (_this select 0)]] execVM "RandFramework\AdjustBadPoints.sqf";
	};

	TRGM_Logic setVariable ["DeathRunning", false, true];
};


publicVariable "debugMessages";