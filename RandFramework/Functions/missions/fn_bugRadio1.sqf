params ["_radio","_caller","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == west) then {

	_iSelected = _params select 0;
	_bCreateTask = _params select 1;

	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, player] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";

	[_radio] remoteExec ["removeAllActions", 0, true];

	if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_fnc_ttsetTaskState", 0, true];
		//hint format["c:%1",str(_iSelected)];

	}
	else {
		hint "HQ are listening in, stand by...";
		sleep 10;
		//[HQMan,"TREND_EnemyBaseIntel"] remoteExec ["sideRadio",0,false];
		//"mrkFirstLocation" setMarkerType "mil_unknown";
		if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
			format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exist (currently!)
			hint "Map updated with main AO location";
		}
		else {
			[TREND_IntelShownType,"BugRadio"] spawn TREND_fnc_showIntel;
		};
	};
};