_radio = _this select 0;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

//removeAllActions _radio;
[_radio] remoteExec ["removeAllActions", 0, true];

if (_bCreateTask) then {
	sName = format["InfSide%1",_iSelected];
	[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];
	//hint format["c:%1",str(_iSelected)];
}
else {	
	hint "HQ are listening in, stand by...";
	sleep 10;
	[[HQMan,"EnemyBaseIntel"],"sideRadio",true,true] call BIS_fnc_MP;
	//"mrkFirstLocation" setMarkerType "mil_unknown";
	if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
			format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
			hint "Map updated with intel found";
		}
		else {
			[selectRandom IntelShownType,"HackData"] execVM "RandFramework\showIntel.sqf";
		};
};
