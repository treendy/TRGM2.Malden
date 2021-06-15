params ["_text"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
[HQMan,_text] call TRGM_GLOBAL_fnc_commsSide;

true;