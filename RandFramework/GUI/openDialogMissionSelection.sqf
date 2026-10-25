disableSerialization;


if (isNil "InitialLoadedPreviousSettings" && !ForceMissionSetup) then {
	InitialLoadedPreviousSettings = profileNamespace getVariable [worldname + ":PreviousSettings",Nil]; //Get this from server only, but use player ID!!!
	if (!isNil "InitialLoadedPreviousSettings") then {
		if (count InitialLoadedPreviousSettings > 0) then {
			iMissionParamType = InitialLoadedPreviousSettings select 0;
			publicVariable "iMissionParamType";
			iAllowNVG = InitialLoadedPreviousSettings select 2;
			publicVariable "iAllowNVG";	
			iMissionParamRepOption =  InitialLoadedPreviousSettings select 3;
			publicVariable "iMissionParamRepOption";
			iWeather = InitialLoadedPreviousSettings select 4;
			publicVariable "iWeather";
			iUseRevive = InitialLoadedPreviousSettings select 5;
			publicVariable "iUseRevive";
			iStartLocation = InitialLoadedPreviousSettings select 6;
			publicVariable "iStartLocation";
			
			AdvancedSettings = InitialLoadedPreviousSettings select 7; 
			if isNil("AdvancedSettings") then {AdvancedSettings = DefaultAdvancedSettings};
			publicVariable "AdvancedSettings";
			
			EnemyFactionData = InitialLoadedPreviousSettings select 8; 
			if isNil("EnemyFactionData") then {EnemyFactionData = ""};
			publicVariable "EnemyFactionData";

			LoadoutData = InitialLoadedPreviousSettings select 9; 
			if isNil("LoadoutData") then {LoadoutData = ""};
			publicVariable "LoadoutData";

			if (count AdvancedSettings < 6) then {
				AdvancedSettings pushBack 10;
			};
			if (count AdvancedSettings < 7) then {
				AdvancedSettings pushBack (DefaultEnemyFactionValue select 0);
			};
			if (AdvancedSettings select 6 == 0) then { //we had an issue with some being set to zero (due to a bad published version, this makes sure any zeros are adjusted to correct id)
				AdvancedSettings set [6,DefaultEnemyFactionValue select 0];
			};

			if (count AdvancedSettings < 8) then {
				AdvancedSettings pushBack (DefaultFriendlyFactionValue select 0);
			};

			if !(AdvancedSettings select 6 in DefaultEnemyFactionArray) then {
				_bFound = false;
				{
					if (!_bFound && _x in DefaultEnemyFactionArray) then {
						_bFound = true;
						AdvancedSettings set [6,_x];
					};
				} forEach DefaultEnemyFactionValue;
			};
			if !(AdvancedSettings select 7 in DefaultFriendlyFactionArray) then {
				_bFound = false;
				{
					if (!_bFound && _x in DefaultFriendlyFactionArray) then {
						_bFound = true;
						AdvancedSettings set [7,_x];
					};
				} forEach DefaultFriendlyFactionValue;
			};

			if (count AdvancedSettings < 9) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 8);
			};
			if (count AdvancedSettings < 10) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 9);
			};
			if (count AdvancedSettings < 11) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 10);
			};
			if (count AdvancedSettings < 12) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 11);
			};
			if (count AdvancedSettings < 13) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 12);
			};
			if (count AdvancedSettings < 14) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 13);
			};
			if (count AdvancedSettings < 15) then {
				AdvancedSettings pushBack (DefaultAdvancedSettings select 14);
			};

			if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
				if (iUseRevive != 0) then { //Ace is active, so need to make sure "no revive" is selected
					iUseRevive = 0;
					publicVariable "iUseRevive";
				};
			};
		};
	};	
	InitialLoadedPreviousSettings = []; // no longer Nil, so will not reload our previously saved data and change any current changes
};

[] call TRGM_fnc_readAdvancedSettings;

closedialog 0;

sleep 0.1;

if (isNil("ForceMissionSetup")) then {
	ForceMissionSetup = false;
	publicVariable "ForceMissionSetup";
};
if (ForceMissionSetup) then {
	[_this] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf';
}
else {
	createDialog "Trend_DialogSetupParams";
	waitUntil {!isNull (findDisplay 5000);};

	//[idc, options, values, current value]
	private _combos = [
		[5500, MissionParamTypes, MissionParamTypesValues, iMissionParamType],
		[5104, MissionParamObjectives, MissionParamObjectivesValues, iMissionParamObjective],
		[5100, MissionParamRepOptions, MissionParamRepOptionsValues, iMissionParamRepOption],
		[5101, MissionParamWeatherOptions, MissionParamWeatherOptionsValues, iWeather],
		[5102, MissionParamNVGOptions, MissionParamNVGOptionsValues, iAllowNVG],
		[5103, MissionParamReviveOptions, MissionParamReviveOptionsValues, iUseRevive],
		[2105, MissionParamLocationOptions, MissionParamLocationOptionsValues, iStartLocation]
	];
	//fill every combo first, then select (selecting the mission type runs MissionTypeSelection.sqf, which uses the other combos)
	{
		_x params ["_idc", "_options"];
		private _ctrl = (findDisplay 5000) displayCtrl _idc;
		{
			_ctrl lbAdd _x;
		} forEach _options;
	} forEach _combos;
	{
		_x params ["_idc", "", "_values", "_current"];
		((findDisplay 5000) displayCtrl _idc) lbSetCurSel (_values find _current);
	} forEach _combos;
	if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
		((findDisplay 5000) displayCtrl 5103) ctrlEnable false;
	};
};

