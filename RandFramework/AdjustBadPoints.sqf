params ["_pointsToAdd","_message"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
[_pointsToAdd, _message] spawn TREND_fnc_AdjustBadPoints;