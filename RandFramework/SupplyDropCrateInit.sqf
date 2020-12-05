params ["_thisBox"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
[_thisBox] spawn TREND_fnc_SupplyDropCrateInit;