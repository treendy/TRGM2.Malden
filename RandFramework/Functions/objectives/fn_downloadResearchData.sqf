params ["_thisLaptop" , "_caller", "_ID", "_arguments"];
_arguments params ["_iSelected","_bCreateTask"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (side _caller == west) then {

	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
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
		[1, "Downloaded research data"] spawn TREND_fnc_AdjustMaxBadPoints;
		"Data secured, reputation increased" remoteExecCall	["hint",side _caller];
	};

};

true;