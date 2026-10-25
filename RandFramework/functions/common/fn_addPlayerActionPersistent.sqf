//adds an action to the local player that survives respawn (CBA player action when CBA is loaded, otherwise mainInit re-adds it when the player unit changes)
params ["_action"];
if (!hasInterface) exitWith {};
waitUntil {!isNull player}; //can be a JIP replay that runs before the player unit exists

if (isNil "TRGM_persistentPlayerActions") then {TRGM_persistentPlayerActions = [];};
if (_action in TRGM_persistentPlayerActions) exitWith {};
TRGM_persistentPlayerActions pushBack _action;

if ([] call TRGM_fnc_isCbaLoaded) then {
	[_action] call CBA_fnc_addPlayerAction;
} else {
	player addAction _action; //re-added to new units (respawn / team switch) by TransferProviders in mainInit.sqf
};
