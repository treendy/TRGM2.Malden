format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if(!hasInterface) exitWith {};

params ["_thisCiv"];

_actionID = _thisCiv addaction [localize "STR_TRGM2_civillians_fnbadCivAddSearchAction_Button",{_this spawn TREND_fnc_badCivSearch}, nil,1.5,true,true,"","true",5];
_thisCiv setVariable ["searchActionID",_actionID];

true;