_thisLaptop = _this select 0;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

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
		
			if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
				format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
				hint (localize "STR_TRGM2_bugRadio1_MapUpdated");
			}
			else {
				[IntelShownType,"HackData"] execVM "RandFramework\showIntel.sqf";
			};	
	};
};