//Shared start of the intel actions (hack laptop, bug radio, interrogate...): marks the nearest AO as cleared, removes the actions and sets the side task state
params [
	"_actionObject",					//object the action was on
	"_iSelected",						//AO/task index (task name is InfSide<index>)
	"_bCreateTask",						//false = no task for this AO, so only the cleared position (and actions) are updated
	["_taskState", "succeeded"],
	["_bRemoveActions", true],
	["_bOnlyIfNotCompleted", false],	//only set the task state if the task is not already completed
	["_bTaskStateJIP", false]
];

[[ObjectivePossitions, player] call BIS_fnc_nearestPosition] call TRGM_fnc_addClearedPosition;

if (_bRemoveActions) then {
	[_actionObject] remoteExec ["removeAllActions", 0, true];
};

if (_bCreateTask) then {
	private _taskName = format["InfSide%1",_iSelected];
	if (!_bOnlyIfNotCompleted || {!([_taskName] call FHQ_TT_areTasksCompleted)}) then {
		[_taskName, _taskState] remoteExec ["FHQ_TT_setTaskState", 0, _bTaskStateJIP];
	};
};
