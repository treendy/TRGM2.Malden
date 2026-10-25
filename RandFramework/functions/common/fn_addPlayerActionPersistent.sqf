//adds an action to the local player that survives respawn (CBA player action when CBA is loaded, otherwise re-added on every respawn)
params ["_action"];
if (!hasInterface) exitWith {};
waitUntil {!isNull player}; //can be a JIP replay that runs before the player unit exists

if (isNil "TRGM_persistentPlayerActions") then {TRGM_persistentPlayerActions = [];};
if (_action in TRGM_persistentPlayerActions) exitWith {};
TRGM_persistentPlayerActions pushBack _action;

if ([] call TRGM_fnc_isCbaLoaded) then {
	[_action] call CBA_fnc_addPlayerAction;
} else {
	player addAction _action;
	if (isNil "TRGM_persistentActionsRespawnEH") then {
		TRGM_persistentActionsRespawnEH = player addEventHandler ["Respawn", {
			params ["_newUnit"];
			{_newUnit addAction _x;} forEach TRGM_persistentPlayerActions;
		}];
	};
};
