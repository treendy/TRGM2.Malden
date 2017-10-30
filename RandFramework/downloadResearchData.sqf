_thisLaptop = _this select 0;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

//removeAllActions _thisLaptop;
[_thisLaptop] remoteExec ["removeAllActions", 0, true];

if (_bCreateTask) then {
	sName = format["InfSide%1",_iSelected];
	[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];

} else {
	
		MaxBadPoints = MaxBadPoints + 1; 
		publicVariable "MaxBadPoints";
		["Data secured, reputation increased","hint",true,false] call BIS_fnc_MP;
	
};