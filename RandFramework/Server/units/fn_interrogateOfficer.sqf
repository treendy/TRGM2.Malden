params ["_thisCiv","_caller","_id","_args"];
_args params ["_iSelected","_bCreateTask"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (isNil "_iSelected") then {
	_iSelected = _thisCiv getVariable "taskIndex";
};
if (isNil "_bCreateTask") then {
	_bCreateTask = _thisCiv getVariable "createTask";
};

if (side _caller isEqualTo west) then {

	//TRGM_VAR_ClearedPositions pushBack (TRGM_VAR_ObjectivePossitions select _iSelected);
	TRGM_VAR_ClearedPositions pushBack ([TRGM_VAR_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
	publicVariable "TRGM_VAR_ClearedPositions";

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
			["He is dead you muppet!"] call TRGM_GLOBAL_fnc_notify;
			//TRGM_VAR_badPoints = TRGM_VAR_badPoints + 10;
			//publicVariable "TRGM_VAR_badPoints";
			//[format["InfSide%1",_iSelected], "failed"] call FHQ_fnc_ttsetTaskState;
			sName = format["InfSide%1",_iSelected];
			[sName, "failed"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
		};
	}
	else {
		_searchChance = [true,false,false,false];

		["Map updated with intel found"] call TRGM_GLOBAL_fnc_notify;


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
			if (getMarkerType format["mrkMainObjective%1", _i] isEqualTo "empty") then {
				format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
				["Map updated with main AO location"] call TRGM_GLOBAL_fnc_notifyGlobal;
			} else {
				if (alive _thisCiv) then {
					[TRGM_VAR_IntelShownType,"IntOfficer"] spawn TRGM_GLOBAL_fnc_showIntel;
					sleep 2;
					[TRGM_VAR_IntelShownType,"IntOfficer"] spawn TRGM_GLOBAL_fnc_showIntel;
				} else {
					[(localize "STR_TRGM2_interrogateOfficer_DeadGuy")] call TRGM_GLOBAL_fnc_notify;
				};
			};
		};
	};


};
