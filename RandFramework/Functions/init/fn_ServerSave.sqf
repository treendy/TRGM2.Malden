//Note: this will always save on the server, if local or single player, will save on client, otherwise, if dedicated, will save on dedicated server, reason, if player who has saved the mission
// disconnects, we will not be able to save it to the client, so we store that players ID and store it on the server (I think i have disabled this for single player... as they can save/load anyway)
// future update may allow this to be saved on single player, incase they want to run campaign on mixed maps

params["_SaveType","_IsFirstSave"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

//sInitialSLPlayerID
_SaveVersion = "";
if (_SaveType == 1) then {
	_SaveVersion = worldName;
};
if (_SaveType == 2) then {
	_SaveVersion = "GLOBAL";
};


if (_SaveVersion != "") then {
	//sInitialSLPlayerID
	TREND_SaveType =  _SaveType; publicVariable "TREND_SaveType";
	TREND_SaveTypeString =  _SaveVersion; publicVariable "TREND_SaveTypeString";

	sleep 0.1;
	{
		_saveData = [
			TREND_iMissionParamType,
			TREND_iMissionParamObjective,
			TREND_iAllowNVG,
			TREND_iMissionParamRepOption,
			TREND_iWeather,
			TREND_iUseRevive,
			TREND_iStartLocation,
			TREND_BadPoints,
			TREND_MaxBadPoints,
			TREND_BadPointsReason,
			TREND_iCampaignDay,
			TREND_AdvancedSettings,
			TREND_EnemyFactionData,
			TREND_LoadoutData,
			TREND_arrayTime
		];
		profileNamespace setVariable [TREND_sInitialSLPlayerID + ":" + TREND_SaveTypeString,_saveData];
		saveProfileNamespace;
	} remoteExec ["call", 2]; //Save this to server only


	TREND_laptop1 remoteExec ["removeAllActions"];

	if (TREND_SaveType == 1) then {
		if (_IsFirstSave) then {[(localize "STR_TRGM2_ServerSave_Save1")] call TREND_fnc_notify;};
		[TREND_laptop1, [localize "STR_TRGM2_ServerSave_SaveLocal",{[(localize "STR_TRGM2_ServerSave_SaveHint")] call TREND_fnc_notify}]] remoteExec ["addAction", 0];

	}
	else {
		if (_IsFirstSave) then {[(localize "STR_TRGM2_ServerSave_Save2")] call TREND_fnc_notify;};
		TREND_laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveGlobal",{[(localize "STR_TRGM2_ServerSave_SaveHint")] call TREND_fnc_notify}];
	};

	true;
}
else {
	[(localize "STR_TRGM2_ServerSave_SaveError")] call TREND_fnc_notify;
	false;
};

false;