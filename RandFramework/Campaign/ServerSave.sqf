params["_SaveType","_IsFirstSave"];

//sInitialSLPlayerID
_SaveVersion = "";
if (_SaveType == 1) then {
	_SaveVersion = "LOCAL"
};
if (_SaveType == 2) then {
	_SaveVersion = worldName
};


if (_SaveVersion != "") then {
	//sInitialSLPlayerID
	SaveType = _SaveType;
	publicVariable "SaveType";
	SaveTypeString = _SaveVersion;
	publicVariable "SaveTypeString";
	sleep 0.1;
	{
		_saveData = [iMissionParamType,iMissionParamObjective,iAllowNVG,iMissionParamRepOption,iWeather,iUseRevive,iStartLocation,BadPoints,MaxBadPoints,BadPointsReason,iCampaignDay,AdvancedSettings,EnemyFactionData];
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