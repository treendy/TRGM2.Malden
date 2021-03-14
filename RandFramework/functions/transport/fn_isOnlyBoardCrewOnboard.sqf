params ["_vehicle"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
_boardCrew = group driver _vehicle;
{
	alive _x && group _x != _boardCrew;
} count (crew _vehicle) isEqualTo 0;