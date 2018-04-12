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
		if (_IsFirstSave) then {hint "This campaign will saved each time your reputation changes.\n\nOnly you will be able to load this save data!\n\nThis save is only available to the current map";};
		[laptop1, ["Campaign saves as Local",{hint "This mission will save only on the current map.\n\nEach time your reputation adjusts, the data will save automatically."}]] remoteExec ["addAction", 0];

	}
	else {
		if (_IsFirstSave) then {hint "This campaign will saved each time your reputation changes.\n\nOnly you will be able to load this save data!\n\nThis save will be available on any map running TRGM2";};
		laptop1 addAction ["Campaign saves as Global",{hint "This mission will save only on the current map.\n\nEach time your reputation adjusts, the data will save automatically."}];	
	};

	
}
else {
	hint "Problem saving... local or global save not set";
};