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
 * [_this, 1] spawn TRGM_GUI_fnc_setParamsAndBegin
 */

params["_thisBeginControl","_SaveType"]; //_SaveType optional, default 0  (1 is local load, 2 is global load)
if (isNil "_SaveType") then {_SaveType = 0};
if (_SaveType > 2) then {_SaveType = 0};

disableSerialization;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (TRGM_VAR_ForceMissionSetup) then {
	TRGM_VAR_bAndSoItBegins =  true; publicVariable "TRGM_VAR_bAndSoItBegins";
	TRGM_VAR_bOptionsSet =  true; publicVariable "TRGM_VAR_bOptionsSet";
	closedialog 0;
}
else {

	if (_SaveType isEqualTo 0) then {

		_ctrlItem = (findDisplay 5000) displayCtrl 5500;
		TRGM_VAR_iMissionParamType = TRGM_VAR_MissionParamTypesValues select lbCurSel _ctrlItem;
		publicVariable "TRGM_VAR_iMissionParamType";

		_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
		TRGM_VAR_iMissionParamObjective = TRGM_VAR_MissionParamObjectivesValues select lbCurSel _ctrlTypes;
		publicVariable "TRGM_VAR_iMissionParamObjective";

		_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
		TRGM_VAR_iAllowNVG = TRGM_VAR_MissionParamNVGOptionsValues select lbCurSel _ctrlNVG;
		publicVariable "TRGM_VAR_iAllowNVG";

		_ctrlRep = (findDisplay 5000) displayCtrl 5100;
		TRGM_VAR_iMissionParamRepOption = TRGM_VAR_MissionParamRepOptionsValues select lbCurSel _ctrlRep;
		publicVariable "TRGM_VAR_iMissionParamRepOption";


		_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
		TRGM_VAR_iWeather = TRGM_VAR_MissionParamWeatherOptionsValues select lbCurSel _ctrlWeather;
		publicVariable "TRGM_VAR_iWeather";

		_ctrlTime = (findDisplay 5000) displayCtrl 5115;
		_ctrlTimeValue = (sliderPosition _ctrlTime) * 3600;
		TRGM_VAR_arrayTime = [floor (_ctrlTimeValue / 3600), floor ((_ctrlTimeValue / 60) mod 60)];
		publicVariable "TRGM_VAR_arrayTime";

		_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
		TRGM_VAR_iUseRevive = TRGM_VAR_MissionParamReviveOptionsValues select lbCurSel _ctrlRevive;
		publicVariable "TRGM_VAR_iUseRevive";

		_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
		TRGM_VAR_iStartLocation = TRGM_VAR_MissionParamLocationOptionsValues select lbCurSel _ctrlLocation;
		publicVariable "TRGM_VAR_iStartLocation";

		if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
			_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
			TRGM_VAR_iMissionParamObjective2 = TRGM_VAR_MissionParamObjectivesValues select lbCurSel _ctrlTypes1;
			publicVariable "TRGM_VAR_iMissionParamObjective2";
		};
		if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
			_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
			TRGM_VAR_iMissionParamObjective3 = TRGM_VAR_MissionParamObjectivesValues select lbCurSel _ctrlTypes2;
			publicVariable "TRGM_VAR_iMissionParamObjective3";
		};

		publicVariable "TRGM_VAR_AdvancedSettings";
		publicVariable "TRGM_VAR_EnemyFactionData";
		publicVariable "TRGM_VAR_LoadoutData";
		publicVariable "TRGM_VAR_LoadoutDataDefault";


		_savePreviousSettings = [
			TRGM_VAR_iMissionParamType,
			TRGM_VAR_iMissionParamObjective,
			TRGM_VAR_iAllowNVG,
			TRGM_VAR_iMissionParamRepOption,
			TRGM_VAR_iWeather,
			TRGM_VAR_iUseRevive,
			TRGM_VAR_iStartLocation,
			TRGM_VAR_AdvancedSettings,
			TRGM_VAR_EnemyFactionData,
			TRGM_VAR_LoadoutData,
			TRGM_VAR_arrayTime
		];
		profileNamespace setVariable [worldname + ":PreviousSettings",_savePreviousSettings];
		saveProfileNamespace;


		TRGM_VAR_bOptionsSet =  true; publicVariable "TRGM_VAR_bOptionsSet";
		closedialog 0;

	};

	TRGM_VAR_sInitialSLPlayerID =  getPlayerUID player; publicVariable "TRGM_VAR_sInitialSLPlayerID"; //store the uid of the player picking the params at the start of a campaign, so when we save, we know the uid to save against even if he is killed!
	sleep 0.1;

	_LoadVersion = "";
	if (_SaveType isEqualTo 1) then {
		_LoadVersion = worldName;
	};
	if (_SaveType isEqualTo 2) then {
		_LoadVersion = "GLOBAL";
	};

	//_ctrl = (findDisplay 5000) displayCtrl 5001;
	//_ctrl ctrlSetText "test: " + sInitialSLPlayerID + ":" + _LoadVersion;

	if (_LoadVersion != "") then {
		TRGM_VAR_SaveTypeString =  _LoadVersion; publicVariable "TRGM_VAR_SaveTypeString";
		sleep 0.1;
		{
			TRGM_VAR_SavedData = profileNamespace getVariable [TRGM_VAR_sInitialSLPlayerID + ":" + TRGM_VAR_SaveTypeString,[]]; //Get this from server only, but use player ID!!!
			publicVariable "TRGM_VAR_SavedData";
			//_ctrl ctrlSetText "SavedData: " + SavedData;
		} remoteExec ["call", 2]; //Save this to server only
		sleep 0.1;

		if (count TRGM_VAR_SavedData isEqualTo 0) then {
			_ctrl = (findDisplay 5000) displayCtrl 5001;
			_ctrl ctrlSetText (localize "STR_TRGM2_SetParamsAndBegin_ErrorMsg_NoData");
		}
		else {

			TRGM_VAR_iMissionParamType =  TRGM_VAR_SavedData select 0; publicVariable "TRGM_VAR_iMissionParamType";
			TRGM_VAR_iMissionParamObjective =  TRGM_VAR_SavedData select 1; publicVariable "TRGM_VAR_iMissionParamObjective";
			TRGM_VAR_iAllowNVG =  TRGM_VAR_SavedData select 2; publicVariable "TRGM_VAR_iAllowNVG";
			TRGM_VAR_iMissionParamRepOption =   TRGM_VAR_SavedData select 3; publicVariable "TRGM_VAR_iMissionParamRepOption";
			TRGM_VAR_iWeather =  TRGM_VAR_SavedData select 4; publicVariable "TRGM_VAR_iWeather";
			if (count TRGM_VAR_SavedData > 14) then {
				TRGM_VAR_arrayTime = TRGM_VAR_SavedData select 14; publicVariable "TRGM_VAR_arrayTime";
			};

			TRGM_VAR_iUseRevive =  TRGM_VAR_SavedData select 5; publicVariable "TRGM_VAR_iUseRevive";
			TRGM_VAR_iStartLocation =  TRGM_VAR_SavedData select 6; publicVariable "TRGM_VAR_iStartLocation";
			TRGM_VAR_BadPoints =  TRGM_VAR_SavedData select 7; publicVariable "TRGM_VAR_BadPoints";
			TRGM_VAR_MaxBadPoints =  TRGM_VAR_SavedData select 8; publicVariable "TRGM_VAR_MaxBadPoints";
			TRGM_VAR_BadPointsReason =  TRGM_VAR_SavedData select 9; publicVariable "TRGM_VAR_BadPointsReason";
			TRGM_VAR_iCampaignDay =  TRGM_VAR_SavedData select 10; publicVariable "TRGM_VAR_iCampaignDay";

			if (count TRGM_VAR_SavedData > 11) then { //12 values, 11 indexes (savedData 11 is the 12th value)
				TRGM_VAR_AdvancedSettings =  TRGM_VAR_SavedData select 11; publicVariable "TRGM_VAR_AdvancedSettings";
			};
			if (count TRGM_VAR_SavedData > 12) then {
				TRGM_VAR_EnemyFactionData =  TRGM_VAR_SavedData select 12; publicVariable "TRGM_VAR_EnemyFactionData";
			};
			if (count TRGM_VAR_SavedData > 13) then {
				TRGM_VAR_LoadoutData =  TRGM_VAR_SavedData select 13; publicVariable "TRGM_VAR_LoadoutData";
			};


			TRGM_VAR_SaveType =  _SaveType; publicVariable "TRGM_VAR_SaveType";

			TRGM_VAR_bAndSoItBegins = true; publicVariable "TRGM_VAR_bAndSoItBegins";
			TRGM_VAR_bOptionsSet = true; publicVariable "TRGM_VAR_bOptionsSet";
			closedialog 0;
		};
	};
};


TRGM_VAR_bOptionsSet = true; publicVariable "TRGM_VAR_bOptionsSet";

true;