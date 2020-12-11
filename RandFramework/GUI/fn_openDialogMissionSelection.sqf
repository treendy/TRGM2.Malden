/*
 * Author: Trendy (Modified by TheAce0296)
 * Opens the main mission set up dialog.
 * Loads the previous settings if they exist.
 *
 * Arguments: None
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [] spawn TREND_fnc_openDialogMissionSelection
 */

disableSerialization;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
//profileNamespace setVariable [worldname + ":PreviousSettings",Nil];

if (isNil "TREND_InitialLoadedPreviousSettings" && !TREND_ForceMissionSetup) then {
	TREND_InitialLoadedPreviousSettings = profileNamespace getVariable [worldname + ":PreviousSettings",Nil]; //Get this from server only, but use player ID!!!
	if (!isNil "TREND_InitialLoadedPreviousSettings") then {
		if (count TREND_InitialLoadedPreviousSettings > 0) then {
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
			TREND_iMissionParamType =  TREND_InitialLoadedPreviousSettings select 0; publicVariable "TREND_iMissionParamType";
			//TREND_iMissionParamObjective =  TREND_InitialLoadedPreviousSettings select 1; publicVariable "TREND_iMissionParamObjective";
			TREND_iAllowNVG =  TREND_InitialLoadedPreviousSettings select 2; publicVariable "TREND_iAllowNVG";
			TREND_iMissionParamRepOption =  TREND_InitialLoadedPreviousSettings select 3; publicVariable "TREND_iMissionParamRepOption";
			TREND_iWeather =  TREND_InitialLoadedPreviousSettings select 4; publicVariable "TREND_iWeather";
			TREND_arrayTime = TREND_InitialLoadedPreviousSettings select 10; publicVariable "TREND_arrayTime";
			if (isNil "TREND_arrayTime") then { TREND_arrayTime =  [8, 15]; publicVariable "TREND_arrayTime"; };
			TREND_iUseRevive =  TREND_InitialLoadedPreviousSettings select 5; publicVariable "TREND_iUseRevive";
			TREND_iStartLocation =  TREND_InitialLoadedPreviousSettings select 6; publicVariable "TREND_iStartLocation";

			TREND_AdvancedSettings =  TREND_InitialLoadedPreviousSettings select 7; publicVariable "TREND_AdvancedSettings";
			if (isNil "TREND_AdvancedSettings") then { TREND_AdvancedSettings =   TREND_DefaultAdvancedSettings; publicVariable "TREND_AdvancedSettings"; };

			TREND_EnemyFactionData =  TREND_InitialLoadedPreviousSettings select 8; publicVariable "TREND_EnemyFactionData";
			if (isNil "TREND_EnemyFactionData") then { TREND_EnemyFactionData =   ""; publicVariable "TREND_EnemyFactionData"; };

			TREND_LoadoutData =  TREND_InitialLoadedPreviousSettings select 9; publicVariable "TREND_InitialLoadedPreviousSettings";
			if (isNil "TREND_LoadoutData") then { TREND_LoadoutData =   ""; publicVariable "TREND_LoadoutData"; };

			if (count TREND_AdvancedSettings < 6) then {
				TREND_AdvancedSettings pushBack 10;
			};
			if (count TREND_AdvancedSettings < 7) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultEnemyFactionValue select 0);
			};
			if (TREND_AdvancedSettings select 6 == 0) then { //we had an issue with some being set to zero (due to a bad published version, this makes sure any zeros are adjusted to correct id)
				TREND_AdvancedSettings set [6,TREND_DefaultEnemyFactionValue select 0];
			};

			if (count TREND_AdvancedSettings < 8) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultMilitiaFactionValue select 0);
			};

			if (count TREND_AdvancedSettings < 9) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultFriendlyFactionValue select 0);
			};

			if !(TREND_AdvancedSettings select 6 in TREND_DefaultEnemyFactionArray) then {
				_bFound = false;
				{
					if (!_bFound && _x in TREND_DefaultEnemyFactionArray) then {
						_bFound = true;
						TREND_AdvancedSettings set [6,_x];
					};
				} forEach TREND_DefaultEnemyFactionValue;
			};
			if !(TREND_AdvancedSettings select 7 in TREND_DefaultMilitiaFactionArray) then {
				_bFound = false;
				{
					if (!_bFound && _x in TREND_DefaultMilitiaFactionArray) then {
						_bFound = true;
						TREND_AdvancedSettings set [7,_x];
					};
				} forEach TREND_DefaultMilitiaFactionValue;
			};
			if !(TREND_AdvancedSettings select 8 in TREND_DefaultFriendlyFactionArray) then {
				_bFound = false;
				{
					if (!_bFound && _x in TREND_DefaultFriendlyFactionArray) then {
						_bFound = true;
						TREND_AdvancedSettings set [8,_x];
					};
				} forEach TREND_DefaultFriendlyFactionValue;
			};

			if (count TREND_AdvancedSettings < 10) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 9);
			};
			if (count TREND_AdvancedSettings < 11) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 10);
			};
			if (count TREND_AdvancedSettings < 12) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 11);
			};
			if (count TREND_AdvancedSettings < 13) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 12);
			};
			if (count TREND_AdvancedSettings < 14) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 13);
			};
			if (count TREND_AdvancedSettings < 15) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 14);
			};
			if (count TREND_AdvancedSettings < 16) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 15);
			};
			if (count TREND_AdvancedSettings < 17) then {
				TREND_AdvancedSettings pushBack (TREND_DefaultAdvancedSettings select 16);
			};

			if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
				if (TREND_iUseRevive != 0) then { //Ace is active, so need to make sure "no revive" is selected
					TREND_iUseRevive =  0; publicVariable "TREND_iUseRevive";
				};
			};
		};
	};
	TREND_InitialLoadedPreviousSettings = []; // no longer Nil, so will not reload our previously saved data and change any current changes
};

if (!isNull (findDisplay 6000)) then {
	TREND_AdvancedSettings = [];
	{
		_CurrentControl = _x;
		_lnpCtrlType = _x select 2;
		_ThisControlOptions = (_x select 4);
		_ThisControlIDX = (_x select 0) + 1;
		_ctrlItem = (findDisplay 6000) displayCtrl _ThisControlIDX;
		TREND_debugMessages = TREND_debugMessages + "\n\n" + str(lbCurSel _ctrlItem);
		publicVariable "TREND_debugMessages";
		_value = nil;
		if (_lnpCtrlType == "RscCombo") then {
			TREND_debugMessages = TREND_debugMessages + "\n\nHERE80:" + str(lbCurSel _ctrlItem);
			_value = _ThisControlOptions select (lbCurSel _ctrlItem);
		};
		if (_lnpCtrlType == "RscEdit") then {
			_value = ctrlText _ThisControlIDX;
		};
		TREND_AdvancedSettings pushBack _value;
	} forEach TREND_AdvControls;
	publicVariable "TREND_AdvancedSettings";

	//_ctrlItem = (findDisplay 6000) displayCtrl 5500;
	//TREND_iMissionParamType = TREND_MissionParamTypesValues select lbCurSel _ctrlItem;
	//publicVariable "TREND_iMissionParamType";
};

closedialog 0;

sleep 0.1;

if (isNil "TREND_ForceMissionSetup") then { TREND_ForceMissionSetup =   false; publicVariable "TREND_ForceMissionSetup"; };
if (TREND_ForceMissionSetup) then {
	[_this] spawn TREND_fnc_SetParamsAndBegin;
}
else {
	createDialog "Trend_DialogSetupParams";
	waitUntil {!isNull (findDisplay 5000);};
	//hint "opening 2dialogB";

	_ctrlItem = (findDisplay 5000) displayCtrl 5500;
	_optionItem = TREND_MissionParamTypes;
	{
		_ctrlItem lbAdd _x;
	} forEach _optionItem;

	_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
	_optionTypes = TREND_MissionParamObjectives;
	{
		_ctrlTypes lbAdd _x;
	} forEach _optionTypes;

	_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
	_optionNVG = TREND_MissionParamNVGOptions;
	{
		_ctrlNVG lbAdd _x;
	} forEach _optionNVG;

	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	_optionRep = TREND_MissionParamRepOptions;
	{
		_ctrlRep lbAdd _x;
	} forEach _optionRep;

	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	_optionWeathers = TREND_MissionParamWeatherOptions;
	{
		_ctrlWeather lbAdd _x;
	} forEach _optionWeathers;

	_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
	_optionRevive = TREND_MissionParamReviveOptions;
	{
		_ctrlRevive lbAdd _x;
	} forEach _optionRevive;

	_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
	_optionLocation = TREND_MissionParamLocationOptions;
	{
		_ctrlLocation lbAdd _x;
	} forEach _optionLocation;

	_ctrlItem lbSetCurSel (TREND_MissionParamTypesValues find TREND_iMissionParamType);
	_ctrlTypes lbSetCurSel (TREND_MissionParamObjectivesValues find TREND_iMissionParamObjective);
	_ctrlRep lbSetCurSel (TREND_MissionParamRepOptionsValues find TREND_iMissionParamRepOption);
	_ctrlWeather lbSetCurSel (TREND_MissionParamWeatherOptionsValues find TREND_iWeather);
	_ctrlNVG lbSetCurSel (TREND_MissionParamNVGOptionsValues find TREND_iAllowNVG);
	_ctrlRevive lbSetCurSel (TREND_MissionParamReviveOptionsValues find TREND_iUseRevive);
	if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
		_ctrlRevive ctrlEnable false;
	};
	_ctrlLocation lbSetCurSel (TREND_MissionParamLocationOptionsValues find TREND_iStartLocation);

	if ([8, 15] isEqualTo TREND_arrayTime) then {
		[nil, [date select 3, date select 4], "Init"] call TREND_fnc_timeSliderOnChange;
	} else {
		[nil, TREND_arrayTime, "Init"] call TREND_fnc_timeSliderOnChange;
	};

};

