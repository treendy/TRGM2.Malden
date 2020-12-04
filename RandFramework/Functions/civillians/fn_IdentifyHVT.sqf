params ["_thisCiv","_caller","_unused","_params"];
_params params ["_iSelected","_bCreateTask"];
if (side _caller == west) then {
	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";

	//removeAllActions _thisCiv;

	if (_bCreateTask) then {
		[_thisCiv] remoteExec ["removeAllActions", 0, true];
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
	}
	else {
		hint (localize "STR_TRGM2_IdentifyHVT_Confirmed");
	};
};
