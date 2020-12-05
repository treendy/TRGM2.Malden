params ["_action"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_existingActions = player getVariable ["TRGM_addedActions",[]];

if(!(_action in _existingActions)) then {
    if (call TREND_fnc_isCbaLoaded) then {
        [_action] call CBA_fnc_addPlayerAction;
    } else {
        player addAction _action;
    };
};

_existingActions pushBackUnique _action;
player setVariable ["TRGM_addedActions",_existingActions];

true;