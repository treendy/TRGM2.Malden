_thisCheckpointUnit = _this select 0;
_thisPlayer = _this select 1;
_thisArrayParams = _this select 3;

if (side player == west) then {

	_CheckpointPos = _thisArrayParams select 0;

	[_thisCheckpointUnit] remoteExec ["removeAllActions", 0, true];


	if (alive _thisCheckpointUnit) then {
		[IntelShownType,"TalkFriendCheckPoint"] execVM "RandFramework\showIntel.sqf";

	}
	else {
		hint "He doesnt seem to be saying much at this time";
	};


};