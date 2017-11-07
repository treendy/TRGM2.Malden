params ["_radio","_caller","_params"];
_params params ["_iSelected","_bCreateTask"];

[_radio] remoteExec ["removeAllActions", 0, true];

if (_bCreateTask) then {
	sName = format["InfSide%1",_iSelected];
	[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0, true];
	//hint format["c:%1",str(_iSelected)];
}
else {	
	hint "HQ are listening in, stand by...";
	sleep 10;
	[HQMan,"EnemyBaseIntel"] remoteExec ["sideRadio",0,false];
	//"mrkFirstLocation" setMarkerType "mil_unknown";
	if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
			format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
			hint "Map updated with intel found";
		}
		else {
			[selectRandom IntelShownType,"HackData"] execVM "RandFramework\showIntel.sqf";
		};
};
