params ["_radio","_caller","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == west) then {

	_iSelected = _params select 0;
	_bCreateTask = _params select 1;

	ClearedPositions pushBack ([ObjectivePossitions, player] call BIS_fnc_nearestPosition);
	publicVariable "ClearedPositions";

	[_radio] remoteExec ["removeAllActions", 0, true];

	if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0, true];

	}
	else {	
		hint "HQ are listening in, stand by...";
		sleep 10;
		if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
			format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
			hint "Map updated with main AO location";
		}
		else {
			[IntelShownType,"BugRadio"] spawn TRGM_fnc_showIntel;
		};
	};
};