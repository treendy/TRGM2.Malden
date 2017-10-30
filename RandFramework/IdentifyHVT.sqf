
_thisCiv = _this select 0;
_thisPlayer = _this select 1;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

//removeAllActions _thisCiv;
[_thisCiv] remoteExec ["removeAllActions", 0, true];



if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];	
};

	