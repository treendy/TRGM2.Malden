params ["_thisCiv","_caller","_id","_args"];
_args params ["_iSelected","_bCreateTask"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (isNil "_iSelected") then {
	_iSelected = _thisCiv getVariable "taskIndex";
};
if (isNil "_bCreateTask") then {
	_bCreateTask = _thisCiv getVariable "CreateTask";
};

if (side _caller == west) then {

	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";

	//removeAllActions _thisCiv;
	[_thisCiv] remoteExec ["removeAllActions", 0, true];

	if (_bCreateTask) then {
		if (alive _thisCiv) then {
			sName = format["InfSide%1",_iSelected];
			[sName, "succeeded"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
			_thisCiv switchMove "Acts_ExecutionVictim_Loop";
			//_thisCiv disableAI "anim";
		}
		else {
			//fail task
			["He is dead you muppet!"] call TREND_fnc_notify;
			//TREND_badPoints = TREND_badPoints + 10;
			//publicVariable "TREND_badPoints";
			//[format["InfSide%1",_iSelected], "failed"] call FHQ_fnc_ttsetTaskState;
			sName = format["InfSide%1",_iSelected];
			[sName, "failed"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
		};
	}
	else {
		_searchChance = [true,false,false,false];

		["Map updated with intel found"] call TREND_fnc_notify;


		if (alive _thisCiv) then {
			//increased chance of results
			_searchChance = [true,false];
		}
		else {
			//normal search
			_searchChance = [true,false,false,false,false];
		};

		removeAllActions _thisCiv;

		for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
			if (getMarkerType format["mrkMainObjective%1", _i] == "empty") then {
				format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
				["Map updated with main AO location"] remoteExec ["hint", 0, true];
			} else {
				if (alive _thisCiv) then {
					[TREND_IntelShownType,"IntOfficer"] spawn TREND_fnc_showIntel;
					sleep 2;
					[TREND_IntelShownType,"IntOfficer"] spawn TREND_fnc_showIntel;
				} else {
					[(localize "STR_TRGM2_interrogateOfficer_DeadGuy")] call TREND_fnc_notify;
				};
			};
		};
	};


};
