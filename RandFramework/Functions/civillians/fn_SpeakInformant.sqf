params ["_thisCiv", "_caller", "_id", "_args"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private _iSelected = _thisCiv getVariable "taskIndex";
private _bCreateTask = _thisCiv getVariable "createTask";

if (alive _thisCiv) then {
	[_thisCiv] spawn TREND_fnc_updateTask;
} else {
	["He is dead you muppet!"] call TREND_fnc_notify;
	[_thisCiv, "failed"] spawn TREND_fnc_updateTask;
};

if (side _caller == west && !_bCreateTask) then {
	_ballowSearch = true;

	["You start to talk to the informant..."] call TREND_fnc_notify;
	if (alive _thisCiv) then {
		//increased chance of results
		_searchChance = [true,false];
	} else {
		//normal search
		_searchChance = [true,false,false,false,false];
	};

	_thisCiv disableAI "move";
	sleep 3;
	_thisCiv enableAI "move";
	if (alive _thisCiv) then {
		//normal search
		_ballowSearch = true;
	} else {
		_ballowSearch = false;
	};

	if (_ballowSearch) then {
		for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
			if (getMarkerType format["mrkMainObjective%1", _i] == "empty") then {
				format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
				["Map updated with main AO location"] call TREND_fnc_notifyGlobal;
			} else {
				[TREND_IntelShownType,"SpeakInform"] spawn TREND_fnc_showIntel;
				sleep 5;
				[TREND_IntelShownType,"SpeakInform"] spawn TREND_fnc_showIntel;
			};
		};
	};
};