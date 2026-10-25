//creates a server-local trigger: when _condition is true either adjusts rep + hints (optional objective) or sets the InfSide task state, then marks the objective position cleared; returns the trigger
params ["_condition", "_iTaskIndex", "_bCreateTask", ["_repReason", ""], ["_hintText", ""], ["_repAmount", 1], ["_repFnc", "TRGM_fnc_adjustMaxBadPoints"], ["_taskState", "succeeded"], ["_clearedObjPrefix", "objInformant"]];

private _sClearedPos = format["ClearedPositions pushBack ([ObjectivePossitions, getPos %1%2] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";", _clearedObjPrefix, _iTaskIndex];
private _sStatement = "";
if (_bCreateTask) then {
	_sStatement = format["[""InfSide%1"", %2] remoteExec [""FHQ_TT_setTaskState"", 0]; ", _iTaskIndex, str _taskState] + _sClearedPos;
}
else {
	_sStatement = format["[%1, %2] call %3; [%4] remoteExec [""Hint"", 0]; ", _repAmount, str _repReason, _repFnc, str _hintText] + _sClearedPos;
};

private _trigger = createTrigger ["EmptyDetector", [0,0], false];
_trigger setVariable ["DelMeOnNewCampaignDay", true];
_trigger setTriggerStatements [_condition, _sStatement, ""];
_trigger
