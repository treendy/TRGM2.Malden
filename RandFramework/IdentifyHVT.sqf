params ["_thisCiv","_thisPlayer","_unused","_params"];
_params params ["_iSelected","_bCreateTask"];
if (side player == west) then {
	//ClearedPositions pushBack (ObjectivePossitions select _iSelected);
	ClearedPositions pushBack ([ObjectivePossitions, player] call BIS_fnc_nearestPosition);
	publicVariable "ClearedPositions";

	//removeAllActions _thisCiv;



	if (_bCreateTask) then {
		[_thisCiv] remoteExec ["removeAllActions", 0, true];
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];	
	}
	else {
		hint (localize "STR_TRGM2_IdentifyHVT_Confirmed");
	};
};
