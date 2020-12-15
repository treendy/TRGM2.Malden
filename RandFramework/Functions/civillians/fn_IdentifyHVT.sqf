params ["_thisCiv","_caller","_unused","_params"];
_params params ["_iSelected","_bCreateTask"];

if (isNil "_iSelected") then {
	_iSelected = _thisCiv getVariable "taskIndex";
};
if (isNil "_bCreateTask") then {
	_bCreateTask = _thisCiv getVariable "CreateTask";
};

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if (side _caller == west) then {
	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";

	//removeAllActions _thisCiv;

	if (_bCreateTask) then {
		[_thisCiv] remoteExec ["removeAllActions", 0, true];
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
	}
	else {
		hint (localize "STR_TRGM2_IdentifyHVT_Confirmed");
	};
};
