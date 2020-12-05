params ["_vehicle"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
groupId group driver _vehicle;