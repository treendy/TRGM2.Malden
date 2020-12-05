params ["_thisCheckpointUnit", "_caller", "_thisArrayParams"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (side _caller == west) then {

	_CheckpointPos = _thisArrayParams select 0;

	[_thisCheckpointUnit] remoteExec ["removeAllActions", 0, true];


	if (alive _thisCheckpointUnit) then {
		[TREND_IntelShownType,"TalkFriendCheckPoint"] spawn TREND_fnc_showIntel;

	}
	else {
		hint "He doesnt seem to be saying much at this time";
	};


};

true;