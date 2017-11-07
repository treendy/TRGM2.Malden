params ["_thisCiv","_thisPlayer","_unused","_params"];
_params params ["_iSelected","_bCreateTask"];

//removeAllActions _thisCiv;
[_thisCiv] remoteExec ["removeAllActions", 0, true];

if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];	
};