params ["_radio","_caller","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

_iSelected = _params select 0;
_bCreateTask = _params select 1;

ClearedPositions pushBack (ObjectivePossitions select _iSelected);

[_radio] remoteExec ["removeAllActions", 0, true];

if (_bCreateTask) then {
	sName = format["InfSide%1",_iSelected];
	[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0, true];
	//hint format["c:%1",str(_iSelected)];
}
else {
	hint (localize "STR_TRGM2_bugRadio1_HQLisen");
	sleep 10;
	//[HQMan,"EnemyBaseIntel"] remoteExec ["sideRadio",0,false];
	//"mrkFirstLocation" setMarkerType "mil_unknown";
	if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
		format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
		hint (localize "STR_TRGM2_bugRadio1_MapUpdated");
	}
	else {
		[IntelShownType,"BugRadio"] execVM "RandFramework\showIntel.sqf";
	};
};
