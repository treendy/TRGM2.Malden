_thisCheckpointUnit = _this select 0;
_caller = _this select 1;
_thisArrayParams = _this select 3;

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