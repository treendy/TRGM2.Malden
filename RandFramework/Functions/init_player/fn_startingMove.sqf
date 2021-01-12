private ["_unit","_move"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_move = [_this,1,"AmovPercMstpSlowWrflDnon",[""]] call BIS_fnc_param;
if !(isNull _unit) then {
	_unit switchMove _move;
};