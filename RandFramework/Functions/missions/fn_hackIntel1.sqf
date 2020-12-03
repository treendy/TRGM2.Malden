_thisLaptop = _this select 0;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

if (side player == west) then {

	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, player] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";

	//removeAllActions _thisLaptop;
	[_thisLaptop] remoteExec ["removeAllActions", 0, true];

	if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		if (!([sName] call FHQ_fnc_ttAreTasksCompleted)) then {
			[sName, "succeeded"] remoteExec ["FHQ_fnc_ttSetTaskState", 0];
		};


	} else {

			if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
				format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
				hint (localize "STR_TRGM2_bugRadio1_MapUpdated");
			}
			else {
				[TREND_IntelShownType,"HackData"] spawn TREND_fnc_showIntel;
			};
	};
};

true;