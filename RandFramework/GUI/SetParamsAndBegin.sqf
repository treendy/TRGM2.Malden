params["_thisBeginControl","_SaveType"]; //_SaveType optional, default 0  (1 is local load, 2 is global load)
if (isNil "_SaveType") then {_SaveType = 0};

disableSerialization;

if (ForceMissionSetup) then {
	bAndSoItBegins = true;
	publicVariable 'bAndSoItBegins';
	bOptionsSet = true;
	publicVariable 'bOptionsSet';
	closedialog 0;
}
else {

	if (_SaveType == 0) then {

		[] call TRGM_fnc_readMainParams;
		
		publicVariable "AdvancedSettings";
		publicVariable "EnemyFactionData";
		publicVariable "LoadoutData";
		publicVariable "LoadoutDataDefault";


		_savePreviousSettings = [iMissionParamType,iMissionParamObjective,iAllowNVG,iMissionParamRepOption,iWeather,iUseRevive,iStartLocation,AdvancedSettings,EnemyFactionData,LoadoutData];
		profileNamespace setVariable [worldname + ":PreviousSettings",_savePreviousSettings];
		saveProfileNamespace;

	
		TRGM_iSetOptions = true; //local: this machine chose the options, so mainInit here does the AO selection and starts the mission
		bOptionsSet = true;
		publicVariable 'bOptionsSet';
		closedialog 0;

	};

	sInitialSLPlayerID = getPlayerUID player; //store the uid of the player picking the params at the start of a campaign, so when we save, we know the uid to save against even if he is killed!
	publicVariable "sInitialSLPlayerID";
	sleep 0.1;

	_LoadVersion = "";
	if (_SaveType == 1) then {
		_LoadVersion = worldName;
	};
	if (_SaveType == 2) then {
		_LoadVersion = "GLOBAL";
	};


if (_LoadVersion != "") then {
		SaveTypeString = _LoadVersion;
		publicVariable "SaveTypeString";
		sleep 0.1;
		SavedData = nil; //so we can wait for the server's answer (and don't use the result of an earlier click)
		{
			SavedData = profileNamespace getVariable [sInitialSLPlayerID + ":" + SaveTypeString,[]]; //Get this from server only, but use player ID!!!
			publicVariable "SavedData";
		} remoteExec ["bis_fnc_call", 2]; //Save this to server only
		_timeOut = diag_tickTime + 10;
		waitUntil {sleep 0.1; !isNil "SavedData" || diag_tickTime > _timeOut};
		if (isNil "SavedData") then {SavedData = [];};

		if (count SavedData == 0) then {
			_ctrl = (findDisplay 5000) displayCtrl 5001;
			_ctrl ctrlSetText (localize "STR_TRGM2_SetParamsAndBegin_ErrorMsg_NoData");
		}
		else {

			iMissionParamType = SavedData select 0;
			publicVariable "iMissionParamType";
			iMissionParamObjective = SavedData select 1;
			publicVariable "iMissionParamObjective";
			iAllowNVG = SavedData select 2;
			publicVariable "iAllowNVG";
			iMissionParamRepOption =  SavedData select 3;
			publicVariable "iMissionParamRepOption";
			iWeather = SavedData select 4;
			publicVariable "iWeather";
			iUseRevive = SavedData select 5;
			publicVariable "iUseRevive";
			iStartLocation = SavedData select 6;
			publicVariable "iStartLocation";

			BadPoints = SavedData select 7;
			MaxBadPoints = SavedData select 8;
			BadPointsReason = SavedData select 9;
			iCampaignDay = SavedData select 10;
			publicVariable "BadPoints";
			publicVariable "MaxBadPoints";
			publicVariable "BadPointsReason";
			publicVariable "iCampaignDay";

			if (count SavedData > 11) then { //12 values, 11 indexes (savedData 11 is the 12th value)
				AdvancedSettings = +(SavedData select 11);
				//saves from older versions have fewer advanced settings, fill the rest with the defaults
				while {count AdvancedSettings < count DefaultAdvancedSettings} do {
					AdvancedSettings pushBack (DefaultAdvancedSettings select (count AdvancedSettings));
				};
				publicVariable "AdvancedSettings";
			};
			if (count SavedData > 12) then {
				EnemyFactionData = SavedData select 12;
				publicVariable "EnemyFactionData";
			};
			if (count SavedData > 13) then {
				LoadoutData = SavedData select 13;
				publicVariable "LoadoutData";
			};


			SaveType = _SaveType;
			publicVariable "SaveType";

			bAndSoItBegins = true;
			publicVariable 'bAndSoItBegins';
			bOptionsSet = true;
			publicVariable 'bOptionsSet';
			closedialog 0;			
		};
	};
};