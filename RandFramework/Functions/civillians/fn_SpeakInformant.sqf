params ["_thisCiv", "_caller", "_args"];
_args params ["_iSelected", "_bCreateTask"];
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
		}
		else {
			hint "He is dead you muppet!";
			sName = format["InfSide%1",_iSelected];
			[sName, "failed"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
		};
	}
	else {

		_ballowSearch = true;

		hint "You start to talk to the informant...";
		if (alive _thisCiv) then {
			//increased chance of results
			_searchChance = [true,false];
		}
		else {
			//normal search
			_searchChance = [true,false,false,false,false];
		};


		_thisCiv disableAI "move";
		sleep 3;
		_thisCiv enableAI "move";
		if (alive _thisCiv) then {
			//normal search
			_ballowSearch = true;

		}
		else {
			hint "He is dead you muppet!";
			_ballowSearch = false;
		};

		if (_ballowSearch) then {
			for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
				if (getMarkerType format["mrkMainObjective%1", _i] == "empty") then {
					format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
					["Map updated with main AO location"] remoteExec ["hint", 0, true];
				} else {
					[TREND_IntelShownType,"SpeakInform"] spawn TREND_fnc_showIntel;
					sleep 5;
					[TREND_IntelShownType,"SpeakInform"] spawn TREND_fnc_showIntel;
				};
			};
		};

	};
};