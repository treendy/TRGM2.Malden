params ["_thisLaptop", "_caller", "_args"];
_args params ["_iSelected", "_bCreateTask"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;


if (side _caller == west) then {

	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
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