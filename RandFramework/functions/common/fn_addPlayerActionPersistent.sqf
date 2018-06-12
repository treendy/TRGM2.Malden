params ["_action"];

_existingActions = player getVariable ["TRGM_addedActions",[]];

if(!(_action in _existingActions)) then {
    if ([] call TRGM_fnc_isCbaLoaded) then {
        [_action] call CBA_fnc_addPlayerAction;
    } else {
        player addAction _action;
    };
};

_existingActions pushBackUnique _action;
player setVariable ["TRGM_addedActions",_existingActions];