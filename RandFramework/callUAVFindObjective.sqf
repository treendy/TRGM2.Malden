{

	[HQMan,"UAV inbound, eta 10 seconds"] remoteExecCall ["sideChat",0,false];
	sleep 10;

	//AODetails select 0
	_sTargetName = format["objInformant%1",(AODetails select 0) select 0];
	_officerObject = missionNamespace getVariable [_sTargetName , objNull];
	_targetPos = getPos _officerObject;

	//HEREE  If pos is zero or target is not alive, show message saying that... and fail task too if target not supose to be dead??
	if (!(alive _officerObject) || _targetPos select 0 == 0) then {
		//if task is still active, and teh target is dead, this must mean the task required the target to be alive (otherwise would have completed), so thereofre fail the task
		if (!(["InfSide0"] call FHQ_TT_areTasksCompleted)) then {
			sName = format["InfSide%1",0]; //zero because we only ever have the UAV option on the main objective
			[sName, "failed"] remoteExec ["FHQ_TT_setTaskState", 0];
			{hint "HVT is either dead or has run away!";} remoteExec ["bis_fnc_call", 0];
		};
		[HQMan,"UAV not been able to locate the HVT, he may be dead or escaped"] remoteExecCall ["sideChat",0,false];

	}
	else {
		[HQMan,"UAV has scanned area, target location marked, UAV is RTB"] remoteExecCall ["sideChat",0,false];
		_test = nil;
		_markerName = format["MrkTargetLocation%1%2",_targetPos select 0, _targetPos select 1];
		_test = createMarker [_markerName, _targetPos];  
		_test setMarkerShape "ICON";  
		_test setMarkerType "o_inf";  
		_test setMarkerText "HVT Location";
		sleep 10;
		deleteMarker _markerName;	
	};


} remoteExec ["bis_fnc_call", 2];
