/*
 * Author: Trendy
 * Opens the custom enemy faction dialog.
 *
 * Arguments: None
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [] spawn TREND_fnc_openDialogEnemyFaction
 */

disableSerialization;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

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
			TREND_debugMessages = TREND_debugMessages + "\n\nHERE:" + str(lbCurSel _ctrlItem);
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

createDialog "Trend_DialogSetupEnemyFaction";
waitUntil {!isNull (findDisplay 7000);};

_display = findDisplay 7000;
_lineHeight = 0.03;

_display ctrlCreate ["RscText", 7999];
_lblctrlTitle = _display displayCtrl 7999;
_lblctrlTitle ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
ctrlSetText [7999,  localize "STR_TRGM2_openDialogEnemyFaction_SetEnemyFaction"];
_lblctrlTitle ctrlCommit 0;

_display ctrlCreate ["RscEditMulti", 7998];
_lblctrlData = _display displayCtrl 7998;
_lblctrlData ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.30 + 0) * safezoneH + safezoneY,0.18 * safezoneW,0.40 * safezoneH];
_lblctrlData ctrlCommit 0;
ctrlSetText [7998,  TREND_EnemyFactionData];


_display ctrlCreate ["RscTextMulti", 7996];
_lblctrlMessage = _display displayCtrl 7996;
_lblctrlMessage ctrlSetPosition [0.5 * safezoneW + safezoneX, (0.50 + 0) * safezoneH + safezoneY,0.18 * safezoneW,0.20 * safezoneH];
_lblctrlMessage ctrlCommit 0;
ctrlSetText [7996,  ""];

_display ctrlCreate ["RscTextMulti", 7995];
_lblctrlMessage = _display displayCtrl 7995;
_lblctrlMessage ctrlSetPosition [0.5 * safezoneW + safezoneX, (0.30 + 0) * safezoneH + safezoneY,0.18 * safezoneW,0.40 * safezoneH];
_lblctrlMessage ctrlCommit 0;
ctrlSetText [7995,  localize "STR_TRGM2_openDialogEnemyFaction_URL"];


_display ctrlCreate ["RscButton", 7997];
_btnSetEnemyFaction = _display displayCtrl 7997;
_btnSetEnemyFaction ctrlSetPosition [0.5 * safezoneW + safezoneX, (0.72 + 0) * safezoneH + safezoneY,0.06 * safezoneW,0.02 * safezoneH];
ctrlSetText [7997,  localize "STR_TRGM2_openDialogEnemyFaction_SaveAndBack"];
_btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {
	//LOADENEMYFACTION
	_TempEnemyFactionData = ctrlText 7998;
	if (_TempEnemyFactionData != "") then {
		_errorMessage = "";
		_ObjectPairs = _TempEnemyFactionData splitString ";";
		{
			_fullObj = _x;
			_pair = _x splitString "=";
			_title = str(((_pair select 0) splitString " ") select 0);
			_class = (_pair select 1 splitString """");

			if (!isNil("_class") && !isNil("_title")) then {
				if (count _class > 1) then {
 				 	_class = _class select 1;
				}
				else {
 			 		_class = _class select 0;
				};
				_classArray = [];
				if (typeName _class == "ARRAY") then {
					_classArray = _class;
				}
				else {
					_classArray = [_class];
				};

				{
					_className = _x;
					if (str(_className) != "") then {
						if (isClass (configFile >> "CfgVehicles" >> _className)) then {
							//call compile _fullObj;
						}
						else {
							_errorMessage = _errorMessage + format[localize "STR_TRGM2_openDialogEnemyFaction_ErrorMsg_NotExist",_fullObj,_x];
						};
					}
					else {
						_errorMessage = _errorMessage + format[localize "STR_TRGM2_openDialogEnemyFaction_ErrorMsg_CantEmpty",_fullObj,_x];
					};

				} forEach _classArray;
			};
		} forEach _ObjectPairs;
		if (_errorMessage != "") then {
			ctrlSetText [7996,  _errorMessage];
		}
		else {
			TREND_EnemyFactionData = _TempEnemyFactionData;
			[] spawn TREND_fnc_openDialogAdvancedMissionSettings; false;
		};
	}
	else {
		TREND_EnemyFactionData = "";
		[] spawn TREND_fnc_openDialogAdvancedMissionSettings; false;
	};
}];
_btnSetEnemyFaction ctrlCommit 0;