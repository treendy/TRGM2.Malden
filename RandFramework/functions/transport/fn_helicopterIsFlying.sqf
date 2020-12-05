params ["_vehicle"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

!((isTouchingGround _vehicle)  ||  ((getPos _vehicle select 2) < 2 && (speed _vehicle) < 1));

