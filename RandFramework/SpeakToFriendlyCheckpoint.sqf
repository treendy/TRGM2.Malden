_thisCheckpointUnit = _this select 0;
_thisPlayer = _this select 1;
_thisArrayParams = _this select 3;

_CheckpointPos = _thisArrayParams select 0;

[_thisCheckpointUnit] remoteExec ["removeAllActions", 0, true];

if (alive _thisCheckpointUnit) then {
	[IntelShownType,"TalkFriendCheckPoint"] execVM "RandFramework\showIntel.sqf";

}
else {
	hint (localize "STR_TRGM2_SpeakToFriendlyCheckpoint_DontTell");
};



