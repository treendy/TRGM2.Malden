/*
 * Author: Trendy (Modified by TheAce0296)
 * Applies selected mission settings and sets
 * global variables signal the rest of the mission
 * to generate.
 *
 * Arguments:
 * 0 - Control that called this function. <CONTROL>
 * 1 - Savetype to load mission data from. <NUMBER> [Default: 0]
 *     0 = None, 1 = Local Load, 2 = Global Load
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [_this, 1] spawn TREND_fnc_SetParamsAndBegin
 */

params["_thisBeginControl","_SaveType"]; //_SaveType optional, default 0  (1 is local load, 2 is global load)
if (isNil "_SaveType") then {_SaveType = 0};
if (_SaveType > 2) then {_SaveType = 0};

disableSerialization;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (TREND_ForceMissionSetup) then {
	TREND_bAndSoItBegins =  true; publicVariable "TREND_bAndSoItBegins";
	TREND_bOptionsSet =  true; publicVariable "TREND_bOptionsSet";
	closedialog 0;
}
else {

	if (_SaveType == 0) then {

		_ctrlItem = (findDisplay 5000) displayCtrl 5500;
		TREND_iMissionParamType = TREND_MissionParamTypesValues select lbCurSel _ctrlItem;
		publicVariable "TREND_iMissionParamType";

		_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
		TREND_iMissionParamObjective = TREND_MissionParamObjectivesValues select lbCurSel _ctrlTypes;
		publicVariable "TREND_iMissionParamObjective";

		_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
		TREND_iAllowNVG = TREND_MissionParamNVGOptionsValues select lbCurSel _ctrlNVG;
		publicVariable "TREND_iAllowNVG";

		_ctrlRep = (findDisplay 5000) displayCtrl 5100;
		TREND_iMissionParamRepOption = TREND_MissionParamRepOptionsValues select lbCurSel _ctrlRep;
		publicVariable "TREND_iMissionParamRepOption";


		_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
		TREND_iWeather = TREND_MissionParamWeatherOptionsValues select lbCurSel _ctrlWeather;
		publicVariable "TREND_iWeather";

		_ctrlTime = (findDisplay 5000) displayCtrl 5115;
		_ctrlTimeValue = (sliderPosition _ctrlTime) * 3600;
		TREND_arrayTime = [floor (_ctrlTimeValue / 3600), floor ((_ctrlTimeValue / 60) mod 60)];
		publicVariable "TREND_arrayTime";

		_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
		TREND_iUseRevive = TREND_MissionParamReviveOptionsValues select lbCurSel _ctrlRevive;
		publicVariable "TREND_iUseRevive";

		_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
		TREND_iStartLocation = TREND_MissionParamLocationOptionsValues select lbCurSel _ctrlLocation;
		publicVariable "TREND_iStartLocation";

		if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
			_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
			TREND_iMissionParamObjective2 = TREND_MissionParamObjectivesValues select lbCurSel _ctrlTypes1;
			publicVariable "TREND_iMissionParamObjective2";
		};
		if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
			_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
			TREND_iMissionParamObjective3 = TREND_MissionParamObjectivesValues select lbCurSel _ctrlTypes2;
			publicVariable "TREND_iMissionParamObjective3";
		};

		publicVariable "TREND_AdvancedSettings";
		publicVariable "TREND_EnemyFactionData";
		publicVariable "TREND_LoadoutData";
		publicVariable "TREND_LoadoutDataDefault";


		_savePreviousSettings = [
			TREND_iMissionParamType,
			TREND_iMissionParamObjective,
			TREND_iAllowNVG,
			TREND_iMissionParamRepOption,
			TREND_iWeather,
			TREND_iUseRevive,
			TREND_iStartLocation,
			TREND_AdvancedSettings,
			TREND_EnemyFactionData,
			TREND_LoadoutData,
			TREND_arrayTime
		];
		profileNamespace setVariable [worldname + ":PreviousSettings",_savePreviousSettings];
		saveProfileNamespace;


		TREND_bOptionsSet =  true; publicVariable "TREND_bOptionsSet";
		closedialog 0;

	};

	TREND_sInitialSLPlayerID =  getPlayerUID player; publicVariable "TREND_sInitialSLPlayerID"; //store the uid of the player picking the params at the start of a campaign, so when we save, we know the uid to save against even if he is killed!
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
		TREND_SaveTypeString =  _LoadVersion; publicVariable "TREND_SaveTypeString";
		sleep 0.1;
		{
			TREND_SavedData = profileNamespace getVariable [TREND_sInitialSLPlayerID + ":" + TREND_SaveTypeString,[]]; //Get this from server only, but use player ID!!!
			publicVariable "TREND_SavedData";
			//_ctrl ctrlSetText "SavedData: " + SavedData;
		} remoteExec ["call", 2]; //Save this to server only
		sleep 0.1;

		if (count TREND_SavedData == 0) then {
			_ctrl = (findDisplay 5000) displayCtrl 5001;
			_ctrl ctrlSetText (localize "STR_TRGM2_SetParamsAndBegin_ErrorMsg_NoData");
		}
		else {

			TREND_iMissionParamType =  TREND_SavedData select 0; publicVariable "TREND_iMissionParamType";
			TREND_iMissionParamObjective =  TREND_SavedData select 1; publicVariable "TREND_iMissionParamObjective";
			TREND_iAllowNVG =  TREND_SavedData select 2; publicVariable "TREND_iAllowNVG";
			TREND_iMissionParamRepOption =   TREND_SavedData select 3; publicVariable "TREND_iMissionParamRepOption";
			TREND_iWeather =  TREND_SavedData select 4; publicVariable "TREND_iWeather";
			if (count TREND_SavedData > 14) then {
				TREND_arrayTime = TREND_SavedData select 14; publicVariable "TREND_arrayTime";
			};

			TREND_iUseRevive =  TREND_SavedData select 5; publicVariable "TREND_iUseRevive";
			TREND_iStartLocation =  TREND_SavedData select 6; publicVariable "TREND_iStartLocation";
			TREND_BadPoints =  TREND_SavedData select 7; publicVariable "TREND_BadPoints";
			TREND_MaxBadPoints =  TREND_SavedData select 8; publicVariable "TREND_MaxBadPoints";
			TREND_BadPointsReason =  TREND_SavedData select 9; publicVariable "TREND_BadPointsReason";
			TREND_iCampaignDay =  TREND_SavedData select 10; publicVariable "TREND_iCampaignDay";

			if (count TREND_SavedData > 11) then { //12 values, 11 indexes (savedData 11 is the 12th value)
				TREND_AdvancedSettings =  TREND_SavedData select 11; publicVariable "TREND_AdvancedSettings";
			};
			if (count TREND_SavedData > 12) then {
				TREND_EnemyFactionData =  TREND_SavedData select 12; publicVariable "TREND_EnemyFactionData";
			};
			if (count TREND_SavedData > 13) then {
				TREND_LoadoutData =  TREND_SavedData select 13; publicVariable "TREND_LoadoutData";
			};


			TREND_SaveType =  _SaveType; publicVariable "TREND_SaveType";

			TREND_bAndSoItBegins = true; publicVariable "TREND_bAndSoItBegins";
			TREND_bOptionsSet = true; publicVariable "TREND_bOptionsSet";
			closedialog 0;
		};
	};
};


TREND_bOptionsSet = true; publicVariable "TREND_bOptionsSet";

true;