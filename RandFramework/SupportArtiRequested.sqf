params ["_artiVeh"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
[_artiVeh] spawn TREND_fnc_SupportArtiRequested;