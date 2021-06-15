
params ["_origDirection","_addToDirection"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_iResult = _origDirection + _addToDirection;
if (_iResult > 360) then {
    _iResult = _iResult - 360;
};
if (_origDirection+_addToDirection < 0) then {
    _iResult = 360 + _iResult ;
};
_iResult;
