params["_thisBeginControl","_SaveType"]; //_SaveType optional, default 0  (1 is local load, 2 is global load)
if (isNil "_SaveType") then {_SaveType = 0};

#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;


if (_SaveType == 0) then {

	_ctrlItem = (findDisplay 5000) displayCtrl 5500;
	iMissionParamType = MissionParamTypesValues select lbCurSel _ctrlItem;
	publicVariable "iMissionParamType";

	_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
	iMissionParamObjective = MissionParamObjectivesValues select lbCurSel _ctrlTypes;
	publicVariable "iMissionParamObjective";

	_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
	iAllowNVG = MissionParamNVGOptionsValues select lbCurSel _ctrlNVG;
	publicVariable "iAllowNVG";

	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	iMissionParamRepOption = MissionParamRepOptionsValues select lbCurSel _ctrlRep;
	publicVariable "iMissionParamRepOption";


	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	iWeather = MissionParamWeatherOptionsValues select lbCurSel _ctrlWeather;
	publicVariable "iWeather";

	_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
	iUseRevive = MissionParamReviveOptionsValues select lbCurSel _ctrlRevive;
	publicVariable "iUseRevive";

	_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
	iStartLocation = MissionParamLocationOptionsValues select lbCurSel _ctrlLocation;
	publicVariable "iStartLocation";

	if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
		_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
		iMissionParamObjective2 = MissionParamObjectivesValues select lbCurSel _ctrlTypes1;
		publicVariable "iMissionParamObjective2";

		_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
		iMissionParamObjective3 = MissionParamObjectivesValues select lbCurSel _ctrlTypes2;
		publicVariable "iMissionParamObjective3";
	};
	
	publicVariable "AdvancedSettings";
	publicVariable "EnemyFactionData";
	publicVariable "LoadoutData";
	publicVariable "LoadoutDataDefault";


	_savePreviousSettings = [iMissionParamType,iMissionParamObjective,iAllowNVG,iMissionParamRepOption,iWeather,iUseRevive,iStartLocation,AdvancedSettings,EnemyFactionData,LoadoutData];
	profileNamespace setVariable [worldname + ":PreviousSettings",_savePreviousSettings];
	saveProfileNamespace;

	bAndSoItBegins = true;
	publicVariable 'bAndSoItBegins';
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

//_ctrl = (findDisplay 5000) displayCtrl 5001;
//_ctrl ctrlSetText "test: " + sInitialSLPlayerID + ":" + _LoadVersion;


if (_LoadVersion != "") then {
	SaveTypeString = _LoadVersion;
	publicVariable "SaveTypeString";
	sleep 0.1;
	{
		SavedData = profileNamespace getVariable [sInitialSLPlayerID + ":" + SaveTypeString,[]]; //Get this from server only, but use player ID!!!
		publicVariable "SavedData";
		//_ctrl ctrlSetText "SavedData: " + SavedData;
	} remoteExec ["bis_fnc_call", 2]; //Save this to server only
	sleep 0.1;

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
			AdvancedSettings = SavedData select 11;
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
		closedialog 0;
	};
};
