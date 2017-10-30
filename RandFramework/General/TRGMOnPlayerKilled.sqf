#include "../../setUnitGlobalVars.sqf";

if (bDebugMode) then {hint format["KILLED!: %1", player distance getMarkerPos "MrkHQ"]; sleep 3;};

if (player distance getMarkerPos "MrkHQ" > SaveZoneRadius) then {
	waitUntil {!(TRGM_Logic getVariable "DeathRunning")};
	TRGM_Logic setVariable ["DeathRunning", true, true];

	_killer = _this select 1; 
	if (side _killer == East || vehicle player != player) then {
			
		KilledPlayers pushBack getPlayerUID player;
		KilledPositions pushBack [getPlayerUID player,getPos Player];
		publicVariable "KilledPlayers";
		publicVariable "KilledPositions";

		
		_justPlayers = allPlayers - entities "HeadlessClient_F";
		_iPlayerCount = count _justPlayers;
		_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
		_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;			
		//[_iPointsToAdd,format["%1 was killed", name player]] execVM "RandFramework\AdjustBadPoints.sqf";
		[_iPointsToAdd,format["Player was killed", name player]] execVM "RandFramework\AdjustBadPoints.sqf";
		//badPoints = badPoints + 0.2; publicVariable "badPoints"
		
	};

	TRGM_Logic setVariable ["DeathRunning", false, true];
};
