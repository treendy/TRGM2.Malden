params ["_text"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
[HQMan,_text] call TREND_fnc_commsSide;

true;