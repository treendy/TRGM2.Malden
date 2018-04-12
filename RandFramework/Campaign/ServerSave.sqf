//Note: this will always save on the server, if local or single player, will save on client, otherwise, if dedicated, will save on dedicated server, reason, if player who has saved the mission
// disconnects, we will not be able to save it to the client, so we store that players ID and store it on the server (I think i have disabled this for single player... as they can save/load anyway)
// future update may allow this to be saved on single player, incase they want to run campaign on mixed maps

params["_SaveType","_IsFirstSave"];

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
	SaveType = _SaveType;
	publicVariable "SaveType";
	SaveTypeString = _SaveVersion;
	publicVariable "SaveTypeString";
	sleep 0.1;
	{
		_saveData = [iMissionParamType,iMissionParamObjective,iAllowNVG,iMissionParamRepOption,iWeather,iUseRevive,iStartLocation,BadPoints,MaxBadPoints,BadPointsReason,iCampaignDay,AdvancedSettings,EnemyFactionData,LoadoutData];
		profileNamespace setVariable [sInitialSLPlayerID + ":" + SaveTypeString,_saveData];
		saveProfileNamespace;
	} remoteExec ["bis_fnc_call", 2]; //Save this to server only


	laptop1 remoteExec ["removeAllActions"];

	if (SaveType == 1) then {
		if (_IsFirstSave) then {hint (localize "STR_TRGM2_ServerSave_Save1");};
		[laptop1, [localize "STR_TRGM2_ServerSave_SaveLocal",{hint (localize "STR_TRGM2_ServerSave_SaveHint")}]] remoteExec ["addAction", 0];

	}
	else {
		if (_IsFirstSave) then {hint (localize "STR_TRGM2_ServerSave_Save2");};
		laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveGlobal",{hint (localize "STR_TRGM2_ServerSave_SaveHint")}];
	};


}
else {
	hint (localize "STR_TRGM2_ServerSave_SaveError");
};