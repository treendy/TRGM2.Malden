params ["_thisLaptop" , "_caller", "_ID", "_arguments"];
_arguments params ["_iSelected","_bCreateTask"];

ClearedPositions pushBack (ObjectivePossitions select _iSelected);

//removeAllActions _thisLaptop;
[_thisLaptop] remoteExec ["removeAllActions", 0, true];

if (_bCreateTask) then {
	sName = format["InfSide%1",_iSelected];
	if (!([sName] call FHQ_TT_areTasksCompleted)) then {
		[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];
	};
} else {
	MaxBadPoints = MaxBadPoints + 1;
	publicVariable "MaxBadPoints";
	(localize "STR_TRGM2_downloadResearchData_DataSecured") remoteExecCall	["hint",side _caller];
};