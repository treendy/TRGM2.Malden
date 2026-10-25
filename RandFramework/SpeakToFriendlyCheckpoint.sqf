params ["_thisCheckpointUnit"];

if (side player == FriendlySide) then {

	[_thisCheckpointUnit] remoteExec ["removeAllActions", 0, true];

	if (alive _thisCheckpointUnit) then {
		[IntelShownType,"TalkFriendCheckPoint"] spawn TRGM_fnc_showIntel;
	}
	else {
		hint "He doesnt seem to be saying much at this time";
	};

};
