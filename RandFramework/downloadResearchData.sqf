params ["_thisLaptop" , "_caller", "_ID", "_arguments"];
_arguments params ["_iSelected","_bCreateTask"];

if (side player == west) then {

	//ClearedPositions pushBack (ObjectivePossitions select _iSelected);
	ClearedPositions pushBack ([ObjectivePossitions, player] call BIS_fnc_nearestPosition);
	publicVariable "ClearedPositions";

	//removeAllActions _thisLaptop;
	[_thisLaptop] remoteExec ["removeAllActions", 0, true];

	if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		if (!([sName] call FHQ_TT_areTasksCompleted)) then {
			[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];
		};
	} else {
		[1, "Downloaded research data"] execVM "RandFramework\AdjustMaxBadPoints.sqf";
		"Data secured, reputation increased" remoteExecCall	["hint",side _caller];
	};

};